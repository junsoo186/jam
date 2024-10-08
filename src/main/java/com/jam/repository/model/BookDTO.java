package com.jam.repository.model;

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

	private Integer userId;
	private Integer bookId;
	private String title;
	private String authorComment;
	private String author;
	private String introduction;
	private String bookCoverImage;
	private Integer categoryId;
	private Integer genreId;
	private String serialDay;
	private List<String> customTag;
	private String age;

	public Book toBook(Integer userId) {
		return Book.builder().userId(userId).title(this.title).authorComment(this.authorComment).author(this.author)
				.serialDay(this.serialDay).categoryId(this.categoryId).genreId(this.genreId)
				.introduction(this.introduction).age(this.age).build();
	}

	public Book updateBook(Integer bookId) {
		return Book.builder().bookId(bookId).title(this.title).authorComment(this.authorComment)
				.introduction(this.introduction).serialDay(this.serialDay).age(this.age).customtags(this.customTag)
				.build();
	}
}
