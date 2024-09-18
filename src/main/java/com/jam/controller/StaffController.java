package com.jam.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.NoticeDTO;
import com.jam.repository.model.Notice;
import com.jam.repository.model.User;
import com.jam.service.NoticeService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {

	/**
	 * 관리자 메인 페이지
	 * 
	 * @return
	 */

	private final NoticeService noticeService;

	@GetMapping("")
	public String handleStaffMain(@RequestParam(name = "page", required = false) String page, Model model) {
		String sectionUrl = "/staff/" + page;
		model.addAttribute("sectionUrl", sectionUrl);
		return "staff/main";
	}

	/**
	 * 관리 대시보드 화면(기본 화면) 이동
	 * 
	 * @return
	 */
	@GetMapping("/dashboard")
	public String handleDashboard() {

		return "staff/dashboard";
	}

	/**
	 * 신고 화면 이동
	 * 
	 * @return
	 */
	@GetMapping("/report")
	public String handleReport() {
		return "staff/report";
	}

	*

	금액 관리
	화면 이동**@return*/=======>>>>>>>js-dev @GetMapping("/payment-management")

	public String handlePayment() {
		return "staff/payment-management";
	}

	*

	고객 지원
	화면 이동**@return*/=======>>>>>>>js-dev @GetMapping("/support")

	public String handleSupport() {
		return "staff/support";	
	}

	<<<<<<<HEAD/**
				 * 이벤트 화면 이동
				 * 
				 * @return
				 */
	=======

	>>>>>>>js-dev @GetMapping("/event")

	public String handleEvent() {
		System.out.println("eventPage");
		return "staff/event";
	}

	<<<<<<<HEAD/**
				 * 컨텐츠 관리 화면 이동
				 * 
				 * @return
				 */
	=======>>>>>>>js-dev @GetMapping("/content-management")

	public String handleContentManage() {
		return "staff/content-management";
	}

	/**
	 * qna 화면 이동
	 * 
	 * @return
	 */
	@GetMapping("/qna")
	public String handleQna() {
		return "staff/qna";
	}

	/**
	 * 공지 사항 화면 이동
	 * 
	 * @return
	 */
	// 게시글 조회

	@GetMapping("/notice")
	public String handleNotice(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size, Model model) {
		List<Notice> noticeList = noticeService.staffFindAll(page, size);
		model.addAttribute("noticeList", noticeList);

		return "staff/notice";
	}

	/**
	 * <<<<<<< HEAD 컨텐츠 신고 디테일 화면 이동
	 * 
	 * @return
	 */
	/*

	게시글 수정*/

	@GetMapping("update/{noticeId}")
	public String updateForm(@PathVariable("noticeId") int noticeId, Model model) {
		Notice notice = new Notice();
		notice = noticeService.selectByNoticeId(noticeId);
		model.addAttribute("noticeList", notice);
		return "staff/updateForm";

	}

	@PostMapping("update/{noticeId}")
	public String update(@PathVariable(name = "noticeId") Integer noticeId,
			@RequestParam("noticeTitle") String noticeTitle, @RequestParam("noticeContent") String noticeContent) {
		Notice notice = noticeService.selectByNoticeId(noticeId);
		NoticeDTO dto = NoticeDTO.builder().noticeId(notice.getNoticeId()).noticeTitle(noticeTitle)
				.noticeContent(noticeContent).build();
		Notice notice2 = noticeService.updateNotice(noticeId, dto);
		return "redirect:/staff?page=notice";
	}

	@GetMapping("delete/{noticeId}")
	public String deleteProc(@PathVariable(name = "noticeId") Integer noticeId) {
		noticeService.deleteNotice(noticeId);
		return "redirect:/staff?page=notice";
	}

	@PostMapping("delete/{noticeId}")
	public String delete(@PathVariable(name = "noticeId") Integer noticeId) {
		noticeService.deleteNotice(noticeId);
		return "redirect:/staff?page=notice";
	}

	@PostMapping("insert")
	public String insert(@RequestParam("noticeTitle") String noticeTitle,
			@RequestParam("noticeContent") String noticeContent, @SessionAttribute("principal") User principal) {

		NoticeDTO notice = NoticeDTO.builder().userId(principal.getUserId()).noticeTitle(noticeTitle)
				.noticeContent(noticeContent).build();
		noticeService.Insertnotice(notice);
		return "redirect:/staff?page=notice";
	}

	@GetMapping("insert")
	public String insertProc() {
		return "staff/writeNotice";
	}

	@GetMapping("noticeDetail/{noticeId}")
	public String detail(@PathVariable("noticeId") int noticeId, Model model) {
		Notice notice = noticeService.selectByNoticeId(noticeId);
		model.addAttribute("notice", notice);
		return "staff/noticeDetail";
	}

	@GetMapping("/reportContentDetail")
	public String handleReportContentDetail() {
		return "staff/reportContentDetail";
	}

	/**
	 * 유저 신고 디테일 화면 이동
	 * 
	 * @return
	 */
	@GetMapping("/reportUserDetail")
	public String handleReportUserDetail() {
		return "staff/reportUserDetail";
	}

	/**
	 * 금액 관리 디테일 화면 이동
	 * 
	 * @return
	 */
	@GetMapping("/payDetail")
	public String handlePayDetail() {
		return "staff/payDetail";
	}

	/**
	 * 후원 관리 디테일 화면 이동
	 * 
	 * @return
	 */
	@GetMapping("/donationDetail")
	public String handleDonationDetail() {
		return "staff/donationDetail";
	}

}
