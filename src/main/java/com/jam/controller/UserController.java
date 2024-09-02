package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.jam.dto.GoogleProfile;
import com.jam.dto.KakaoProfile;
import com.jam.dto.NaverProfile;
import com.jam.dto.OAuthToken;
import com.jam.dto.UserDTO;
import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.model.User;
import com.jam.service.UserService;
import com.jam.utils.googleOauth;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

	@Autowired
	private final HttpSession session;
	@Autowired
	private final UserService userService;

	@GetMapping("/sign-up")
	public String signUpPage() {
		return "user/signUp";

	}

	@PostMapping("/sign-up")
	public String signUp(signUpDTO dto) {
		userService.createUser(dto);
		return "redirect:/user/sign-in";
	}

	@GetMapping("/sign-in")
	public String signInPage() {
		return "user/signIn";

	}

	@PostMapping("/sign-in")

	public String signProc(UserDTO dto) {
		// 사용자 인증 로직
		UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
		session.setAttribute("principal", principal);
		System.out.println("principal : " + principal);
		// 세션에 사용자 정보를 등록
		return "redirect:/"; // 로그인 성공 시 메인 페이지로 리다이렉트
	}

	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		System.out.println("로그아웃성공");
		return "redirect:/";

	}

	/**
	 * 카카오 간편 회원가입
	 * 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * @param code
	 * @param model
	 * @return
	 */
	@GetMapping("/kakao")
