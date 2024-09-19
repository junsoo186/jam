package com.jam.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jam.repository.model.MainBanner;
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
