package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.BookDTO;
import com.jam.dto.StoryDTO;
import com.jam.dto.UserDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Story;
import com.jam.repository.model.User;
import com.jam.service.WriterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/write")
public class WriterController {

	private final WriterService writerService;
	@Autowired
	private final HttpSession session;



	// TODO - 검색 기능 추가

	/**
	 * 전체 작품 목록 출력
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/workList")
	public String handleWorkList(Model model) {
		 UserDTO principal =(UserDTO) session.getAttribute("principal");
		List<Book> bookList = writerService.readAllBookListByprincipalId(principal.getUserId());
		if (bookList.isEmpty()) {
			model.addAttribute("bookList", null);
		} else {
			model.addAttribute("bookList", bookList);
		}
		return "write/workList";
	}

	// TODO - 작가 개인 작성 리스트 추가

	/**
	 * 작품 작성 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/workInsert")
	public String handleWorkInsert() {
		return "write/workInsert";
	}

	/**
	 * 작품 작성 처리 -> 생성후 작품 리스트로 이동
	 * 
	 * @param bookDTO
	 * @param principalId
	 * @return
	 */
	@PostMapping("/workInsert")
	public String completedWorkProc(BookDTO bookDTO) {
		UserDTO principal =(UserDTO) session.getAttribute("principal");
		// TODO - 유효성 검사 추가
		if (bookDTO.getTitle() == null || bookDTO.getTitle().isEmpty()) {
			// TODO - alert 메시지 >> 제목 입력 요청
		} else if (bookDTO.getCategoryId() == null) {
			// TODO - alert 메시지 >> 카테고리 입력 요청
		} else if (bookDTO.getGenreId() == null) {
			// TODO - alert 메시지 >> 장르 입력 요청
		} else if (bookDTO.getTagNames() == null || bookDTO.getTagNames().isEmpty()
				|| bookDTO.getTagNames().size() < 3) {
			// TODO - alert 메시지 >> 태그는 최소 3개 이상 선택해야 합니다.
		}

		// 태그가 없으면 만들기
//		for (String tagName : tagNames) {
//			if (!bookDTO.getTagNames().contains(tagName)) {
//				writerService.insertTagName(tagName);
//			}
//		}

		writerService.createBook(bookDTO, principal.getUserId());
		return "redirect:/write/workList";
	}

	/**
	 * 회차 작성 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/storyInsert")
	public String handleStoryInsert() {
		return "write/storyInsert";
	}

	/**
	 * 회차 작성 처리 -> 작성 후 내용 출력 화면으로 이동
	 * 
	 * @return
	 */
	@PostMapping("/storyInsert")
	public String StoryInsertProc(StoryDTO storyDTO, @RequestParam("bookId") Integer bookId) {

		if (storyDTO.getType().equals("프롤로그")) { // 프롤로그 선택시 무조건 number = 0
			storyDTO.setNumber(0);
		}
		if (storyDTO.getNumber() == null) {
			// TODO - alert 메시지 >> 회차 입력 요청
		} else if (storyDTO.getTitle() == null || storyDTO.getTitle().isEmpty()) {
			// TODO - alert 메시지 >> 제목 입력 요청
		} else if (storyDTO.getContents() == null || storyDTO.getContents().isEmpty()) {
			// TODO - alert 메시지 >> 내용 입력 요청
		}

		writerService.createStory(storyDTO, bookId, 1);
		return "redirect:/write/storyContents?number=" + storyDTO.getNumber();
	}

	/**
	 * 회차 내용 출력
	 * 
	 * @return
	 */
	@GetMapping("/storyContents")
	public String handleStoryContents(Model model, @RequestParam(name = "storyId") Integer storyId) {
		Story storyContent = writerService.outputStoryContentByStoryId(storyId);
		if (storyContent == null) {
			model.addAttribute("storyContent", null);
		} else {
			model.addAttribute("storyContent", storyContent);
		}
		return "write/storyContents";
	}

	/**
	 * 작품 자세히 보기 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/workDetail")
	public String handleWorkDetail(Model model, @RequestParam("bookId") Integer bookId) {
		Book bookDetail = writerService.detailBook(bookId);
		List<Story> storyList = writerService.findAllStoryByBookId(bookId);
		if (bookDetail == null) {
			model.addAttribute("bookDetail", null);
		} else {
			model.addAttribute("bookId", bookId);
			model.addAttribute("bookDetail", bookDetail);
		}

		if (storyList == null) {
			model.addAttribute("storyList", null);
		} else {
			model.addAttribute("storyList", storyList);
		}
		return "write/workDetail";
	}

	/**
	 * 작품 수정 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/workUpdate")
	public String handleWorkUpdate(Model model, @RequestParam("bookId") Integer bookId) {
		Book bookDetail = writerService.detailBook(bookId);
		if (bookDetail == null) {
			model.addAttribute("bookDetail", null);
		} else {
			model.addAttribute("bookId", bookId);
			model.addAttribute("bookDetail", bookDetail);
		}
		return "write/workUpdate";
	}

	/**
	 * 작품 수정 처리 -> 수정 후 작품 리스트로 이동
	 * 
	 * @return
	 */
	@PostMapping("/workUpdate")
	public String workUpdateProc(BookDTO bookDTO, @RequestParam("bookId") Integer bookId) {
		// BookDTO에서 Book 객체로 변환
		Book book = bookDTO.updateBook(bookId);

		// 변환된 Book 객체를 사용하여 업데이트 작업 수행
		try {
			writerService.updateBook(book); // writerService는 Book을 업데이트하는 서비스
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		return "redirect:/write/workDetail?bookId=" + bookId;
	}
	
	@PostMapping("/workDelete")
	public String workDeleteProc(BookDTO bookDTO) {
		
		System.out.println("bookDTO임"+ bookDTO.getBookId());
		writerService.deleteStory(bookDTO.getBookId());
		
		return"redirect:/write/workList";
	}
	
	
	
	

	/**
	 * 회차 수정 페이지 이동
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/storyUpdate")
	public String handleStoryUpdate(Model model, @RequestParam(name = "storyId") Integer storyId) {
		Story storyContent = writerService.outputStoryContentByStoryId(storyId);
		model.addAttribute("storyContent", storyContent);
		return "write/storyUpdate";
	}

	/**
	 * 회차 수정 처리 -> 수정 후 회차 내용 화면으로 이동
	 * 
	 * @return
	 */
	@PostMapping("/storyUpdate")
	public String storyUpdateProc(StoryDTO dto, @RequestParam(name = "storyId") Integer storyId) {
		if (dto.getType().equals("프롤로그")) { // 프롤로그 선택시 무조건 number = 0
			writerService.updateNumberByStoryId("0", dto.getStoryId());
		}
		if (dto.getType().equals("무료")) {
			writerService.updateNumberByStoryId("BOUNS", dto.getStoryId());
		}
		Story story = dto.updateStory(storyId);
		try {
			System.out.println("story : " + story.toString());
			writerService.updateStory(story);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/write/storyContents?storyId=" + storyId;
	}
}