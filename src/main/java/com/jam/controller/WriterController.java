package com.jam.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.BookDTO;
import com.jam.dto.StoryDTO;
import com.jam.repository.interfaces.ProjectRepository;
import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.Project;
import com.jam.repository.model.Story;
import com.jam.repository.model.Tag;
import com.jam.repository.model.User;
import com.jam.service.FundingService;
import com.jam.service.WriterService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/write")
public class WriterController {

	private final WriterService writerService;
	// private final BennerService bennerService; 
	private final HttpSession session;

	private final FundingService fundingService;

	// TODO - 검색 기능 추가

	/**
	 * 작품 목록 출력
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/workList")
public String handleWorkList(
    @RequestParam(name = "bookId", required = false) Integer bookId, 
    @RequestParam(name = "page", defaultValue = "1") int page,
    @RequestParam(name = "size", defaultValue = "4") int size,
    Model model,
    HttpServletRequest request) {

		if (bookList.isEmpty()) {
			model.addAttribute("bookList", null);
		} else {
			model.addAttribute("bookList", bookList);
		}
		return "write/workList";
	}
	
    User principal = (User) request.getSession().getAttribute("principal");
    List<Book> bookList = writerService.readAllBookListByprincipalId(principal.getUserId());

    for (Book book : bookList) {
        String bookImg = book.setUpUserImage();
        book.setBookCoverImage(bookImg);
    }

    // 기본값 설정: bookId가 없으면 첫 번째 책을 선택
    if (bookId == null && !bookList.isEmpty()) {
        bookId = bookList.get(0).getBookId();
    }

    int totalRecords = 0;
    int totalPages = 0;
    Map<Integer, List<Story>> storyMap = new HashMap<>();

    if (bookId != null) {
        totalRecords = writerService.countStoriesByBookId(bookId);
        totalPages = (int) Math.ceil((double) totalRecords / size);

        List<Story> storyList = writerService.findAllStoryByBookIdPage(bookId, page, size);
        storyMap.put(bookId, storyList != null ? storyList : new ArrayList<>()); // 이야기 목록 초기화
    }

    model.addAttribute("bookList", bookList);
    model.addAttribute("storyMap", storyMap);
    model.addAttribute("currentPage", page);
    model.addAttribute("totalPages", totalPages);
    model.addAttribute("size", size);
    model.addAttribute("bookId", bookId);

    // AJAX 요청에 대한 처리
    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
        return "write/workListPartial"; // Partial View 반환
    }

    return "write/workList";
}
	// TODO - 전체 작품 리스트 추가

	/**
	 * 작품 작성 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/workInsert")
	public String handleWorkInsert(Model model) {
		List<Category> categories = new ArrayList<>();
		List<Genre> genres = new ArrayList<>();

		categories = writerService.findAllCategory();
		genres = writerService.findAllGenre();

		model.addAttribute("category", categories);
		model.addAttribute("genre", genres);
		return "write/workInsert";
	}

	/**
	 * 작품 작성 처리 -> 생성 후 작품 리스트로 이동
	 * 
	 * @param bookDTO 작품 정보가 담긴 DTO 객체
	 * @return 작품 리스트 페이지로 리다이렉트
	 */
	@PostMapping("/workInsert")
	public String completedWorkProc(@RequestParam("bookCover") MultipartFile bookCover,
	BookDTO bookDTO) {
		User principal = (User) session.getAttribute("principal");

		// 유효성 검사 (생략)

		// 모든 태그 목록을 가져오기
		List<Tag> existingTags = writerService.selectAllTags();
		List<String> tagNames = bookDTO.getCustomTag();
		List<Integer> tagIdsToInsert = new ArrayList<>();
		bookDTO.setBookCover(bookCover);
		// 현재 존재하는 태그들과 bookDTO의 태그 이름들을 비교합니다.
		for (String tagName : tagNames) {
			boolean tagExists = false;
			int tagId = -1;

			// 태그가 이미 존재하는지 확인
			for (Tag tag : existingTags) {
				if (tag.getTagName().equalsIgnoreCase(tagName)) {
					tagExists = true;
					tagId = tag.getTagId(); // 이미 존재하는 태그의 ID 저장
					break;
				}
			}

			// 태그가 존재하지 않으면 새로 추가하고 ID 가져오기
			if (!tagExists) {
				Tag newTag = writerService.insertTagName(tagName);
				tagId = newTag.getTagId();
			}

			// 태그 ID를 삽입 리스트에 추가
			tagIdsToInsert.add(tagId);
		}

		// 책 생성 및 bookId 가져오기
		Integer bookId = writerService.createBook(bookDTO, principal);

		// book_tag_tb 테이블에 bookId와 tagId들을 삽입합니다.
		for (Integer tagId : tagIdsToInsert) {
			writerService.insertTagIdAndBookId(bookId, tagId);
		}

		// 작품 리스트 페이지로 리다이렉트
		return "redirect:/write/workList";
	}

	/**
	 * 회차 작성 페이지 이동
	 * 
	 * @return
	 */
	@GetMapping("/storyInsert")
	public String handleStoryInsert(@RequestParam(name="bookId") int bookId, Model model) {
		model.addAttribute("bookId", bookId);
		return "write/storyInsert";
	}

