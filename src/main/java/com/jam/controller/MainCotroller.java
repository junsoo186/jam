package com.jam.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;
import com.jam.dto.BookDTO;
import com.jam.dto.CategoryDTO;
import com.jam.dto.GenreDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.User;
import com.jam.service.WriterService;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class MainCotroller {
	
	private final WriterService writerService;
	
	
	
	/**
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/")
	public String mainPage(Model model) {
		List<Book>toBookList=writerService.readAllBookList();
        List<Category> toCategoryList = writerService.findAllCategory();
        List<Genre> toGenreList= writerService.findAllGenre();
        List<CategoryDTO> categoryList = new ArrayList<>();
        List<BookDTO> bookList=new ArrayList<>();
        List<GenreDTO> genreList=new ArrayList<>();
        for (Genre genre : toGenreList) {
			genreList.add(genre.toGenreDTO());
		}
        for (Category category : toCategoryList) {
            categoryList.add(category.toCategoryDTO());
        }
		for (Book book : toBookList) {
			bookList.add(book.toBookDTO());
		}
		
		model.addAttribute("bookList",bookList);
		model.addAttribute("categoryList",categoryList);
		model.addAttribute("genreList",genreList);
		model.addAttribute("jsonBookCover", // 북커버 이미지를  json으로 보내서 파일마다 이미지 확장자 체크를 위함
				new Gson().toJson
				(bookList.stream().map(BookDTO::getBookCoverImage).collect(Collectors.toList()))); // foreach대신 stream으로 모든값 add
		return "/index";
	}
	
	
	/**
	 * 
	 * @return
	 */
    // 비동기로 카테고리 목록을 반환하는 API
    @GetMapping("/api/categories")
    @ResponseBody
    public List<CategoryDTO> getCategories() {
        List<Category> toCategoryList = writerService.findAllCategory();
        List<CategoryDTO> categoryList = new ArrayList<>();
        
        for (Category category : toCategoryList) {
            categoryList.add(category.toCategoryDTO());
        }
        
        return categoryList;  // JSON 형식으로 클라이언트에 응답
    }
    
    /**
     * 
     * @return
     */
    @GetMapping("/api/genres")
    @ResponseBody
    public List<GenreDTO> getDtos(){
        List<Genre> toGenreList= writerService.findAllGenre();
        List<GenreDTO> genreList=new ArrayList<>();
        for (Genre genre : toGenreList) {
			genreList.add(genre.toGenreDTO());
		}
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
    public List<BookDTO> getBooksByGenreId(@RequestParam("genreId") int genreId, // TODO 쿼리스트링 받아올변수들  
									       @RequestParam("filter") String filter,     // 정렬 기준 (조회수 또는 좋아요)
									       @RequestParam("order") String order){
        List<Book> toBookList = writerService.readAllBooksByGenreIdOrder(genreId,filter,order);
        
        // 반환할 책 리스트 초기화
        List<BookDTO> bookList = new ArrayList<>();
        // 모든 책에 대해 카테고리 ID가 일치하는 책을 bookList에 추가
        for (Book book : toBookList) {
                bookList.add(book.toBookDTO());  // 카테고리 ID가 일치하면 리스트에 추가
        }
        
        // 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
        return bookList;  // 카테고리 ID가 일치하는 책 목록 반환
    
    }
    
    /**
     * @todo 1 스크립트 쿼리스트링 구조 생각 2쿼리문 작성 3 로직구성 4.데이터 받아오기 5.스크립트 작성
     * @param categoryId
     * @return
     */
 // 특정 카테고리의 책 목록을 반환하는 API
    @GetMapping("/api/booksByCategoryOrder")
    @ResponseBody
    public List<BookDTO> getBooksByCategoryId(@RequestParam("categoryId") int categoryId, // TODO 쿼리스트링 받아올변수들  
									          @RequestParam("filter") String filter,     // 정렬 기준 (조회수 또는 좋아요)
									       @RequestParam("order") String order) {    // 정렬 순서 (오름차순 또는 내림차순)) {
        // 책 목록 가져오기
        List<Book> toBookList = writerService.readAllBooksByCategoryIdOrder(categoryId,filter,order);
        
        // 반환할 책 리스트 초기화
        List<BookDTO> bookList = new ArrayList<>();
        // 모든 책에 대해 카테고리 ID가 일치하는 책을 bookList에 추가
        for (Book book : toBookList) {
                bookList.add(book.toBookDTO());  // 카테고리 ID가 일치하면 리스트에 추가
        }
        
        // 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
        return bookList;  // 카테고리 ID가 일치하는 책 목록 반환
    }

    
    
    /**
     * 
     * @return
     */
    // 비동기로 북 목록을 반환하는 API
    @GetMapping("/api/books")
    @ResponseBody
    public List<BookDTO> getBooks() {
		List<Book>toBookList=writerService.readAllBookList();
		List<BookDTO> bookList=new ArrayList<>();
		for (Book book : toBookList) {
			bookList.add(book.toBookDTO());
		}
    	
    	return bookList;  // JSON 형식으로 클라이언트에 응답
    }
	
    /**
     * 채팅창 열기
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
