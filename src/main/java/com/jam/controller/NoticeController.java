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

import com.jam.dto.NoticeDTO;
import com.jam.repository.interfaces.NoticeRepository;
import com.jam.repository.model.Notice;
import com.jam.service.NoticeService;

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
	public String listPage(Model model) {
		List<Notice> noticeList = noticeService.findAll();
		model.addAttribute("noticeList", noticeList);
		return "notice/list";
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

		noticeRepository.insert(notice);

		return "redirect:/notice/list";
	}

	@PostMapping("/delete")
	public String delete(@RequestParam("noticeId") Integer noticeId) {
		noticeService.delete(noticeId);
		// 게시물 삭제 후 리스트 페이지로 리다이렉트
		return "redirect:/notice/list";
	}

	/**
	 * 게시글 수정
	 */
	@GetMapping("update/{noticeId}")
	public String updateForm(@PathVariable("noticeId") int noticeId, Model model) {
		Notice notice = new Notice();
		model.addAttribute("noticeList", notice);
		model.addAttribute("noticeId", noticeId);
		return "notice/updateForm";
	}

	@PostMapping("/list/update/{noticeId}")
	public String update(NoticeDTO noticeDTO, @PathVariable(name = "noticeId") Integer noticeId, NoticeDTO dto) {
		int boardTemp = noticeService.uploading(noticeId, dto);

		return "redirect:/";
	}

}

// 수정 기능을 위한 메서드 추가 필요
