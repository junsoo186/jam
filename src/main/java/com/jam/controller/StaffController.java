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

	

}
