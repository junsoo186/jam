package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.service.MainBannerService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mainBanner")
public class MainBannerController {
	
		private final MainBannerService mainBannerService;
	
		@GetMapping("/detail")		
		public String findMainBannerById() {
			return null; 
		}
		

		
}
