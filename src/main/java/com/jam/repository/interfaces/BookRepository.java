package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Book;

public interface BookRepository {

	public int insertBook(Book book);

	public List<Book> AllBookList(@Param("limit") Integer limit, @Param("offset") Integer offset);
	
	public Book detailBookByBookId(@Param("bookId") Integer bookId);
	
	public int updateBook(Book book);
	
	public void bookViewCountUp(@Param("bookId") Integer bookId);
	
	public void deleteBook(@Param("bookId") Integer bookId);
}
