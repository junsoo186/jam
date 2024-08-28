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

public class CreateBookDTO {

	private Integer bookId;
	private String titel;
	private String authorComment;
	private String author;
	private String bookCoverImage;
    private List<Integer> categoryIds;  
    private List<Integer> genreIds;     
    private List<Integer> tagIds;       
	private String age;
	
	public Book createBook(Integer userId) {
		return Book.builder()
				.userId(userId)
				.title(this.titel)
				.authorComment(this.authorComment)
				.author(this.author)
				.bookCoverImage(this.bookCoverImage)
				.categoryIds(this.categoryIds)
				.genreIds(this.genreIds)
				.tagIds(this.tagIds)
				.age(this.age)
				.build();
	}
}
