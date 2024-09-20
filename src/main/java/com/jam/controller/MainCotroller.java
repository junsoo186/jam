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

import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.MainBanner;
import com.jam.repository.model.User;
import com.jam.service.ChatService;
import com.jam.service.MainBannerService;
import com.jam.service.WriterService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class MainCotroller {
	
	private final WriterService writerService;
	private final MainBannerService mainBannerService;
	private final ChatService chatService;
	private final HttpSession session;
	
	
	/**
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/")
	public String mainPage(Model model) {
		List<Book>bookList=writerService.readAllBookList();
        List<Category> categoryList = writerService.findAllCategory();
        List<Genre> genreList= writerService.findAllGenre();

        
		model.addAttribute("bookList",bookList);
		model.addAttribute("categoryList",categoryList);
		model.addAttribute("genreList",genreList);
		return "/index";
	}
	
	/**
	 * 배너 페이징 비동기처리
	 * @param page
	 * @param size
	 * @return
	 */
    @GetMapping("/api/main-banners")
    @ResponseBody
    public List<MainBanner> getMainBanners(
            @RequestParam(name = "page" ,defaultValue = "1") int page, 
            @RequestParam(name = "size" ,defaultValue = "3") int size) {
		List<MainBanner> mainBannerList=mainBannerService.readAllMainBanner(page,size);
		for (MainBanner mainBanner : mainBannerList) {
			 mainBanner.setImagePath(mainBanner.setUpUserImage());
		}
        return mainBannerList;
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
        
        
        return categoryList;  // JSON 형식으로 클라이언트에 응답
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
									          @RequestParam("filter") String filter,     // 정렬 기준 (조회수 또는 좋아요)
									       @RequestParam("order") String order) {    // 정렬 순서 (오름차순 또는 내림차순)) {
        // 책 목록 가져오기
        List<Book> bookList = writerService.readAllBooksByCategoryIdOrder(categoryId,filter,order);
        for (Book book : bookList) {
        	book.setBookCoverImage(book.setUpUserImage());
		}
        
        // 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
        return bookList;  // 카테고리 ID가 일치하는 책 목록 반환
    }


    
    
    @GetMapping("/api/genres")
    @ResponseBody
    public List<Genre> getGenre(){
        List<Genre> genreList= writerService.findAllGenre();
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
    		@RequestParam("filter") String filter,     // 정렬 기준 (조회수 또는 좋아요)
    		@RequestParam("order") String order){
    	List<Book> bookList = writerService.readAllBooksByGenreIdOrder(genreId,filter,order);
    	for (Book book : bookList) {
    		book.setBookCoverImage(book.setUpUserImage());
    	}
    	// 모든 책에 대해 카테고리 ID가 일치하는 책을 bookList에 추가
    	// 조건에 맞는 책이 하나도 없을 경우 빈 리스트 반환
    	return bookList;  // 카테고리 ID가 일치하는 책 목록 반환
    	
    }
    @GetMapping("/api/serial")
    @ResponseBody
    public List<String> getWeek(){
    	List<Book> bookList= writerService.readBookSerial();
    	List<String> weekList=new ArrayList<>();
    	for (Book book : bookList) {
    		weekList.add(book.getSerialDay());
		}
    	return weekList;
    	
    }
    
    /**
     *  TODO 1 추출 변수값(요일, views(views,likes가 orderby가 필요한지 확실하지않아서 그냥받아옴)
     *  TODO 2. xml,레포지토리,서비스,컨트롤러 까지 만들고 값보냄 3.js에서 views 정렬이 가능한지 체크
     * @return
     */
    @GetMapping("/api/booksSerial")
    @ResponseBody
    public List<Book> getBooksSerial(@RequestParam("filter") String filter,     // 정렬 기준 (조회수 또는 좋아요)
    								@RequestParam("order") String order){
        List<Book> bookList= writerService.readAllbookSerial(filter,order);
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
		List<Book>bookList=writerService.readAllBookList();
    	
    	return bookList;  // JSON 형식으로 클라이언트에 응답
    }
	
    /**
     * // 사용자 채팅 페이지
     * @return
     */
	@GetMapping("/chatPage")
	public String chatPage(@SessionAttribute(Define.PRINCIPAL) User principal, Model model) {
		
		String userId = String.valueOf(principal.getUserId());  // 현재 사용자의 userId
        Set<String> roomIds = chatService.getChatRoomList();    // 현재 존재하는 방 목록
		
        // 해당 userId에 해당하는 방이 있는지 확인
        if (roomIds.contains(userId)) {
            // 이미 존재하는 방으로 리다이렉트
            model.addAttribute("roomId", userId);
        } else {
            // 새로운 방 생성
            chatService.createNewRoom(userId);
            model.addAttribute("roomId", userId);
        }
		
	    String nickname = principal.getNickName();
	    String profileImg = principal.getProfileImg();
	    
	    model.addAttribute("nickname", nickname);
	    model.addAttribute("userId", userId);
	    model.addAttribute("profileImg", profileImg); // 프로필 이미지 추가
	   
	    System.out.println("@@" +nickname);
	    System.out.println("@@" +nickname);
	    
	    return "/chatPage";
	}
	
	// 관리자 채팅방 목록 페이지
    @GetMapping("/admin/chatRooms")
    public String adminChatRooms(Model model) {
        // 채팅방 목록 가져오기 (추후 서비스로부터 실제 목록을 불러와야 함)
        Set<String> roomIds = chatService.getChatRoomList();  // 예: 채팅방 목록을 가져오는 로직
        model.addAttribute("roomIds", roomIds);
        System.out.println("roomIds : " + roomIds);
        return "/admin/chatRooms";  // 관리자 채팅방 목록 페이지로 이동
    }


	// 관리자가 특정 채팅방에 들어가는 페이지
    @GetMapping("/admin/chatRoom/{roomId}")
    public String adminChatRoom(@PathVariable(name = "roomId") String roomId, Model model, @SessionAttribute(Define.PRINCIPAL) User principal) {
    	if (chatService.isRoomExist(roomId)) {
    		
    		String nickname = principal.getNickName();
    		String profileImg = principal.getProfileImg();
    		
    		
    		model.addAttribute("profileImg", profileImg);  // 존재하는 방일 경우만 roomId 전달
    		model.addAttribute("nickname", nickname);  // 존재하는 방일 경우만 roomId 전달
            model.addAttribute("roomId", roomId);  // 존재하는 방일 경우만 roomId 전달
            return "admin/chatRoom";  // admin/chatRoom.jsp로 이동
        } else {
            return "redirect:/admin/chatRooms";  // 방이 없으면 목록 페이지로 리다이렉트
        }
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