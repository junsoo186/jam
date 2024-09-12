package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {
	
	@GetMapping("")
	public String handleStaffMain() {
		return "staff/main";
	}
	
	
	@GetMapping("/dashboard")
	public String handleDashboard() {
		
		return "staff/dashboard";
	}
	
	@GetMapping("/report")
	public String handleReport() {
		return "staff/report";
	}
	
	@GetMapping("/payment-management")
	public String handlePayment() {
		return "staff/payment-management";
	}
	
	@GetMapping("/support")
	public String handleSupport() {
		return "staff/support";
	}
	
	@GetMapping("/event")
	public String handleEvent() {
		return "staff/event";
	}
	
	@GetMapping("/content-management")
	public String handleContentManage() {
		return "staff/content-management";
	}
	
	@GetMapping("/qna")
	public String handleQna() {
		return "staff/qna";
	}
	
	@GetMapping("/notice")
	public String handleNotice() {
		return "staff/notice";
	}
	
	@GetMapping("/reportContentDetail")
	public String handleReportContentDetail() {
		return "staff/reportContentDetail";
	}
	
	@GetMapping("/reportUserDetail")
	public String handleReportUserDetail() {
		return "staff/reportUserDetail";
	}
	
	@GetMapping("/payDetail")
	public String handlePayDetail() {
		return "staff/payDetail";
	}
	
	@GetMapping("/donationDetail")
	public String handleDonationDetail() {
		return "staff/donationDetail";
	}
	
}
