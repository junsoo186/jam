package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.dto.WriterDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequiredArgsConstructor
@RequestMapping("/write")
public class WriterController {

	@Autowired
	private final HttpSession session;

	/**
	 * 메인->작품 리스트 페이지
	 * 
	 * @return
	 */
	@GetMapping("/workList")
	public String handleWorkList() {

		return "write/workList";
	}

	/**
	 * 작품 리스트->작품추가페이지 get 방식
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
	public String completedWorkProc() {


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
