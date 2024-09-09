package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {

	/**
	 * 관리자 메인 페이지
	 * @return
	 */
	@GetMapping("")
	public String handleStaffMain() {
		return "staff/main";
	}

	/**
	 * 관리 대시보드 화면(기본 화면) 이동
	 * @return
	 */
	@GetMapping("/dashboard")
	public String handleDashboard() {

		return "staff/dashboard";
	}

	/**
	 * 신고 화면 이동
	 * @return
	 */
	@GetMapping("/report")
	public String handleReport() {
		return "staff/report";
	}

	/**
	 * 금액 관리 화면 이동
	 * @return
	 */
	@GetMapping("/payment-management")
	public String handlePayment() {
		return "staff/payment-management";
	}

	/**
	 * 고객 지원 화면 이동
	 * @return
	 */
	@GetMapping("/support")
	public String handleSupport() {
		return "staff/support";
	}

	/**
	 * 이벤트 화면 이동
	 * @return
	 */
	@GetMapping("/event")
	public String handleEvent() {
		return "staff/event";
	}

	/**
	 * 컨텐츠 관리 화면 이동
	 * @return
	 */
	@GetMapping("/content-management")
	public String handleContentManage() {
		return "staff/content-management";
	}

	/**
	 * qna 화면 이동
	 * @return
	 */
	@GetMapping("/qna")
	public String handleQna() {
		return "staff/qna";
	}

	/**
	 * 공지 사항 화면 이동
	 * @return
	 */
	@GetMapping("/notice")
	public String handleNotice() {
		return "staff/notice";
	}

	/**
	 * 컨텐츠 신고 디테일 화면 이동
	 * @return
	 */
	@GetMapping("/reportContentDetail")
	public String handleReportContentDetail() {
		return "staff/reportContentDetail";
	}

	/**
	 * 유저 신고 디테일 화면 이동
	 * @return
	 */
	@GetMapping("/reportUserDetail")
	public String handleReportUserDetail() {
		return "staff/reportUserDetail";
	}

	/**
	 * 금액 관리 디테일 화면 이동
	 * @return
	 */
	@GetMapping("/payDetail")
	public String handlePayDetail() {
		return "staff/payDetail";
	}

	/**
	 * 후원 관리 디테일 화면 이동
	 * @return
	 */
	@GetMapping("/donationDetail")
	public String handleDonationDetail() {
		return "staff/donationDetail";
	}
}
