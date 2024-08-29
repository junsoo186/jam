package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jam.dto.QnaDTO;
import com.jam.repository.interfaces.QnaRepository;
import com.jam.service.QnaService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/qna")
@RequiredArgsConstructor
public class QnaController {
	
	private final QnaService qnaService;
	
	@Autowired
	private QnaRepository qnaRepository;
	
	@GetMapping("/list")
	public String qnaPage(Model model) {
		List<QnaDTO> qnaList = qnaService.selectAllQna();
		model.addAttribute("qnaList",qnaList);
		return "/qna/qnaList";
	}
	@GetMapping("/write")
	public String qnaWritePage() {
		return "/qna/qnaWrite";
	}

}
