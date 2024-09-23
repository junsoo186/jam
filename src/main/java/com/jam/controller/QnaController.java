package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.QnaDTO;
import com.jam.handler.exception.UnAuthorizedException;
import com.jam.repository.model.Banner;
import com.jam.repository.model.Qna;
import com.jam.repository.model.User;
import com.jam.service.BannerService;
import com.jam.service.QnaService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/qna")
@RequiredArgsConstructor
public class QnaController {
	private final QnaService qnaService;
	private final HttpSession session;
	private final BannerService bannerService;
	
	
	// 생성자 
	
	
	
	/**
	 * -Q&A 전체 화면 출력-
	 * 추후 수정 필요 - 인증 처리 (본인 아닌경우 글 상세보기 불가)  완료
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
		// 사용자 인증 -추후 전체 인증 만들면 삭제 예정
		User principal = (User)session.getAttribute("principal");
		// 배너 관련 정보
		List<Banner> bannerList = bannerService.findAll();
		for (Banner banner : bannerList) {
			String bannerImg = banner.setUpBannerImage();
			banner.setImagePath(bannerImg);
		}


		if(principal == null ) {
			throw new UnAuthorizedException("인증된 사용자가 아닙니다.", HttpStatus.UNAUTHORIZED);
		}
		int totalRecords = qnaService.allList();
		int totalPages = (int)Math.ceil((double)totalRecords / size);
		List<Qna> qnaList = qnaService.selectAllQna( page,  size);
		
		
		model.addAttribute("banner", bannerList);
		model.addAttribute("qnaList",qnaList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("size", size);
		
		return "/qna/qnaList";
	}
	/**
	 *insert 기능 구현
	 * @return
	 */
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
	public String qnaWrite(QnaDTO dto,@SessionAttribute(Define.PRINCIPAL) User principal){
		qnaService.qnaWrite(dto, principal.getUserId());
		return "redirect:/qna/list";
	}
	
	
	
	/**
	 * 상세페이지
	 * 
	 * @param qnaId
	 * @return
	 */
	@GetMapping("detail/{qnaId}")
	public String detailPage(@PathVariable(name ="qnaId")int qnaId , Model model,
			@SessionAttribute(Define.PRINCIPAL) User principal) {
	
		Qna myQna = qnaService.selectByQnaId(qnaId);
		model.addAttribute("qna",myQna);
		// 본인글이 아닌경우 내용 확인 불가
		if (principal.getUserId() != myQna.getUserId()) {
	            throw new UnAuthorizedException("본인 글만 확인이 가능합니다.", HttpStatus.UNAUTHORIZED);
	        }
		
		return "/qna/qnaDetail";
	}
	
	/**
	 * Delete 기능 구현
	 * @param dto
	 * @return
	 */
	@PostMapping("delete")
	public String deleteQna(@RequestParam(name ="qnaId")int qnaId, QnaDTO dto) {
		qnaService.delete(qnaId);
		return "redirect:/qna/list";
	}
	/**
	 * update 페이지 이동
	 * @param qnaId
	 * @param model
	 * @return
	 */
	@GetMapping("updatePage/{qnaId}")
	public String updatePage(@PathVariable(name ="qnaId")int qnaId , Model model) {
		Qna myQna = qnaService.selectByQnaId(qnaId);
		model.addAttribute("qna",myQna);
		// 본인글이 아닌경우 내용 확인 불가
		return "/qna/qnaUpdate";
	}
	
	/**
	 * update 기능구현
	 * @param qnaId
	 * @param dto
	 * @return
	 */
	@PostMapping("update")
	public String updateQna(@RequestParam(name ="qnaId") int qnaId, QnaDTO dto){
		qnaService.updateMyqna(dto, qnaId);
		return"redirect:/qna/list";
	}
	
	
}
