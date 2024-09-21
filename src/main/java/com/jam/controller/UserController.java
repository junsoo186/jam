package com.jam.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.EmailVerificationResult;
import com.jam.dto.GoogleProfile;
import com.jam.dto.KakaoProfile;
import com.jam.dto.NaverProfile;
import com.jam.dto.OAuthToken;
import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.model.User;
import com.jam.service.UserService;
import com.jam.utils.Define;
import com.jam.utils.googleOauth;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import com.jam.handler.exception.DataDeliveryException;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

	private final HttpSession session;
	private final UserService userService;

	// 회원가입 JSP 버튼 테스트
	@PostMapping("/messageTest")
	public String emailProc(@RequestParam(name = "checkNickName") String checkNickName) {
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
	public String handleSignUpPage() {
		return "user/signUp";
	}

	/**
	 * 회원가입 페이지에서 회원가입 시도
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-up")
	public String signUpProc(signUpDTO dto) {
		System.out.println("dto : " + dto.toString());
		userService.createUser(dto); // 유저 테이블 (user_tb)
		userService.createDetail(dto); // 유저 상세 정보 테이블 연결 (유저ID 외래키) (user_de_tb)

		return "redirect:/user/sign-in";
	}

	/**
	 * 로그인 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/sign-in")
	public String handleSignInPage() {
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
		
		if(dto.getEmail() == null || dto.getEmail().isEmpty()) {
			throw new DataDeliveryException(Define.ENTER_YOUR_USERNAME, HttpStatus.BAD_REQUEST);
		}
		
		if(dto.getPassword() == null || dto.getPassword().isEmpty()) {
			throw new DataDeliveryException(Define.ENTER_YOUR_PASSWORD, HttpStatus.BAD_REQUEST);
		}
		
		// 사용자 인증 로직
		User principal = userService.login(dto); // 로그인 시도 및 User 객체 반환
		// 세션에 사용자 정보를 등록
		// 이미지
		String profileImg = principal.setUpUserImage();
		principal.setProfileImg(profileImg);
		session.setAttribute("principal", principal);
		System.out.println("principal : " + principal);		
		return "redirect:/"; // 로그인 성공 시 메인 페이지로 리다이렉트
	}

	/**
	 * 로그아웃
	 * 
	 * @return
	 */
	@GetMapping("/logout")
	public String handleLogout() {
		session.invalidate();
		System.out.println("로그아웃성공");
		return "redirect:/";

	}

	/**
	 * 로그인 페이지에서 카카오톡 간편 로그인
	 * 
	 * @return
	 */
	@GetMapping("/kakaoLogin")
	public String handleKakoLogin(@RequestParam(name = "code") String code) {

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

		// db에서 카카오 이메일이 검색되면 1을 반환
		// 이메일이 없으면 0을 반환 1을 반환하면 메인페이지, 이메일이 없으면 회원가입 페이지
		if (number == 1) {

			// 로그인 진행

			// signUpDTO에 있는 값 (이메일, 패스워드)를 User dto 카카오에서 받은 이메일, 패스워드를 받음
			signInDTO dtoIn = signInDTO.builder().email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao")
					.password("1234").build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		} else {
			// 회원가입 DTO에 값 입력
			signUpDTO dtoUp = signUpDTO.builder().nickName(kakaoProfile.getProperties().getNickname() + "_kakao")
					.email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao").password("1234").build();
			// 로그인 DTO에 값 입력
			signInDTO dtoIn = signInDTO.builder().email(kakaoProfile.getKakaoAccount().getEmail() + "_kakao")
					.password(dtoUp.getPassword()).build();
			// 회원가입 진행
			userService.createUser(dtoUp); // 유저 테이블 (user_tb)
			userService.createDetail(dtoUp);  // 유저 상세 정보 테이블 연결 (유저ID 외래키) (user_de_tb)
			// 로그인 진행
			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			userService.login(dtoIn); 

			return "redirect:/";
		}

	} // end of kakoLogin()

	/**
	 * 로그인 페이지에서 네이버 간편 로그인 @@@@@ @@@@@@@@@@@@@@@@@@
	 */
	@GetMapping("/naverLogin")
	public String handleNaverLogin(@RequestParam(name = "code") String code) {

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

		// 네이버 이메일 존재 유무 체크
		int number = userService.checkDuplicatedEmail(naverProfile.getResponse().getEmail() + "_naver");

		// db에서 카카오 이메일이 검색되면 1을 반환
		// 이메일이 없으면 0을 반환 1을 반환하면 메인페이지, 이메일이 없으면 회원가입 페이지
		if (number == 1) {

			// 로그인 진행

			signInDTO dtoIn = signInDTO.builder().email(naverProfile.getResponse().getEmail() + "_naver")
					.password("1234").build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환

			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		} else {
			// 회원가입 DTO에 값 입력
			signUpDTO dtoUp = signUpDTO.builder().nickName(naverProfile.getResponse().getNickname() + "_naver")
					.email(naverProfile.getResponse().getEmail() + "_naver").password("1234").build();

			// 로그인 DTO에 값 입력
			signInDTO dtoIn = signInDTO.builder().email(naverProfile.getResponse().getEmail() + "_naver")
					.password(dtoUp.getPassword()).build();

			// 회원가입 진행
			userService.createUser(dtoUp); // 유저 테이블 (user_tb)
			userService.createDetail(dtoUp); // // 유저 상세 정보 테이블 연결 (유저ID 외래키) (user_de_tb)

			// 로그인 진행
			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환

			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			userService.login(dtoIn);

			return "redirect:/";
		}
	} // end of naverLogin()

	/**
	 * 로그인 페이지에서 구글 간편 로그인 (구글 인증키 다른거 써야 함 - 정훈 -)
	 */
	@GetMapping("/googleLogin")
	public String handleGoogleLogin(@RequestParam(name = "code") String code) {

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

		// 이메일 중복 체크
		int number = userService.checkDuplicatedEmail(googleProfile.getEmail() + "_google");

		if (number == 1) {

			// 로그인 진행

			signInDTO dtoIn = signInDTO.builder().email(googleProfile.getEmail() + "_google").password("1234").build();

			User principal = userService.login(dtoIn); // 로그인 시도 및 User 객체 반환
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			return "redirect:/";
		} else {
			// 회원가입 DTO에 값 입력
			signUpDTO dtoUp = signUpDTO.builder().nickName(googleProfile.getName() + "_google")
					.email(googleProfile.getEmail() + "_google").password("1234").build();

			// 로그인 DTO에 값 입력
			signInDTO dtoIn = signInDTO.builder().email(googleProfile.getEmail() + "_google")
					.password(dtoUp.getPassword()).build();

			// 회원가입 진행
			userService.createUser(dtoUp); // 유저 테이블 (user_tb)
			userService.createDetail(dtoUp); // // 유저 상세 정보 테이블 연결 (유저ID 외래키) (user_de_tb)

			// 로그인 진행
			User principal = userService.login(dtoIn);
			session.setAttribute("principal", principal);
			System.out.println("principal : " + principal);

			userService.login(dtoIn);

			return "redirect:/";
		}
	} // end of googleLogin()

	/**
	 * 이메일 인증 메일 보내는 영역
	 * 
	 * @param email
	 * @return
	 */
	@PostMapping("/emails/verification-requests")
	public ResponseEntity<Void> sendMessageProc(@RequestParam("email") String email) {
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
	public ResponseEntity<EmailVerificationResult> handleVerificationEmail(@RequestParam("email") String email,
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
	public ResponseEntity<String> handleCheckEmail(@RequestParam("email") String email) {
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
	
	@GetMapping("/charge")
	public String chargeCoin() {
		System.out.println("코인충전페이지");
		return "payment/charge";
	}
	
	/**
	 * 홈페이지 로그인 후 아이콘 클릭 시 유저 데이터 업데이트 후 작동?
	 * @return
	 */
	@GetMapping("/newSession")
	public String iconSession() {
		System.out.println("userController에서 프로필 아이콘 클릭");
		return "/view/index";
	}
	
	/**
	 * 마이페이지 이동
	 */
	@GetMapping("/myPage")
	public String getMyPage() {
		
//		User user2 = (User)session.getAttribute("principal");
//		
//		User user = userService.newSession(user2.getEmail()); // 세션값 변경준비
//		session.setAttribute("principal", user);  // 이메일을 통해 유저의 정보를 model에 담는다.

		return "user/myPage";
	}
	
	/**
	 * 마이페이지 회원정보 수정 페이지 이동
	 */
	@GetMapping("/profileSetting")
	public String getDetailMyPage() {
		
//		User user2 = (User)session.getAttribute("principal"); // 세션값 변경준비
//		
//		User user = userService.newSession(user2.getEmail()); // 이메일을 통해 유저의 정보를 model에 담는다.
//		session.setAttribute("principal", user);

		return "/user/myProfile";
	}
	
	/*
	 * 마이페이지 회원정보 수정 처리
	 */
	@PostMapping("/userModify1212")
	public String modifyPage(User user, @RequestParam("mFile") MultipartFile mFile) throws IllegalStateException, IOException {
		
		// 유저의 전화번호에 하이폰 -  있으면 toss 결제 인식안됨
		String removeHyphens = userService.removeHyphens(user.getPhoneNumber());
		
		user = User.builder()
				.userId(user.getUserId())
				.name(user.getName())
				.birthDate(user.getBirthDate())
				.address(user.getAddress())
				.nickName(user.getNickName())
				.phoneNumber(removeHyphens)
				.email(user.getEmail())
			//	.password(user.getPassword())
				.point(user.getPoint())
			//	.role(user.getRole())
			//	.createdAt(user.getCreatedAt())
				.profileImg(user.getProfileImg())
			//	.oriProfileImg(user.getOriProfileImg())
				.build();
		
		System.out.println("/userModify1212 : " + user.getPhoneNumber());
		
		 // 만약 mFile이 비어 있으면 기존 이미지 사용
	    if (mFile != null && !mFile.isEmpty()) {
	        // 고유 파일명 생성
	        String originalFilename = mFile.getOriginalFilename();
	        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.'));
	        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

	        // 파일 저장 경로 설정
	        String uploadDir = "C:/work_spring/upload/";
	        File destinationFile = new File(uploadDir + uniqueFileName);
	        mFile.transferTo(destinationFile); // 파일을 해당 경로에 저장

	        // 새로운 프로필 이미지 경로 업데이트
	        user.setProfileImg("/images/uploads/" + uniqueFileName);
	    } else {
	        // 파일이 없으면 기존 프로필 이미지 사용
	        user.setProfileImg(user.getProfileImg());
	    }
	    
	    // 유저 정보 업데이트
	    userService.updateProfile(user);
	    
	    // 업데이트된 유저 정보 가져와서 세션에 저장
	    User principal = userService.InformationUpdate(user.getEmail());
	    session.setAttribute("principal", principal);
		
		return "redirect:/";
	}
	
}
