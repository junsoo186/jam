package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
@Controller
@RequestMapping("/funding")
@RequiredArgsConstructor
public class FundingController {

	@PostMapping("/funding")
	public String handleFunding() {
		return "funding/funding";
	}
	
	@GetMapping("/funding")
	public String handleFundingPage() {
		return "funding/funding";
	}
}
