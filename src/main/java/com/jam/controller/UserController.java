package com.jam.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.jam.dto.EmailVerificationResult;
import com.jam.dto.GoogleProfile;
import com.jam.dto.KakaoProfile;
import com.jam.dto.NaverProfile;
import com.jam.dto.OAuthToken;
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

	private final HttpSession session;
	private final UserService userService;

	// 회원가입 JSP 버튼 테스트
	@PostMapping("/messageTest")
	public String email(@RequestParam(name = "checkNickName") String checkNickName) {
		System.out.println("컨트롤러 성공");
		System.out.println("컨트롤러" + checkNickName);
		return "user/signIn";
	}

	/**
	 * 로그인 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/sign-up")
	public String signUpPage() {
		return "user/signUp";
	}

	/**
	 * 회원가입 페이지에서 회원가입 시도
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-up")
	public String signUp(signUpDTO dto) {
		/**
		 * DB에 저장되어 있는 이메일로 회원가입 시도할 시 checkEmail로 이메일 유무를 확인 후 emailCount = 1이면 email
		 * 존재 emailCount = 0 이면 DB에 이메일 없음
		 */
		int emailCount = userService.checkDuplicatedEmail(dto.getEmail());
		if (emailCount == 1) {
			return "user/signUp";
		} else {
			userService.createUser(dto);
		}
		return "redirect:/user/sign-in";
	}

	/**
	 * 로그인 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/sign-in")
	public String signInPage() {
		return "user/signIn";

	}

	/**
	 * 로그인 페이지 에서 로그인 시도
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-in")

	public String signProc(signInDTO dto) {
		// 사용자 인증 로직
		User principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
		session.setAttribute("principal", principal);
		System.out.println("principal : " + principal);
		// 세션에 사용자 정보를 등록
		return "redirect:/"; // 로그인 성공 시 메인 페이지로 리다이렉트
	}

	/**
	 * 로그아웃
	 * 
	 * @return
	 */
	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		System.out.println("로그아웃성공");
		return "redirect:/";

	}

	/**
	 * 카카오 간편 회원가입 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * 
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
		params1.add("client_id", "da70bb7a1f4babcdcd8957d9785e99c4"); // da70bb7a1f4babcdcd8957d9785e99c4
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

		signUpDTO dtoUp = signUpDTO.builder().nickName(kakaoProfile.getProperties().getNickname() + "_kakao")
				.email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao").password("1234").build();

		// 회원가입시 이메일 중복 체크
		int result = userService.checkDuplicatedEmail(dtoUp.getEmail());
		System.out.println("result : " + result);
		if (result == 0) {

			if (dtoUp != null) {
				// 회원가입
				userService.createUser(dtoUp);

				// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				signInDTO dtoIn = signInDTO.builder().email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao")
						.password(dtoUp.getPassword()).build();

				User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);

			}
			return "redirect:/";

		} else {
			signInDTO dtoIn = signInDTO.builder().email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao")
					.password(dtoUp.getPassword()).build();
			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			userService.login(dtoIn);
			// return "user/signIn";
			return "redirect:/";
		}

	} // end of getMethodName();

	/**
	 * 로그인 페이지에서 카카오톡 간편 로그인 @@@@@
	 * 
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
		params1.add("client_id", "da70bb7a1f4babcdcd8957d9785e99c4"); // da70bb7a1f4babcdcd8957d9785e99c4
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
		int number = userService.checkDuplicatedEmail(kakaoProfile.getKakaoAccount().getEmail() + "_kakao");
		// db에서 카카오 이메일이 검색되면 1을 반환 이메일이 없으면 0을 반환 1을 반환하면 메인페이지, 이메일이 없으면 회원가입 페이지
		if (number == 1) {

			// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			signInDTO dtoIn = signInDTO.builder().email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao")
					.password("1234").build();

			// 로그인 기능
			// userService.login(dto);

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			// return kakaoProfile.toString();
			return "redirect:/";
		} else {
			return "user/signUp";
		}

	}

	/**
	 * 네이버 간편 회원가입 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * 
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

		// 네이버 회원가입 dto 작동 확인
		signUpDTO dtoUp = signUpDTO.builder()
				// name, birth_date, gender, address, nick_name, phone_number, email, password,
				// admin_check
				.nickName(naverProfile.getResponse().getNickname() + "_naver")
				.email(naverProfile.getResponse().getEmail() + "_naver").password("1234").build();

		System.out.println(dtoUp.toString());

		// 회원가입시 이메일 중복 체크
		int result = userService.checkDuplicatedEmail(dtoUp.getEmail());
		System.out.println("result : " + result);
		if (result == 0) {

			if (dtoUp != null) {
				// 회원가입
				userService.createUser(dtoUp);

				// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				signInDTO dtoIn = signInDTO.builder().email(naverProfile.getResponse().getEmail() + "_naver")
						.password(dtoUp.getPassword()).build();

				User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환

				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);
			}
			return "redirect:/";

		} else {
			signInDTO dtoIn = signInDTO.builder().email(naverProfile.getResponse().getEmail() + "_naver")
					.password(dtoUp.getPassword()).build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			userService.login(dtoIn);
			// return "user/signIn";
			return "redirect:/";
		}
	} // end of naver

	/**
	 * 로그인 페이지에서 네이버 간편 로그인 @@@@@ @@@@@@@@@@@@@@@@@@
	 */
	@GetMapping("/naverLogin")
	public String naverLogin(@RequestParam(name = "code") String code) {

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

		// 네이버 이메일 유무 체크
		int number = userService.checkDuplicatedEmail(naverProfile.getResponse().getEmail() + "_naver");

		// db에서 카카오 이메일이 검색되면 1을 반환 이메일이 없으면 0을 반환 1을 반환하면 메인페이지, 이메일이 없으면 회원가입 페이지
		if (number == 1) {
			// signInDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			signInDTO dtoIn = signInDTO.builder().email(naverProfile.getResponse().getEmail() + "_naver")
					.password("1234").build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		} else {
			return "user/signUp";
		}
	}

	/**
	 * 구글 간편 회원가입 이미 회원가입한 기록이 있다면 자동 로그인처리
	 * 
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

		signUpDTO dtoUp = signUpDTO.builder()
				// name, birth_date, gender, address, nick_name, phone_number, email, password,
				// admin_check

				.nickName(googleProfile.getName() + "_google").email(googleProfile.getEmail() + "_google")
				.password("1234").build();

		System.out.println(dtoUp.toString());

		// 회원가입시 이메일 중복 체크
		int result = userService.checkDuplicatedEmail(dtoUp.getEmail());

		// 회원가입이 안되어 있다면 db에서 0을 출력 회원가입 되어있다면 1을 출력
		if (result == 0) {

			if (dtoUp != null) {
				// 회원가입
				userService.createUser(dtoUp);

				// signInDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
				signInDTO dtoIn = signInDTO.builder().email(googleProfile.getEmail() + "_google")
						.password(dtoUp.getPassword()).build();

				User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
				session.setAttribute("principal", principal);
				System.out.println("principal : " + principal);

			}
			return "redirect:/";

		} else {
			// 1이 출력
			// signInDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			signInDTO dtoIn = signInDTO.builder().email(googleProfile.getEmail() + "_google")
					.password(dtoUp.getPassword()).build();

			// userService.login(dtoIn);

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		}
	} // end of google

	/**
	 * 로그인 페이지에서 구글 간편 로그인 (구글 인증키 다른거 써야 함 - 정훈 -)
	 */
	@GetMapping("/googleLogin")
	public String googleLogin(@RequestParam(name = "code") String code) {

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
		params1.add("redirect_uri", "http://localhost:8080/user/googleLogin");
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

		// 반드시 Bearer 값 다음에 공백 한칸 추가 !! (토큰 갱신하기!)
		headers2.add("Authorization", "Bearer " + response1.getBody().getAccessToken());
		headers2.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); // Content-Type 헤더 추가

		// HTTP Entity 만들기 (토큰 갱신하기)
		HttpEntity<MultiValueMap<String, String>> reqGoogleInfoMessage = new HttpEntity<>(headers2);

		// 통신 요청 (토큰 갱신하기)
		ResponseEntity<GoogleProfile> resposne2 = rt2.exchange("https://www.googleapis.com/oauth2/v1/userinfo", // GoogleProfile
				HttpMethod.GET, reqGoogleInfoMessage, GoogleProfile.class);

		GoogleProfile googleProfile = resposne2.getBody();
		System.out.println(googleProfile.toString());
