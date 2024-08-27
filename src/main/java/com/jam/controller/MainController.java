package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class MainController {
	
	
	@GetMapping("/index")
	public String mainPage() {
		System.out.println("인덱스 페이지 호출 확인");
		return "index";
	}
	

}
