package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.User;
import com.jam.service.UserService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import lombok.RequiredArgsConstructor;

import com.jam.service.WriterService;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainCotroller {

	@Autowired
	UserService userService;

	@Autowired
	HttpSession session;

	@GetMapping("/")
	public String mainPage() {

		User user2 = (User) session.getAttribute("principal"); // user2에 세션 가져오기
		if (user2 != null) { // 아니라면
			User user = userService.sessionCheck(user2.getEmail()); // user에 데이터를 담는다.
			session.setAttribute("principal", user); // 세션에 값을 새롭게 갱신한다.
			return "/index";
		} else {
			System.out.println("유저세션 없음");
			return "/index";
		}

	}

	private final WriterService writerService;

	/**
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/")
	public String mainPage(Model model) {
		List<Book> bookList = writerService.readAllBookList();
		List<Category> categoryList = writerService.findAllCategory();
		List<Genre> genreList = writerService.findAllGenre();
		model.addAttribute("bookList", bookList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("genreList", genreList);
		return "/index";
	}

	/**
	 * 
	 * @return
	 */
	// 비동기로 카테고리 목록을 반환하는 API
	@GetMapping("/api/categories")
	@ResponseBody
	public List<Category> getCategories() {
		List<Category> categoryList = writerService.findAllCategory();

		return categoryList; // JSON 형식으로 클라이언트에 응답
	}

	/**
	 * @todo 1 스크립트 쿼리스트링 구조 생각 2쿼리문 작성 3 로직구성 4.데이터 받아오기 5.스크립트 작성
	 * @param categoryId
	 * @return
	 */
	// 특정 카테고리의 책 목록을 반환하는 API
	@GetMapping("/api/booksByCategoryOrder")
	@ResponseBody
	public List<Book> getBooksByCategoryId(@RequestParam("categoryId") int categoryId, // TODO 쿼리스트링 받아올변수들
			@RequestParam("filter") String filter, // 정렬 기준 (조회수 또는 좋아요)
			@RequestParam("order") String order) { // 정렬 순서 (오름차순 또는 내림차순)) {
		// 책 목록 가져오기
		List<Book> bookList = writerService.readAllBooksByCategoryIdOrder(categoryId, filter, order);
		for (Book book : bookList) {
			book.setBookCoverImage(book.setUpUserImage());
		}

		// 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
		return bookList; // 카테고리 ID가 일치하는 책 목록 반환
	}

	@GetMapping("/api/genres")
	@ResponseBody
	public List<Genre> getGenre() {
		List<Genre> genreList = writerService.findAllGenre();
		return genreList;
	}

	/**
	 * 
	 * @param genreId
	 * @param filter
	 * @param order
	 * @return
	 */
	@GetMapping("/api/booksByGenreOrder")
	@ResponseBody
	public List<Book> getBooksByGenreId(@RequestParam("genreId") int genreId, // TODO 쿼리스트링 받아올변수들
			@RequestParam("filter") String filter, // 정렬 기준 (조회수 또는 좋아요)
			@RequestParam("order") String order) {
		List<Book> bookList = writerService.readAllBooksByGenreIdOrder(genreId, filter, order);
		for (Book book : bookList) {
			book.setBookCoverImage(book.setUpUserImage());
		}
		// 모든 책에 대해 카테고리 ID가 일치하는 책을 bookList에 추가
		// 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
		return bookList; // 카테고리 ID가 일치하는 책 목록 반환

	}

	@GetMapping("/api/serial")
	@ResponseBody
	public List<String> getWeek() {
		List<Book> bookList = writerService.readBookSerial();
		List<String> weekList = new ArrayList<>();
		for (Book book : bookList) {
			weekList.add(book.getSerialDay());
		}
		return weekList;

	}

	/**
	 * TODO 1 추출 변수값(요일, views(views,likes가 orderby가 필요한지 확실하지않아서 그냥받아옴) TODO 2.
	 * xml,레포지토리,서비스,컨트롤러 까지 만들고 값보냄 3.js에서 views 정렬이 가능한지 체크
	 * 
	 * @return
	 */
	@GetMapping("/api/booksSerial")
	@ResponseBody
	public List<Book> getBooksSerial(@RequestParam("filter") String filter, // 정렬 기준 (조회수 또는 좋아요)
			@RequestParam("order") String order) {
		List<Book> bookList = writerService.readAllbookSerial(filter, order);
		for (Book book : bookList) {
			book.setBookCoverImage(book.setUpUserImage());
		}
		return bookList;
	}

	/**
	 * 
	 * @return
	 */
	// 비동기로 북 목록을 반환하는 API
	@GetMapping("/api/books")
	@ResponseBody
	public List<Book> getBooks() {
		List<Book> bookList = writerService.readAllBookList();

		return bookList; // JSON 형식으로 클라이언트에 응답
	}

	/**
	 * 채팅창 열기
	 * 
	 * @return
	 */

	@GetMapping("/chatPage")
	public String chatPage(@SessionAttribute(Define.PRINCIPAL) User principal, Model model) {
		String nickname = principal.getNickName();
		int userId = principal.getUserId();
		String profileImg = principal.getProfileImg();
		model.addAttribute("nickname", nickname);
		model.addAttribute("userId", userId);
		model.addAttribute("profileImg", profileImg); // 프로필 이미지 추가
		return "/chatPage";
	}

//	@GetMapping("/chatRoom{}")
//	public String chatRoom(@SessionAttribute(Define.PRINCIPAL) User principal, Model model) {
//		String nickname = principal.getNickName();
//		model.addAttribute("nickname",nickname );
//		return "/chatPage";
//	}
//	
//	
//	  @GetMapping("/chat")
//	    public String chating(){
//	      
//	        return "chat";
//	    }

}