//	@ResponseBody
	public String getMethodName(@RequestParam(name = "code") String code, Model model) {
		// 토큰 확인 전에 확인할 수 있는 카카오 코드 (인가 코드)
		System.out.println("code : " + code);

		RestTemplate rt1 = new RestTemplate();
		// RESTful API 웹 서비스와의 상호작용을 쉽게 외부 도메인에서 데이터를 가져오거나 전송할 때 사용되는 스프링 프레임워크의 클래스

		// 헤더 구성 (토큰 받기)
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 바디 구성
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("grant_type", "authorization_code");
		params1.add("client_id", "6d77c46fd0cf14b69558985620414300"); // da70bb7a1f4babcdcd8957d9785e99c4
		params1.add("redirect_uri", "http://localhost:8080/user/kakao");
		params1.add("code", code);

		// 헤더 + 바디 결합
		HttpEntity<MultiValueMap<String, String>> reqkakoMessage = new HttpEntity<>(params1, header1);

		// 통신 요청 (토큰 받기)
		ResponseEntity<OAuthToken> response1 = rt1.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				reqkakoMessage, OAuthToken.class);
		System.out.println("response1 <OAuthToken> : " + response1.getBody().toString());

		// 카카오 리소스서버 사용자 정보 가져오기 (토큰 갱신하기)
		RestTemplate rt2 = new RestTemplate();

		// 헤더
		HttpHeaders headers2 = new HttpHeaders();

		// 반드시 Bearer 값 다음에 공백 한칸 추가 !! (토큰 갱신하기)
		headers2.add("Authorization", "Bearer " + response1.getBody().getAccessToken());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HTTP Entity 만들기 (토큰 갱신하기)
		HttpEntity<MultiValueMap<String, String>> reqKakoInfoMessage = new HttpEntity<>(headers2);

		// 통신 요청 (토큰 갱신하기) // KakaoProfile
		ResponseEntity<KakaoProfile> resposne2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				reqKakoInfoMessage, KakaoProfile.class);

		KakaoProfile kakaoProfile = resposne2.getBody();
		// return kakaoProfile.toString();
		
		// 기존에 (카카오) 회원가입 되어있는지 정보 확인 (중복검사) -- ----------

		// ---- 카카오 사용자 정보 응답 완료 ----------

		// 최초 사용자라면 자동 회원 가입 처리 (우리 서버)
		// 회원가입 이력이 있는 사용자라면 바로 세션 처리 (우리 서버)
		// 사전기반 --> 소셜 사용자는 비밀번호를 입력하는가? 안하는가?
		// 우리서버에 회원가입시에 --> password -> not null (무건 만들어 넣어야 함 DB 정책)

		// 전화번호 +82 10-1234-5678 => 010-1234-5678 로 변경 (국제전화코드 제거)
		String internationalNumber = userService.convertPhoneNumber(kakaoProfile.getKakaoAccount().getPhoneNumber());

		// 전화번호 하이폰 제거 ex) 010-1234-5678 => 01012345678 로 변경
		String removeHypone = userService.removeHyphens(internationalNumber);

		signUpDTO user = signUpDTO.builder().nickName(kakaoProfile.getProperties().getNickname())
				.email(kakaoProfile.getKakaoAccount().getEmail()).phoneNumber(removeHypone) // +82 10-1234-5678 -->
																							// 010-1234-5678
				.password("1234").build();
		
		// 회원가입시 이메일 중복 체크
		int result = userService.checkEemail(user.getEmail());
	
		if(result == 0) {
			
			if (user != null) {
				// 회원가입
				userService.createUser(user);

				// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				UserDTO dto = UserDTO.builder()
						.email(kakaoProfile.getKakaoAccount().getEmail())
						.password(user.getPassword())
						.build();

				UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);

			}
			return "redirect:/";
			
		} else {
			UserDTO dto = UserDTO.builder()
					.email(kakaoProfile.getKakaoAccount().getEmail())
					.password(user.getPassword())
					.build();
			
			UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);
			
			userService.login(dto);
			return "user/signIn";
		}
		
	} // end of getMethodName();
	
	/**
	 * 로그인 페이지에서 카카오톡 간편 로그인 @@@@@
	 * @return
	 */
	@GetMapping("/kakaoLogin")
	public String kakoLogin(@RequestParam(name = "code") String code) {
		
		// 토큰 확인 전에 확인할 수 있는 카카오 코드 (인가 코드)
		System.out.println("code : " + code);

		RestTemplate rt1 = new RestTemplate();
		// RESTful API 웹 서비스와의 상호작용을 쉽게 외부 도메인에서 데이터를 가져오거나 전송할 때 사용되는 스프링 프레임워크의 클래스

		// 헤더 구성 (토큰 받기)
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 바디 구성
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("grant_type", "authorization_code");
		params1.add("client_id", "6d77c46fd0cf14b69558985620414300"); // da70bb7a1f4babcdcd8957d9785e99c4
		params1.add("redirect_uri", "http://localhost:8080/user/kakaoLogin");
		params1.add("code", code);

		// 헤더 + 바디 결합
		HttpEntity<MultiValueMap<String, String>> reqkakoMessage = new HttpEntity<>(params1, header1);

		// 통신 요청 (토큰 받기)
		ResponseEntity<OAuthToken> response1 = rt1.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				reqkakoMessage, OAuthToken.class);
		System.out.println("response1 <OAuthToken> : " + response1.getBody().toString()); 

		// 카카오 리소스서버 사용자 정보 가져오기 (토큰 갱신하기)
		RestTemplate rt2 = new RestTemplate();

		// 헤더
		HttpHeaders headers2 = new HttpHeaders();

		// 반드시 Bearer 값 다음에 공백 한칸 추가 !! (토큰 갱신하기)
		headers2.add("Authorization", "Bearer " + response1.getBody().getAccessToken());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HTTP Entity 만들기 (토큰 갱신하기)
		HttpEntity<MultiValueMap<String, String>> reqKakoInfoMessage = new HttpEntity<>(headers2);

		// 통신 요청 (토큰 갱신하기) // KakaoProfile
		ResponseEntity<KakaoProfile> resposne2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				reqKakoInfoMessage, KakaoProfile.class);

		KakaoProfile kakaoProfile = resposne2.getBody();
		
		// 카카오 이메일 존재 유무 체크
		int number = userService.checkEemail(kakaoProfile.getKakaoAccount().getEmail());
		// db에서 카카오 이메일이 검색되면 1을 반환 이메일이 없으면 0을 반환  1을 반환하면 메인페이지, 이메일이 없으면 회원가입 페이지
		if(number == 1) {
			
			// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			UserDTO dto = UserDTO.builder()
					.email(kakaoProfile.getKakaoAccount().getEmail())
					.password("1234")
					.build();
			
			// 로그인 기능
			userService.login(dto);
			
			UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);
			
			// return kakaoProfile.toString();
			return "redirect:/";
		} else {
			return "user/signUp";
		}
		
	}

	/**
	 * 네이버 간편 회원가입 
	 * 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * @param code
	 * @param model
	 * @return
	 */
	@GetMapping("/naver")
	public String getMethodNaver(@RequestParam(name = "code") String code, Model model) {

		RestTemplate rt1 = new RestTemplate();
		// 헤더 구성 (접근 토큰 발급 요청)
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		// 바디 구성
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("grant_type", "authorization_code");
		params1.add("client_id", "VV02L4roYlvMO2qxf3n7");
		params1.add("client_secret", "so4ce5BLjN");
		params1.add("code", code);

		// 헤더 + 바디 결합
		HttpEntity<MultiValueMap<String, String>> reqNaverMessage = new HttpEntity<>(params1, header1);

		// 통신 요청
		ResponseEntity<OAuthToken> response1 = rt1.exchange("https://nid.naver.com/oauth2.0/token", HttpMethod.POST,
				reqNaverMessage, OAuthToken.class);

		System.out.println("test : " + response1);

		System.out.println("response : " + response1.getBody().toString());

		// return response1.toString();

		// (접근 토큰을 이용하여 프로필 API 호출하기)
		RestTemplate rt2 = new RestTemplate();
		String accessToken = response1.getBody().getAccessToken(); // 토큰 확인
		System.out.println("accessToken : " + accessToken);
		// 헤더
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + accessToken);
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		// HTTP Entity 만들기
		HttpEntity<MultiValueMap<String, String>> reqNaverInfoMessage = new HttpEntity<>(headers2);

		// 통신 요청
		ResponseEntity<NaverProfile> response2 = rt2.exchange("https://openapi.naver.com/v1/nid/me", HttpMethod.POST,
				reqNaverInfoMessage, NaverProfile.class);

		NaverProfile naverProfile = response2.getBody();
		System.out.println("naverProfile : " + naverProfile.toString());

		// 전화번호 하이폰 제거 ex) 010-1234-5678 => 01012345678 로 변경
		String removeHypone = userService.removeHyphens(naverProfile.getResponse().getMobile());

		// 네이버 회원가입 dto 작동 확인
		signUpDTO user = signUpDTO.builder()
				// name, birth_date, gender, address, nick_name, phone_number, email, password,
				// admin_check
				.nickName(naverProfile.getResponse().getNickname())
				.email(naverProfile.getResponse().getEmail())
				.phoneNumber(removeHypone)
				.password("1234")
				.build();

		System.out.println(user.toString());
		
		// 회원가입시 이메일 중복 체크
		int result = userService.checkEemail(user.getEmail());
		
		if(result == 0) {
			
			if (user != null) {
				// 회원가입
				userService.createUser(user);

				// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				UserDTO dto = UserDTO.builder()
						.email(naverProfile.getResponse().getEmail())
						.password(user.getPassword())
						.build();

				UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);
			}
			return "redirect:/";
			
		} else {
			UserDTO dto = UserDTO.builder()
					.email(naverProfile.getResponse().getEmail())
					.password(user.getPassword())
					.build();
			
			UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);
			
			userService.login(dto);
			return "user/signIn";
		} 	
	} // end of naver
	
	/**
	 * 구글 간편 회원가입
	 * 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * @param code
	 * @return
	 */
	@GetMapping("/google")
	public String signingoogle(@RequestParam(name = "code") String code) {
		System.out.println("code : " + code);
		RestTemplate rt1 = new RestTemplate();
		// 헤더 구성
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 바디 구성
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("grant_type", "authorization_code");
		params1.add("client_id", googleOauth.CLIENT_ID);
		params1.add("client_secret", googleOauth.CLIENT_SECRET);
		params1.add("redirect_uri", "http://localhost:8080/user/google");
		params1.add("code", code);

		// 헤더 + 바디 결합
		HttpEntity<MultiValueMap<String, String>> reqGoogleMessage = new HttpEntity<>(params1, header1);

		// 통신 요청
		ResponseEntity<OAuthToken> response1 = rt1.exchange("https://oauth2.googleapis.com/token", HttpMethod.POST,
				reqGoogleMessage, OAuthToken.class);

		OAuthToken oauthToken = response1.getBody();
		System.out.println("Access Token: " + oauthToken.getAccessToken());

		System.out.println("response : " + response1.getBody().toString());
		// (토큰 갱신하기)
		RestTemplate rt2 = new RestTemplate();

		// 헤더
		HttpHeaders headers2 = new HttpHeaders();

		// 반드시 Bearer 값 다음에 공백 한칸 추가 !! (토큰 갱신하기)
		headers2.add("Authorization", "Bearer " + response1.getBody().getAccessToken());
		headers2.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); // Content-Type 헤더 추가

		// HTTP Entity 만들기 (토큰 갱신하기)
		HttpEntity<MultiValueMap<String, String>> reqGoogleInfoMessage = new HttpEntity<>(headers2);

		// 통신 요청 (토큰 갱신하기)
		ResponseEntity<GoogleProfile> resposne2 = rt2.exchange("https://www.googleapis.com/oauth2/v1/userinfo", // GoogleProfile
				HttpMethod.GET, reqGoogleInfoMessage, GoogleProfile.class);

		GoogleProfile googleProfile = resposne2.getBody();
//		return resposne2.toString();

		signUpDTO user = signUpDTO.builder()
				// name, birth_date, gender, address, nick_name, phone_number, email, password,
				// admin_check
				.nickName(googleProfile.getName())
				.email(googleProfile.getEmail())
				.phoneNumber("") // 구글은 휴대폰 번호를 api로			// 제공하지 않는거 같음
				.password("1234")
				.build();
		
		System.out.println(user.toString());
		
		// 회원가입시 이메일 중복 체크
		int result = userService.checkEemail(user.getEmail());
		
		// 회원가입이 안되어 있다면 db에서 0을 출력 회원가입 되어있다면 1을 출력
		if(result == 0) {
			
			if (user != null) {
				// 회원가입
				userService.createUser(user);

				// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				UserDTO dto = UserDTO.builder()
						.email(googleProfile.getEmail())
						.password(user.getPassword())
						.build();

				UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);

			}
			return "redirect:/";
			
		} else {
			// 1이 출력
			// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			UserDTO dto = UserDTO.builder()
					.email(googleProfile.getEmail())
					.password(user.getPassword())
					.build();
			
			userService.login(dto);
			
			UserDTO principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);
			
			return "redirect:/";
		}
	} // end of google

}
