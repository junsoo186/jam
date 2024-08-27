package com.jam.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.jam.dto.KakaoProfile;
import com.jam.dto.OAuthToken;
import com.jam.repository.model.User;
import com.jam.service.UserService;

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
	public String signUp() {
		return "redirect:/user/sign-in";
	}

	@GetMapping("/sign-in")
	public String signInPage() {
		return "user/signIn";

	}

	@PostMapping("/sign-in")
	public String signProc() {
		return "redirect:/index";
	}

	@GetMapping("/logout")
	public String logout() {
		return "redirect:/user/sign-in";

	}
	
	@GetMapping("/kakao")
//	@ResponseBody
	public String getMethodName(@RequestParam(name = "code") String code) {
		// 토큰 확인 전에 확인할 수 있는 카카오 코드 (인가 코드)
		System.out.println("code : " + code); 
		
		RestTemplate rt1 = new RestTemplate();
	//	RESTful API 웹 서비스와의 상호작용을 쉽게 외부 도메인에서 데이터를 가져오거나 전송할 때 사용되는 스프링 프레임워크의 클래스
		
		// 헤더 구성 (토큰 받기)
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 바디 구성
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("grant_type", "authorization_code");
		params1.add("client_id", "da70bb7a1f4babcdcd8957d9785e99c4");
		params1.add("redirect_uri", "http://localhost:8080/user/kakao");
		params1.add("code", code);
		
		// 헤더 + 바디 결합 
		HttpEntity<MultiValueMap<String, String>> reqkakoMessage = new HttpEntity<>(params1, header1); 
		
		// 통신 요청 (토큰 받기)
	    ResponseEntity<OAuthToken> response1= rt1.exchange("https://kauth.kakao.com/oauth/token", 
				HttpMethod.POST, reqkakoMessage, OAuthToken.class);
	    System.out.println("response1 <OAuthToken> : " + response1.getBody().toString());
		
	    // 카카오 리소스서버 사용자 정보 가져오기 (토큰 갱신하기)
	    RestTemplate rt2 = new RestTemplate();
	    
	    // 헤더 
	    HttpHeaders headers2 = new HttpHeaders();
	    
	    // 반드시 Bearer 값 다음에 공백 한칸 추가 !!  (토큰 갱신하기)
	    headers2.add("Authorization", "Bearer " +response1.getBody().getAccessToken());
	    headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	    
	    // HTTP Entity 만들기 (토큰 갱신하기)
	    HttpEntity<MultiValueMap<String, String>> reqKakoInfoMessage = new HttpEntity<>(headers2);
	    
	    // 통신 요청 (토큰 갱신하기)
	    ResponseEntity<KakaoProfile> resposne2 = 
	    		rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST, 
	    			reqKakoInfoMessage, KakaoProfile.class);
	    
	    KakaoProfile kakaoProfile = resposne2.getBody();
	    // return kakaoProfile.toString();
	    
	    // ---- 카카오 사용자 정보 응답 완료 ----------
	    
	    // 최초 사용자라면 자동 회원 가입 처리 (우리 서버) 
	    // 회원가입 이력이 있는 사용자라면 바로 세션 처리 (우리 서버) 
	    // 사전기반 --> 소셜 사용자는 비밀번호를 입력하는가? 안하는가? 
	    // 우리서버에 회원가입시에 --> password -> not null (무건 만들어 넣어야 함 DB 정책) 
	    
	  // TODO -(테스트) 아래에 있는 것은 birthDate 가 Date 라서
	    Timestamp timestamp = Timestamp.valueOf("2024-12-01 00:00:00");
	    Date birthDate = new Date(timestamp.getTime());
	    
	    User user = User.builder()
	    		// name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check
	    		.name(kakaoProfile.getProperties().getNickname() + "_" + kakaoProfile.getId())
	    		.birthDate(birthDate)
	    		.gender("M")
	    		.address("부산시 @@구")
	    		.nickName("OAuth_" + kakaoProfile.getProperties().getNickname())
	    		.phoneNumber("010-7777-7777")
	    		.email("test@kakao.test.com")
	    		.password("1234")
	    		.adminCheck("user")
	    		.build();
	    userService.createUser(user);
	    
	    session.setAttribute("principal", user);
	    
		return "redirect:/index";
	}

}
