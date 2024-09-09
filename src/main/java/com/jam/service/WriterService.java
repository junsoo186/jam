package com.jam.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.BookDTO;
import com.jam.dto.StoryDTO;
import com.jam.dto.UserDTO;
import com.jam.repository.interfaces.BookRepository;
import com.jam.repository.interfaces.StoryRepository;
import com.jam.repository.interfaces.TagRepository;
import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;
import com.jam.repository.model.Story;
import com.jam.repository.model.Tag;
import com.jam.repository.model.User;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WriterService {

	// TODO - 검색 기능 추가(작가명, 장르, 태그, 카테고리)
	private final BookRepository bookRepository;
	private final StoryRepository storyRepository;
	private final TagRepository tagRepository;
	
	@Value("${file.upload-dir}")
	private String uploadDir;


	/**
	 * 책 생성 기능
	 * 
	 * @param bookDTO     생성할 책의 정보가 담긴 DTO 객체
	 * @param principalId 현재 로그인한 사용자의 ID
	 */
	@Transactional
	public int createBook(BookDTO bookDTO, User principal) {
		System.out.println(bookDTO.toString());
		// BookDTO에 userId 설정
		bookDTO.setUserId(principal.getUserId());
		bookDTO.setAuthor(principal.getNickName());
		
		if (bookDTO.getBookCover() != null && !bookDTO.getBookCover().isEmpty()) {
			// 파일 업로드 로직 구현
			String[] fileNames = uploadFile(bookDTO.getBookCover());

			bookDTO.setOriginalBookCoverImage(fileNames[0]);
			bookDTO.setBookCoverImage(fileNames[1]);
		}
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
			books = bookRepository.findAllBookListByUserId(principalId);
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
	public void updateBook(Book book, BookDTO bookDTO) {
		int result = 0;
		String[] fileNames = uploadFile(bookDTO.getBookCover());
		System.out.println("책 경로 확인 : " + fileNames[1]);
		System.out.println("책 경로 확인 2 : " + bookDTO.getBookCoverImage());
		System.out.println("책 경로 확인 3 : " + bookDTO.getBookCover().toString());
		if (bookDTO.getBookCover() == null || bookDTO.getBookCover().isEmpty()) {
	        // 기존 이미지 경로를 유지하도록 로직을 추가
	        book.setBookCoverImage(bookDTO.getBookCoverImage()); // 기존 이미지 경로를 할당
	    } else {
	        // 업로드된 파일을 처리
	        book.setBookCoverImage(fileNames[1]); // 새로 업로드된 파일 경로를 설정
	    }
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
	    String directoryPath = "src/main/resources/static/contentText/";
	    String storyPath = directoryPath + storyDTO.getTitle() + ".txt";

	    // 디렉토리 생성 (존재하지 않을 경우)
	    File directory = new File(directoryPath);
	    if (!directory.exists()) {
	        directory.mkdirs(); // 경로에 있는 모든 디렉토리 생성
	    }

	    // 파일 생성 및 내용 저장
	    try {
	        File file = new File(storyPath);
	        FileWriter writer = new FileWriter(file);
	        writer.write(storyDTO.getContents());
	        writer.close();
	        System.out.println("작성 성공 ++++++++");
	    } catch (IOException e) {
	        // TODO: 파일 저장 중 오류 처리
	        e.printStackTrace();
	    }

	    // 스토리 데이터베이스에 저장
	    try {
	        result = storyRepository.insertStory(storyDTO.toStory(bookId, principalId, storyPath));
	        story = storyRepository.findStoryIdByBookIdAndUserId(bookId, principalId);
	    } catch (Exception e) {
	        // TODO - 오류 처리
	        e.printStackTrace();
	    }

	    if (result != 1) {
	        // TODO - 오류 처리
	        System.out.println("스토리 저장 실패");
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
	public Story outputStoryContentByStoryId(Integer storyId) {
		Story story = new Story();
	    try {
	        // 데이터베이스에서 Story 객체 가져오기
	        story = storyRepository.outputStoryContentByStoryId(storyId);

	        // Story 객체에 저장된 파일 경로 가져오기
	        String filePath = story.getContents(); // 'contents' 필드에 파일 경로가 저장되어 있다고 가정

	        // 파일 내용을 읽어서 Story 객체의 contents 필드에 설정
	        StringBuilder contentBuilder = new StringBuilder();
	        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
	            String line;
	            while ((line = reader.readLine()) != null) {
	                contentBuilder.append(line);
	                contentBuilder.append(System.lineSeparator());
	            }
	        } catch (IOException e) {
	            // TODO: 파일 읽기 오류 처리
	            e.printStackTrace();
	        }

	        // 파일에서 읽은 내용을 Story 객체에 설정
	        story.setContents(contentBuilder.toString());
	    } catch (Exception e) {
	        // TODO - 데이터베이스 조회 오류 처리
	        e.printStackTrace();
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

	/**
	 * 태그 전체 출력
	 * 
	 * @return
	 */
	public List<Tag> selectAllTags() {
		List<Tag> tags = new ArrayList<Tag>();
		tags = tagRepository.selectAllTags();
		return tags;
	}

	/**
	 * 태그 이름별 출력
	 * 
	 * @param tagName
	 * @return
	 */
	public Tag selectByName(String tagName) {
		Tag tags = null;
		tags = tagRepository.findByName(tagName);
		return tags;
	}

	/**
	 * 태그와 책 테이블에 삽입
	 * 
	 * @param bookId
	 * @param tagId
	 */
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

	/**
	 * 태그와 책테이블 갱신
	 * 
	 * @param bookId
	 * @param tagId
	 */
	public void updateTagIdByBookId(Integer bookId, Integer tagId) {
		try {
			tagRepository.updateTagIdByBookId(bookId, tagId);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	/**
	 * 모든 카테고리 리스트 불러오기
	 * 
	 * @return
	 */
	public List<Category> findAllCategory() {
		List<Category> categories = new ArrayList<>();
		categories = bookRepository.findAllCategory();
		return categories;
	}

	/**
	 * 모든 장르 리스트 불러오기
	 * 
	 * @return
	 */
	public List<Genre> findAllGenre() {
		List<Genre> genres = new ArrayList<>();
		genres = bookRepository.findAllGenre();
		return genres;
	}

	/**
	 * 서버 운영체제에 파일 업로드 기능 MultipartFile getOriginalFilename : 사용자가 작성한 파일 명
	 * uploadFileName : 서버 컴퓨터에 저장 될 파일 명
	 * 
	 * @param mFile
	 * @return
	 */
	private String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > Define.MAX_FILE_SIZE) {
			// TODO - 오류 처리
//			throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.", HttpStatus.BAD_REQUEST);
		}

		// 코드 수정
		// File - getAbsolutePath()
		// (리눅스 또는 MacOS)에 맞춰서 절대 경로 생성을 시킬 수 있다.
		String saveDirectory = new File(uploadDir).getAbsolutePath();

		// 파일 이름 생성(중복 이름 예방)
		String uploadFileName = UUID.randomUUID() + "_" + mFile.getOriginalFilename();
		// 파일 전체 경로 + 새로생성한 파일명
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		File destination = new File(uploadPath);
		
		// 반드시 수행
		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			// TODO - 오류 처리
//			e.printStackTrace();
//			throw new DataDeliveryException("파일 업로드 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { mFile.getOriginalFilename(), uploadFileName };
	}

}
