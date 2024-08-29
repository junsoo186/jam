package com.jam.dto;

import java.util.List;

import com.jam.repository.model.Book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString

public class BookDTO {

	private Integer bookId;
	private String title;
	private String authorComment;
	private String author;
	private String introduction;
	private String bookCoverImage;
    private String categoryName;  
    private String genreName;
    private String serialDay;
    private List<String> tagNames;       
	private String age;
	
	public Book toBook(Integer userId) {
		return Book.builder()
				.userId(userId)
				.title(this.title)
				.authorComment(this.authorComment)
				.author(this.author)
				.bookCoverImage(this.bookCoverImage)
				.categoryName(this.categoryName)
				.genreName(this.genreName)
				.tagNames(this.tagNames)
				.age(this.age)
				.build();
	}
	
	public Book updateBook(Integer bookId) {
		return Book.builder()
				.bookId(bookId)
				.title(this.title)
				.authorComment(this.authorComment)
				.introduction(this.introduction)
				.serialDay(this.serialDay)
				.age(this.age)
				.build();
	}
}
