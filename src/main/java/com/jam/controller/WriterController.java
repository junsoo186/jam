package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jam.dto.CreateBookDTO;
import com.jam.repository.model.Book;
import com.jam.service.WriterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/write")
public class WriterController {

	@Autowired
	private final HttpSession session;
	@Autowired
	private final WriterService writerService;

	/**
	 * 메인->작품 리스트 페이지
	 * 
	 * @return
	 */
	@GetMapping("/workList")
	public String handleWorkList(Model model) {

		List<Book> bookList = writerService.readAllBookList();
		if (bookList.isEmpty()) {
			model.addAttribute("bookList", null);
		} else {
			model.addAttribute("bookList", bookList);
		}
		return "write/workList";
	}

	/**
	 * 작품 리스트-> 작품추가페이지 get 방식
	 * 
	 * @return
	 */
	@GetMapping("/workInsert")
	public String handleWorkInsert() {
		return "write/workInsert";
	}

	/**
	 * 
	 * 작품추가페이지->작품리스트 post 방식
	 * 
	 * @return
	 */
	@PostMapping("/workInsert")
	public String completedWorkProc(CreateBookDTO bookDTO, Integer principalId) {

		// TODO - 유효성 검사 추가
		if (bookDTO.getTitel() == null || bookDTO.getTitel().isEmpty()) {
			// TODO - alert 메시지 >> 제목 입력 요청
		} else if (bookDTO.getCategoryIds() == null || bookDTO.getCategoryIds().isEmpty()) {
			// TODO - alert 메시지 >> 카테고리 입력 요청
		} else if (bookDTO.getGenreIds() == null || bookDTO.getGenreIds().isEmpty()) {
			// TODO - alert 메시지 >> 장르 입력 요청
		} else if (bookDTO.getTagIds() == null || bookDTO.getTagIds().isEmpty() || bookDTO.getTagIds().size() < 3) {
			// TODO - alert 메시지 >> 태그는 최소 3개 이상 선택해야 합니다.
		}

		writerService.createBook(bookDTO, principalId);
		return "redirect:/write/workList";
	}

	@GetMapping("/storyInsert")
	public String handleStoryInsert() {
		return "write/storyInsert";
	}

	@GetMapping("/storyContents")
	public String handleStoryContents() {
		return "write/storyContents";
	}

	@PostMapping("/storyInsert")
	public String StoryInsertProc() {

		return "redirect:/write/storyContents";
	}

	@GetMapping("/workDetail")
	public String handleWorkDetail() {

		return "write/workDetail";
	}

	@GetMapping("/workUpdate")
	public String handleWorkUpdate() {

		return "write/workUpdate";
	}

	@PostMapping("/workUpdate")
	public String workUpdateProc() {

		return "redirect:/write/workDetail";

	}

	@GetMapping("/storyUpdate")
	public String handleStoryUpdate() {
		return "write/storyUpdate";
	}

	@PostMapping("/storyUpdate")
	public String storyUpdateProc() {

		return "redirect:/write/storyContents";
	}
}