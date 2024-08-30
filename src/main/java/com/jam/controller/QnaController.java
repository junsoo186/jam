package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	
	/**
	 * -Q&A 전체 화면 출력-
	 * 추후 수정 필요 - 인증 처리 (본인 아닌경우 글 상세보기 불가) 
	 * 페이징 처리
	 * @param page
	 * @param size
	 * @param model
	 * @return
	 */
	@GetMapping("/list")
	public String qnaPage( @RequestParam(name ="page", defaultValue = "1" )  int page,
			 				@RequestParam(name ="size", defaultValue = "10" )  int size,
			 				Model model) {
		int totalRecords = qnaService.allList();
		int totalPages = (int)Math.ceil((double)totalRecords / size);
		List<QnaDTO> qnaList = qnaService.selectAllQna( page,  size);
		
		
		
		model.addAttribute("qnaList",qnaList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("size", size);
		
		return "/qna/qnaList";
	}
	@GetMapping("/write")
	public String qnaWritePage() {
		return "/qna/qnaWrite";
	}
	
	/**
	 * 질문 남기기 
	 * 추후 수정 필요 - principal.userId 받아야 함
	 * @param userId
	 * @param title
	 * @param questionContent
	 * @return
	 */
	@PostMapping("write")
	public String qnaWrite(@RequestParam(name = "user_id" ) int userId,
			@RequestParam(name = "title" ) String title,
			@RequestParam(name = "question_content" ) String questionContent){
		QnaDTO qnaDTO = QnaDTO.builder()
				.userId(userId) //  <- principal.userId 넣어야 함
				.title(title)
				.questionContent(questionContent)
				.build();		
		qnaRepository.insertQ(qnaDTO);
		return "redirect:/qna/qnaList";
	}

}
