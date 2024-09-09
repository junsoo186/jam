package com.jam.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.FundingDTO;
import com.jam.repository.model.Funding;
import com.jam.repository.model.User;
import com.jam.service.FundingService;
import com.jam.service.UserService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
@Controller
@RequestMapping("/funding")
@RequiredArgsConstructor
public class FundingController {

	private final HttpSession session;
	private final FundingService fundingService;
	
	
	@PostMapping("/list")
	public String handleFunding() {
		return "funding";
	}
	
	
	/**
	 * 
	 * 리스트 페이지 (funding 페이지 아직없음)
	 * @param model
	 * @return
	 */
	@GetMapping("/fundingList")
	public String handleFundingPage(Model model) {
		List<Funding> List=fundingService.selectAllFund();
		int countNum= fundingService.countFundingAll();
		for (Funding funding : List) {
			List<FundingDTO> fundingList= new ArrayList<>();
			fundingList.add(funding.tofundingDTO());
			
			model.addAttribute("fundingList",fundingList);
			model.addAttribute("countNum",countNum);
			
		}
		return "funding/fundingList";
	}
	
	
}
