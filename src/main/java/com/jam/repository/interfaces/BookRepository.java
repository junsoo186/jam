package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Book;

@Mapper
public interface BookRepository {

	// 책 생성
	public int insertBook(Book book);

	// 책 생성시 카테고리
	public int insertBookCategories(List<String> categoryIds, int bookId);
	// 책 생성시 장르
	public int insertBookGenres(List<String> genreIds, int bookId);
	// 책 생성시 태그
	public int insertBookTags(List<String> tagIds, int bookId);

	// TODO - 페이징 처리 추가
	// 책 리스트
	public List<Book> AllBookList();

	// userId 기반 책 리스트
	public List<Book> AllBookListByUserId(Integer userId);

	// 책 자세히
	public Book detailBookByBookId(@Param("bookId") Integer bookId);

	public int updateBook(Book book);

	public void bookViewCountUp(@Param("bookId") Integer bookId);

	public void deleteBook(@Param("bookId") Integer bookId);

	public int insertTagName(String tagName); // 태그 추가
	
	public List<String> findTagName();
}
