package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.service.EventService;
import com.jam.service.FundService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequiredArgsConstructor
@RequestMapping("/fund")
public class FundController {
	
	@Autowired
	private  FundService fundService;
	private final HttpSession session;
	
	@GetMapping("/list")
	public String getMethodName(@RequestParam String param) {
		return new String();
	}
	
	
}
