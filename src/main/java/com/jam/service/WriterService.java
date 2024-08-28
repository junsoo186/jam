package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.BookDTO;
import com.jam.dto.StoryDTO;
import com.jam.repository.interfaces.BookRepository;
import com.jam.repository.interfaces.StoryRepository;
import com.jam.repository.model.Book;
import com.jam.repository.model.Story;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WriterService {

	// TODO - 검색 기능 추가(작가명, 장르, 태그, 카테고리)
	private final BookRepository bookRepository;
	private final StoryRepository storyRepository;

	/**
	 * 책 생성 기능
	 * 
	 * @param bookDTO     생성할 책의 정보가 담긴 DTO 객체
	 * @param principalId 현재 로그인한 사용자의 ID
	 */
	@Transactional
	public void createBook(BookDTO bookDTO, Integer principalId) {
		// 책 생성 결과를 저장할 변수
		int result = 0;

		try {
			// Book 객체를 생성하고 데이터베이스에 삽입
			result = bookRepository.insertBook(bookDTO.toBook(principalId));

			// 생성된 Book ID를 가져옴
			int bookId = bookDTO.getBookId();

			// 카테고리, 장르, 태그 정보도 삽입
			bookRepository.insertBookCategories(bookDTO.getCategoryNames(), bookId);
			bookRepository.insertBookGenres(bookDTO.getGenreNames(), bookId);
			bookRepository.insertBookTags(bookDTO.getTagNames(), bookId);

		} catch (Exception e) {
			// 예외가 발생하면 로그를 기록하고, 필요시 사용자에게 적절한 메시지를 전달할 수 있음
			e.printStackTrace(); // 예외 스택 트레이스를 출력하여 문제를 파악
		}

		// 책 생성이 실패한 경우 처리
		if (result != 1) {
			// 생성 실패 시 수행할 로직을 추가
		}
	}

	/**
	 * 전체 책 리스트
	 * 
	 * @return
	 */
	public List<Book> readAllBookList() {
		List<Book> books = new ArrayList<Book>();
		// TODO - 페이징 추가
		// TODO - 오류 처리
		try {
			books = bookRepository.AllBookList();
		} catch (Exception e) {

		}
		return books;
	}

	/**
	 * 작성한 책 리스트
	 * 
	 * @param principalId // 현재 사용자
	 * @return
	 */
	public List<Book> readAllBookListByprincipalId(Integer principalId) {
		List<Book> books = new ArrayList<Book>();
		// TODO - 페이징 추가
		// TODO - 오류 처리
		try {
			books = bookRepository.AllBookListByUserId(principalId);
		} catch (Exception e) {

		}
		return books;
	}

	/**
	 * 책 수정
	 * 
	 * @param book
	 */
	@Transactional
	public void updateBook(Book book) {
		int result = 0;
		// TODO - 오류 처리
		try {
			result = bookRepository.updateBook(book);
		} catch (Exception e) {

		}
		if (result != 1) {
			// TODO - 오류 처리
		}
	}

	/**
	 * 책 삭제
	 * 
	 * @param bookId
	 */
	public void deleteBook(Integer bookId) {
		try {
			bookRepository.deleteBook(bookId);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
	}

	/**
	 * 회차 생성
	 * 
	 * @param storyDTO
	 * @param bookId      책 번호
	 * @param principalId 작가 번호
	 */
	@Transactional
	public void createStory(StoryDTO storyDTO, Integer bookId, Integer principalId) {
		int result = 0;
		try {
			// TODO - 사용자 ID 테스트값 1로 고정, 나중에 principalId로 수정
			result = storyRepository.insertStory(storyDTO.toStroy(bookId, principalId));
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		if (result != 1) {
			// TODO - 오류 처리
		}
	}

	/**
	 * BookId 기준 회차 조회
	 * 
	 * @param bookId
	 * @return
	 */
	public List<Story> findAllStoryByBookId(Integer bookId) {
		List<Story> stories = new ArrayList<Story>();
		try {
			stories = storyRepository.findAllStoryByBookId(bookId);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		return stories;
	}

	/**
	 * 회차 내용 출력
	 * 
	 * @param storyId
	 * @param number
	 * @return
	 */
	public Story outputStoryContentByNumber(Integer number) {
		Story story = new Story();
		try {
			story = storyRepository.outputStoryContentByNumber(number);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		return story;
	}

	/**
	 * 회차 수정
	 * 
	 * @param story
	 */
	@Transactional
	public void updateStory(Story story) {
		int result = 0;
		try {
			result = storyRepository.updateStory(story);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		if (result != 1) {
			// TODO - 오류 처리
		}
	}

	/**
	 * 회차 조회수 증가
	 * 
	 * @param storyId
	 */
	@Transactional
	public void storyViewCountUp(Integer storyId) {
		try {
			storyRepository.storyViewCountUp(storyId);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
	}

	/**
	 * 회차 삭제 - 회의 내용
	 * 
	 * @param storyId
	 */
	@Transactional
	public void deleteStory(Integer storyId) {
		try {
			storyRepository.deleteStory(storyId);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
	}
	
	/**
	 * 태그 리스트 출력
	 * @return
	 */
	public List<String> findTagName() {
		List<String> tags = new ArrayList<>();
		tags = bookRepository.findTagName();
		return tags;
	}

	/**
	 * 없는 태그시 생성
	 * @param tagName
	 */
	@Transactional
	public void insertTagName(String tagName) {
		int result = 0;
		try {
			result = bookRepository.insertTagName(tagName);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		if (result != 1) {
			// TODO - 오류 처리
		}
	}

	/**
	 * 작품 상세히
	 * @param bookId
	 * @return
	 */
	public Book detailBook(Integer bookId) {
		Book book = new Book();
		try {
			book = bookRepository.detailBookByBookId(bookId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return book;
	}
}
