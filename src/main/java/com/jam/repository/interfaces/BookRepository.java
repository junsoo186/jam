package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.dto.BookDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Category;
import com.jam.repository.model.Genre;

@Mapper
public interface BookRepository {

	// 책 생성
	public int insertBook(BookDTO bookDTO);

	// 책 생성시 카테고리
	public int insertBookCategories(@Param("categoryId") String categoryId, @Param("bookId") Integer bookId);
	// 책 생성시 장르
	public int insertBookGenres(@Param("genreId") String genreId, @Param("bookId") Integer bookId);
	// 책 생성시 태그
	public int insertBookTags(@Param("tagIds") List<String> tagIds, @Param("bookId") Integer bookId);

	// TODO - 페이징 처리 추가
	// 책 리스트
	public List<Book> AllBookList();
	
	// 책 리스트(요일)
	public List<Book> AllBookSerial();
	
	// 책 요일(복수X)
	public List<Book> findSerialDay();
	
	// 책 리스트 -변수1(오름차순,내림차순),변수2(좋아요,조회순),변수3(카테고리)
	public List<Book> AllBookListCategoryOrderBy(@Param("categoryId") int categoryId,
											@Param("filter") String filter,
	          								@Param("order") String order);

	// 책 리스트- 변수1,2동일 변수3(장르)
	public List<Book> AllBookListGenreOrderBy(@Param("genreId") int genreId,
											   @Param("filter") String filter,
											   @Param("order") String order);
	
	
	// userId 기반 책 리스트
	public List<Book> findAllBookListByUserId(Integer userId);

	// 책 자세히
	public Book detailBookByBookId(@Param("bookId") Integer bookId);

	public int updateBook(Book book);

	public void bookViewCountUp(@Param("bookId") Integer bookId);

	public void deleteBook(@Param("bookId") Integer bookId);

	public Book findBookByBookId(Integer bookId);
	
	public List<Category> findAllCategory();

	public List<Genre> findAllGenre();

}
