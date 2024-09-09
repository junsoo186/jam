package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.repository.model.User;
import com.jam.utils.Define;



@Controller
public class MainCotroller {
	@GetMapping("/")
	public String mainPage() {
		return "/index";
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
