package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.NoticeDTO;
import com.jam.repository.interfaces.NoticeRepository;
import com.jam.repository.model.Notice;
import com.jam.repository.model.User;
import com.jam.service.NoticeService;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notice")

public class NoticeController {

	private final NoticeService noticeService;

	@Autowired
	private NoticeRepository noticeRepository;

	/** 
	 * 게시글 목록 페이지 요청
	 */
	@GetMapping({ "/list", "/" })
	public String listPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size, Model model) {
		int totalRecords = noticeService.allList();
		int totalPages = (int) Math.ceil((double) totalRecords / size);
		List<Notice> noticeList = noticeService.findAll(page, size);

		System.out.println("공시사항 목록 : " + noticeList);

		
		
		
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("size", size);
		return "/notice";
	}

	/**
	 * 게시글 저장, 등록 화면단
	 */
	@GetMapping("/insertForm")
	public String insertForm() {
		return "notice/insertForm";
	}

	/**
	 * 게시글 저장, 등록
	 */
	@PostMapping("/insert")
	public String insert(@RequestParam(name = "notice_id", required = false, defaultValue = "0") int noticeId,
			@RequestParam(name = "staff_id", required = false, defaultValue = "0") int staffId, // 매개변수 이름 수정
			@RequestParam(name = "title", required = false) String noticeTitle,
			@RequestParam(name = "content", required = false) String noticeContent,
			@RequestParam(name = "comment", required = false) String comment) {
		Notice notice = Notice.builder().noticeId(noticeId).staffId(staffId).noticeTitle(noticeTitle)
				.noticeContent(noticeContent).comment(comment).build();


		return "redirect:/notice/list";
	}

	@PostMapping("/delete")
	public String delete(@RequestParam("noticeId") Integer noticeId) {
		noticeService.deleteNotice(noticeId);
		// 게시물 삭제 후 리스트 페이지로 리다이렉트
		return "redirect:/notice/list";
	}

	/**
	 * 상세 페이지 detail
	 * 
	 */
	@GetMapping("detail/{noticeId}")
	public String detailPage(@PathVariable(name = "noticeId") int noticeId, Model model) {

		Notice myNotice = noticeService.selectByNoticeId(noticeId);
		model.addAttribute("notice", myNotice);
		return "/notice/noticeDetail";
	}

	

}

// 수정 기능을 위한 메서드 추가 필요