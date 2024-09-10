package com.jam.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.repository.model.Notice;
import com.jam.service.NoticeService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {

	private final NoticeService noticeService;

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
	public String handleNotice(@RequestParam(name="page", defaultValue = "1") int page, 
			@RequestParam(name="size", defaultValue = "10") int size,
			Model model) {
		List<Notice> noticeList = noticeService.staffFindAll(page, size);
		model.addAttribute("noticeList", noticeList);

		return "staff/notice";
	}

	@PostMapping("/notice")
	public String handleNoticeProc(@RequestParam(name="page", defaultValue = "1") int page, 
			@RequestParam(name="size", defaultValue = "10") int size,
			Model model) {
		List<Notice> noticeList = noticeService.staffFindAll(page, size);
		model.addAttribute("noticeList", noticeList);

		return "staff/notice";
	}
	
	@PostMapping("/notice/update")
	public String editNotice
	(@RequestParam(name="noticeId")int noticeId ,
	@RequestParam(name="noticeTitle")String noticeTitle, 
	@RequestParam(name="noticeContent")String noticeContent) {
		
		
		return "staff/update/notice";
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