	/**
	 * 회차 작성 처리 -> 작성 후 내용 출력 화면으로 이동
	 * 
	 * @return
	 */
	@PostMapping("/storyInsert")
	public String StoryInsertProc(StoryDTO storyDTO, @RequestParam("bookId") Integer bookId) {
		User principal = (User) session.getAttribute("principal");
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

		Integer storyId = writerService.createStory(storyDTO, bookId, principal.getUserId());
		return "redirect:/write/storyContents?storyId=" + storyId;
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
		List<Story> storyList = writerService.findAllStoryByBookId(bookId);
		User principal = (User) session.getAttribute("principal");
		Book bookDetail = writerService.detailBook(bookId); // bookId로 책의 상세 정보를 가져옴
		String bookImg = bookDetail.setUpUserImage(); // 책의 이미지 경로를 설정
		bookDetail.setBookCoverImage(bookImg); // 설정한 이미지 경로를 Book 객체에 저장

		Project project = fundingService.findProjectByBookId(bookDetail.getBookId());

		model.addAttribute("bookId", bookId);
		model.addAttribute("bookDetail", bookDetail);
		model.addAttribute("principalId", principal.getUserId());
		model.addAttribute("project", project);


		// 디버깅을 위해 각 Story 객체의 userId를 출력

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
		String bookImg = bookDetail.setUpUserImage(); // 책의 이미지 경로를 설정
		bookDetail.setBookCoverImage(bookImg); // 설정한 이미지 경로를 Book 객체에 저장

		String tagNames = bookDetail.getTagNames();
		String[] tagsArray = tagNames.split(",");
		List<String> tagList = new ArrayList<String>();
		Collections.addAll(tagList, tagsArray);

		// 모든 태그 목록을 가져오기
		List<Tag> existingTags = writerService.selectAllTags();

		List<Tag> selectTags = new ArrayList<>();
		List<Category> categories = new ArrayList<>();
		List<Genre> genres = new ArrayList<>();

		categories = writerService.findAllCategory();
		genres = writerService.findAllGenre();

		model.addAttribute("category", categories);
		model.addAttribute("genre", genres);

		Tag resultTag = new Tag();
		for (Tag tags : existingTags) {

			for (String tag : tagList) {

				if (tags.getTagName().equals(tag)) {
					resultTag = writerService.selectByName(tag);
					selectTags.add(resultTag);
				}
			}
		}
		model.addAttribute("selectTags", selectTags);
		model.addAttribute("bookId", bookId);
		model.addAttribute("bookDetail", bookDetail);
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
		Book book = bookDTO.updateBook(bookId); // 업데이트에 필요한 빌드
		System.out.println("book" + book);

		// 존재하는 태그
		List<Tag> existingTags = writerService.selectAllTags();

		// 수정하려는 태그
		List<String> tagNames = bookDTO.getCustomTag();

		// 없는 태그를 추가할 변수
		List<Integer> tagIdsToInsert = new ArrayList<>();

		// 현재 존재하는 태그들과 bookDTO의 태그 이름들을 비교합니다.
		for (String tagName : tagNames) {
			boolean tagExists = false;
			int tagId = -1;

			// 태그가 이미 존재하는지 확인
			for (Tag tag : existingTags) {
				if (tag.getTagName().equalsIgnoreCase(tagName)) {
					tagExists = true;
					tagId = tag.getTagId(); // 이미 존재하는 태그의 ID 저장
					System.out.println("태그확인");
					break;
				}
			}

			// 태그가 존재하지 않으면 새로 추가하고 ID 가져오기
			if (!tagExists) {
				Tag newTag = writerService.insertTagName(tagName);
				tagId = newTag.getTagId();
				System.out.println("태그추가");
			}

			// 태그 ID를 삽입 리스트에 추가
			tagIdsToInsert.add(tagId);
		}

		// 책 생성 및 bookId 가져오기

		// 중복 삽입 방지를 위해 book_tag_tb 테이블에 해당 bookId와 tagId들이 이미 존재하는지 확인
		List<Tag> existingBookTag = writerService.findTagName(bookId);// bookId와 일치하는 태그리스트
		List<Integer> existingBookTagIds = new ArrayList<>();// 태그리스트의 tagId추가 변수
		for (Tag tag : existingBookTag) {
			existingBookTagIds.add(tag.getTagId());// 추가
		}
		// book_tag_tb 테이블에 bookId와 tagId들을 삽입합니다.
		for (Integer tagId : tagIdsToInsert) {
			if (!existingBookTagIds.contains(tagId)) { // 추가한 값에 tagId가 없을경우
				writerService.insertTagIdAndBookId(bookId, tagId);// INSERT구문 실행
				System.out.println("tagId:" + tagId);
			}
		}
		// 이미지 처리

		// 변환된 Book 객체를 사용하여 업데이트 작업 수행
		try {
			writerService.updateBook(book, bookDTO); // writerService는 Book을 업데이트하는 서비스
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		return "redirect:/write/workDetail?bookId=" + bookId;
	}

	@PostMapping("/workDelete")
	public String workDeleteProc(BookDTO bookDTO) {

		System.out.println("bookDTO임" + bookDTO.getBookId());
		writerService.deleteStory(bookDTO.getBookId());

		return "redirect:/write/workList";
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