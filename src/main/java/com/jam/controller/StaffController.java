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
import com.mysql.cj.Session;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staff")
@RequiredArgsConstructor
public class StaffController {

	private final NoticeService noticeService;
	
	private final HttpSession session;

	@GetMapping("")
	public String handleStaffMain(@RequestParam(name = "page", required = false) String page, Model model) {
		String sectionUrl = "/staff/" + page;
		model.addAttribute("sectionUrl", sectionUrl);
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

	// 게시글 조회

	@GetMapping("/notice")
	public String handleNotice(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size, Model model) {
		List<Notice> noticeList = noticeService.staffFindAll(page, size);
		model.addAttribute("noticeList", noticeList);

		
		return "staff/notice";
	}

	/**
	 * 게시글 수정
	 */
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
			@RequestParam("noticeContent") String noticeContent,
			@SessionAttribute("principal")User principal ) {
		
		NoticeDTO notice = NoticeDTO.builder()
				.userId(principal.getUserId())
				.noticeTitle(noticeTitle)
				.noticeContent(noticeContent)
				.build();
		noticeService.Insertnotice(notice);
		return "redirect:/staff?page=notice";
	}
	
	@GetMapping("insert")
	public String insertProc() {
		return "staff/writeNotice";
	} 
	
	@GetMapping("noticeDetail/{noticeId}")
	public String detail(@PathVariable("noticeId")int noticeId, Model model) {
		Notice notice = noticeService.selectByNoticeId(noticeId);
		model.addAttribute("notice", notice);
		return "staff/noticeDetail";
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