//		return googleProfile.toString();

		// 이메일 중복 체크
		int number = userService.checkDuplicatedEmail(googleProfile.getEmail() + "_google");

		if (number == 1) {

			// signInDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			signInDTO dtoIn = signInDTO.builder().email(googleProfile.getEmail() + "_google").password("1234").build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		} else {
			return "user/signUp";
		}
	} // end of googleLogin()

	/**
	 * 이메일 인증 메일 보내는 영역
	 * 
	 * @param email
	 * @return
	 */
	@PostMapping("/emails/verification-requests")
	public ResponseEntity<Void> sendMessage(@RequestParam("email") String email) {
		userService.sendCodeToEmail(email);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	/**
	 * 이메일 인증 확인 영역
	 * 
	 * @param email
	 * @param authCode
	 * @return
	 */
	@GetMapping("/emails/verifications")
	public ResponseEntity<EmailVerificationResult> verificationEmail(@RequestParam("email") String email,
			@RequestParam("code") String authCode) {

		EmailVerificationResult result = userService.verifiedCode(email, authCode);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/**
	 * 이메일 중복 체크 검사
	 * 
	 * @param email
	 * @return
	 */
	@GetMapping("/check-email")
	public ResponseEntity<String> checkEmail(@RequestParam("email") String email) {
		boolean isEmailExist = userService.isEmailDuplicate(email);

		if (isEmailExist) {
			// 이미 사용 중인 이메일인 경우 409 상태 코드 반환
			return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 이메일입니다.");
		} else {
			// 사용 가능한 이메일인 경우 200 상태 코드 반환
			return ResponseEntity.ok("사용 가능한 이메일입니다.");
		}
	}

	/**
	 * 닉네임 중복 체크 검사
	 * 
	 * @param nickName
	 * @return
	 */
	@GetMapping("/check-nickname")
	public ResponseEntity<Void> checkNickNameDuplicate(@RequestParam("nickName") String nickName) {
		if (userService.isNickNameDuplicate(nickName)) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build(); // 409 Conflict
		}
		return ResponseEntity.ok().build(); // 200 OK
	}

	/**
	 * 비밀 번호 찾기 핸들러
	 * 
	 * @return
	 */
	@GetMapping("/find-password")
	public String handleFindId() {
		return "user/findPassword";
	}

	/**
	 * 비밀 번호 찾기 및 수정 핸들러
	 * 
	 * @param newPassword
	 * @param email
	 * @return
	 */
	@PostMapping("/reset-password")
	public ResponseEntity<String> resetPasswordProc(@RequestParam("newPassword") String newPassword,
			@RequestParam("email") String email) {
		// 이메일과 비밀번호가 null이거나 빈 값인지 확인
		if (newPassword == null || newPassword.isEmpty() || email == null || email.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이메일과 비밀번호는 필수 항목입니다.");
		}

		int result = userService.updatePasswordByEmail(newPassword, email);

		if (result == 0) {
			// 비밀번호 변경 실패 시 처리
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("비밀번호 변경에 실패했습니다. 다시 시도하세요.");
		} else {
			// 비밀번호 변경 성공 시 처리
			return ResponseEntity.ok("비밀번호가 성공적으로 변경되었습니다.");
		}
	}

	@GetMapping("/find-email")
	public String getMethodName() {
		return "user/findEmail";
	}
	
}
