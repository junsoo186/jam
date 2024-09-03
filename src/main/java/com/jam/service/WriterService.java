package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.BookDTO;
import com.jam.dto.StoryDTO;
import com.jam.repository.interfaces.BookRepository;
import com.jam.repository.interfaces.StoryRepository;
import com.jam.repository.interfaces.TagRepository;
import com.jam.repository.model.Book;
import com.jam.repository.model.Story;
import com.jam.repository.model.Tag;
import com.jam.repository.model.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WriterService {

	// TODO - 검색 기능 추가(작가명, 장르, 태그, 카테고리)
	private final BookRepository bookRepository;
	private final StoryRepository storyRepository;
	private final TagRepository tagRepository;

	/**
	 * 책 생성 기능
	 * 
	 * @param bookDTO     생성할 책의 정보가 담긴 DTO 객체
	 * @param principalId 현재 로그인한 사용자의 ID
	 */
	@Transactional
	public int createBook(BookDTO bookDTO, User principal) {
		// BookDTO에 userId 설정
		bookDTO.setUserId(principal.getUserId());
		bookDTO.setAuthor(principal.getNickName());
		
		bookDTO.setAuthor(principal.getNickName());

		// 책 정보 저장 (bookId는 bookDTO에 자동으로 설정됩니다)
		bookRepository.insertBook(bookDTO);

		// 생성된 bookId 반환
		return bookDTO.getBookId();
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
		System.out.println(book.toString());
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
	public Integer createStory(StoryDTO storyDTO, Integer bookId, Integer principalId) {
		int result = 0;
		Story story = new Story();
		try {
			result = storyRepository.insertStory(storyDTO.toStroy(bookId, principalId));
			story = storyRepository.findStoryIdByBookIdAndUserId(bookId, principalId);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		if (result != 1) {
			// TODO - 오류 처리
		}
		System.out.println("storyId : " + story.toString());
		return story.getStoryId();
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
	public Story outputStoryContentByStoryId(Integer StoryId) {
		Story story = new Story();
		try {
			story = storyRepository.outputStoryContentByStoryId(StoryId);
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
	 * 
	 * @return
	 */
	public List<Tag> findTagName(Integer bookId) {
		List<Tag> tags = new ArrayList<>();
		tags = tagRepository.selectTagByBookId(bookId);
		return tags;
	}

	/**
	 * 작품 상세히
	 * 
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

	/**
	 * storyId로 Number 갱신 시키기
	 * 
	 * @param number
	 * @param storyId
	 */
	@Transactional
	public void updateNumberByStoryId(String number, Integer storyId) {
		storyRepository.updateNumberByStoryId(number, storyId);
	}

	/**
	 * 없는 태그시 생성
	 * 
	 * @param tagName 생성할 태그 이름
	 * @return 생성된 태그의 정보가 담긴 Tag 객체
	 */
	@Transactional
	public Tag insertTagName(String tagName) {
		Tag newTag = null;
		try {
			int result = tagRepository.insertTag(tagName);

			if (result == 1) {
				// 태그 삽입이 성공했을 경우, 삽입된 태그를 조회하여 반환
				newTag = tagRepository.findByName(tagName);
			} else {
				// 삽입 실패시 예외 발생
				throw new RuntimeException("Tag insertion failed for tag: " + tagName);
			}
		} catch (Exception e) {
			// TODO - 예외 처리 (예: 로그 기록)
			e.printStackTrace();
			throw new RuntimeException("An error occurred while inserting the tag: " + tagName, e);
		}

		return newTag;
	}

	public List<Tag> selectAllTags() {
		List<Tag> tags = new ArrayList<Tag>();
		tags = tagRepository.selectAllTags();
		return tags;
	}

	public Tag selectByName(String tagName) {
		Tag tags = null;
		tags =  tagRepository.findByName(tagName);
		return tags;
	}
	
	public void insertTagIdAndBookId(Integer bookId, Integer tagId) {
		try {
			// 데이터베이스에 bookId와 tagId를 삽입
			tagRepository.insertTagIdAndBookId(bookId, tagId);
		} catch (Exception e) {
			// 예외 처리: 오류 발생 시 로그 출력 및 예외 전파
			e.printStackTrace();
			throw new RuntimeException("Failed to insert bookId and tagId into book_tag_tb", e);
		}
	}

	public void updateTagIdByBookId(Integer bookId, Integer tagId) {
		try {
			tagRepository.updateTagIdByBookId(bookId, tagId);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
