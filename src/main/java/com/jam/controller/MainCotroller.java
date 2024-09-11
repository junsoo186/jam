package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.repository.model.User;
import com.jam.service.UserService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import lombok.RequiredArgsConstructor;



@Controller
@RequiredArgsConstructor
public class MainCotroller {
	
	@Autowired
	UserService userService;
	HttpSession session;
	
	@GetMapping("/")
	public String mainPage(HttpServletRequest request, Model model) {
		 HttpSession session = request.getSession(false); // 세션이 없을 때 새로 만들지 않음 (null 반환)
		 User user2 = (User) session.getAttribute("principal"); // user2에 세션 가져오기
		
		if(user2 == null) { // 만약에 user2에 세션이 없다면
			return "/index"; // 로그인 없이 홈페이지 이동
		} else { // 아니라면
				 User user = userService.sessionCheck(user2.getEmail()); // user에 데이터를 담는다.
				 session.setAttribute("principal", user); // 세션에 값을 새롭게 갱신한다.
		return "/index";	
		}		
	}
	
    /**
     * 채팅창 열기
     * @return
     */

	@GetMapping("/chatPage")
	public String chatPage(@SessionAttribute(Define.PRINCIPAL) User principal, Model model) {
	    String nickname = principal.getNickName();
	    int userId = principal.getUserId();
	    String profileImg = principal.getProfileImg();
	    model.addAttribute("nickname", nickname);
	    model.addAttribute("userId", userId);
	    model.addAttribute("profileImg", profileImg); // 프로필 이미지 추가
	    return "/chatPage";
	}


	

	
//	@GetMapping("/chatRoom{}")
//	public String chatRoom(@SessionAttribute(Define.PRINCIPAL) User principal, Model model) {
//		String nickname = principal.getNickName();
//		model.addAttribute("nickname",nickname );
//		return "/chatPage";
//	}
//	
//	
//	  @GetMapping("/chat")
//	    public String chating(){
//	      
//	        return "chat";
//	    }
	

}
