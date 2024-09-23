package com.jam.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.dto.MainBannerDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.MainBanner;
import com.jam.repository.model.User;
import com.jam.service.ChatService;
import com.jam.service.MainBannerService;
import com.jam.service.SearchService;
import com.jam.service.WriterService;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MainCotroller {

    private final WriterService writerService;
    private final MainBannerService mainBannerService;
    private final SearchService searchService;
    private final ChatService chatService;

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
     * 배너 페이징 비동기처리
     * 
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/api/main-banners")
    @ResponseBody
    public MainBannerDTO getMainBanners(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "3") int size) {

        List<MainBanner> mainBannerList = mainBannerService.readAllMainBanner(page, size);
        MainBannerDTO mainBannerDTO = new MainBannerDTO();
        int sumCount = mainBannerService.countAllBanner();

        for (MainBanner mainBanner : mainBannerList) {
            mainBanner.setImagePath(mainBanner.setUpUserImage());
        }
        mainBannerDTO.setMainBannerList(mainBannerList);
        mainBannerDTO.setTotalBanners(sumCount);
        return mainBannerDTO;
    }

    /**
     * 카테고리-비동기로 카테고리 목록을 반환하는 API
     * 
     * @return
     */
    @GetMapping("/api/categories")
    @ResponseBody
    public List<Category> getCategories() {
        List<Category> categoryList = writerService.findAllCategory();

        return categoryList; // JSON 형식으로 클라이언트에 응답
    }

    /**
     * 카테고리별 정렬
     * 
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

    /**
     * 장르
     * 
     * @return
     */
    @GetMapping("/api/genres")
    @ResponseBody
    public List<Genre> getGenre() {
        List<Genre> genreList = writerService.findAllGenre();
        return genreList;
    }

    /**
     * 장르별 정렬
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

    /**
     * 요일
     * 
     * @return
     */
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
     * TODO 1 추출 변수값(요일, views(views,likes가 orderby가 필요한지 확실하지않아서 그냥받아옴)
     * TODO 2. xml,레포지토리,서비스,컨트롤러 까지 만들고 값보냄 3.js에서 views 정렬이 가능한지 체크
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
     * 당일 views 정렬
     * 
     * @param order
     * @return
     */
    @GetMapping("/api/bookDayViews")
    @ResponseBody
    public List<Book> getBookDayViews(@RequestParam("order") String order) {

        List<Book> bookList = writerService.readTodayViews(order);

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
    	// 현재 사용자의 userId를 가져옴
		String userId = String.valueOf(principal.getUserId());
		
		// 현재 존재하는 모든 채팅방의 목록을 가져옴
        Set<String> roomIds = chatService.getChatRoomList();    
		
        // userId에 해당하는 채팅방이 이미 존재하는지 확인
        if (roomIds.contains(userId)) {
        // 존재하는 방이 있으면 해당 방으로 리다이렉트
        	// 데이터를 전달하기 위한 객체
            model.addAttribute("roomId", userId);
        } else {
        // 존재하는 방이 없으면 새로운 방을 생성
            chatService.createNewRoom(userId);
            // 데이터를 전달하기 위한 객체
            model.addAttribute("roomId", userId);
        }
        
        // 사용자 정보를 모델에 추가
	    String nickname = principal.getNickName();
	    String profileImg = principal.getProfileImg();
	    
	    // 데이터를 전달하기 위한 객체
	    model.addAttribute("nickname", nickname);
	    model.addAttribute("userId", userId);
	    model.addAttribute("profileImg", profileImg); // 프로필 이미지 추가
	    
	    // 채팅 페이지로 이동
	    return "/chatPage";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<Book> searchBooks(@RequestParam("q") String searchTerm) {
        List<Book> books = searchService.searchBooks(searchTerm);
        for (Book book : books) {
            book.setBookCoverImage(book.setUpUserImage());
        }
        return books;
    }

    @GetMapping("/search-page")
    @ResponseBody
    public List<Book> getMethodName(@RequestParam("q") String searchTerm, Model model) {
        List<Book> books = searchService.searchBooks(searchTerm);
        for (Book book : books) {
            book.setBookCoverImage(book.setUpUserImage());
        }
        return books;
    }

    @GetMapping("/searchResult")
    public String getMethodName() {
        return "layout/search";
    }
    

    // @GetMapping("/search")
    // public String searchBooks(@RequestParam("q") String searchTerm, Model model)
    // {
    // List<Book> searchResults = searchService.searchBooks(searchTerm);
    // model.addAttribute("results", searchResults);
    // return "layout/search"; // search.jsp 뷰를 반환
    // }

    // @GetMapping("/chatRoom{}")
    // public String chatRoom(@SessionAttribute(Define.PRINCIPAL) User principal,
    // Model model) {
    // String nickname = principal.getNickName();
    // model.addAttribute("nickname",nickname );
    // return "/chatPage";
    // }
    //
    //
    // @GetMapping("/chat")
    // public String chating(){
    //
    // return "chat";
    // }
    
    /**
	 * 관리자 채팅방 목록 페이지
	 * @param model  채팅방 목록을 뷰로 전달하기 위한 객체
	 * @return /admin/chatRooms (관리자용 채팅방 목록 페이지 JSP)
	 */
    @GetMapping("/admin/chatRooms")
    public String adminChatRooms(Model model) {
    	
    	// 현재 존재하는 모든 채팅방 목록을 가져옴
        Set<String> roomIds = chatService.getChatRoomList();
        
        // 모델에 채팅방 목록을 추가
        model.addAttribute("roomIds", roomIds);
        System.out.println("roomIds : " + roomIds);
        
        // 관리자 채팅방 목록 페이지로 이동
        return "/admin/chatRooms"; 
    }
    
    /**
     * 관리자가 특정 채팅방에 접속하는 페이지
     * @param roomId 접속하려는 채팅방의 ID
     * @param model 해당 채팅방의 정보를 뷰로 전달하기 위한 객체
     * @param principal 현재 세션의 관리자 정보
     * @return admin/chatRoom (관리자용 채팅방 페이지 JSP)
     */
    @GetMapping("/admin/chatRoom/{roomId}")
    public String adminChatRoom(@PathVariable(name = "roomId") String roomId, Model model, @SessionAttribute(Define.PRINCIPAL) User principal) {
    	
    	// 요청한 roomId에 해당하는 채팅방이 존재하는지 확인
    	if (chatService.isRoomExist(roomId)) {
    		
    		String nickname = principal.getNickName();
    		String profileImg = principal.getProfileImg();
    		
    		 // 채팅방이 존재하면 관리자 정보(닉네임, 프로필 이미지)를 모델에 추가
    		model.addAttribute("profileImg", profileImg);  
    		model.addAttribute("nickname", nickname);  
    		
    		// 해당 채팅방 ID를 모델에 추가하여 뷰로 전달
            model.addAttribute("roomId", roomId);  
            // 관리자 채팅방 페이지로 이동
            return "admin/chatRoom";
        } else {
        	// 채팅방이 존재하지 않으면 채팅방 목록 페이지로 리다이렉트
            return "redirect:/admin/chatRooms";
        }
    }

}