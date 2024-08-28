package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Book;

@Mapper
public interface BookRepository {

	public int insertBook(Book book);
	
	public int insertBookCategories(List<Integer> categoryIds, int bookId);

	public int insertBookGenres(List<Integer> genreIds, int bookId);
	
	public int insertBookTags(List<Integer> tagIds, int bookId);
	// TODO - 페이징 처리 추가
	public List<Book> AllBookList();

	public List<Book> AllBookListByUserId(Integer userId);

	public Book detailBookByBookId(@Param("bookId") Integer bookId);

	public int updateBook(Book book);

	public void bookViewCountUp(@Param("bookId") Integer bookId);

	public void deleteBook(@Param("bookId") Integer bookId);

	public int insertTagName(String tagName); // 태그 추가
}
