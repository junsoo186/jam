package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.repository.model.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

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

}
