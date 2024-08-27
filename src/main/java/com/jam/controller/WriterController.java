package com.jam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/write")
public class WriterController {

	/**
	 * 메인->작품 리스트 페이지
	 * 
	 * @return
	 */
	@GetMapping("/list")
	public String workList() {

		return "write/workList";
	}

	/**
	 * 작품 리스트->작품추가 get 방식
	 * 
	 * @return
	 */
	@GetMapping("/insert")
	public String workInsert() {
		return "write/workInsert";
	}

	/**
	 * 
	 * 리스트->작품리스트 post 방식
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public String completedWork() {

		return "redirect:/write/list";
	}

}
