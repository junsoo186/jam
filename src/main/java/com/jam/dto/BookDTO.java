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
	private String bookCoverImage;
    private List<String> categoryNames;  
    private List<String> genreNames;     
    private List<String> tagNames;       
	private String age;
	
	public Book toBook(Integer userId) {
		return Book.builder()
				.userId(userId)
				.title(this.title)
				.authorComment(this.authorComment)
				.author(this.author)
				.bookCoverImage(this.bookCoverImage)
				.categoryNames(this.categoryNames)
				.genreNames(this.genreNames)
				.tagNames(this.tagNames)
				.age(this.age)
				.build();
	}
	
	public Book updateBook() {
		return Book.builder()
				.title(this.title)
				.authorComment(this.authorComment)
				.author(this.author)
				.bookCoverImage(this.bookCoverImage)
				.categoryNames(this.categoryNames)
				.genreNames(this.genreNames)
				.tagNames(this.tagNames)
				.age(this.age)
				.build();
	}
}
