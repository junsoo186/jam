package com.jam.dto;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	private String tagNames; 
	private String bookCoverImage;
	private String originalBookCoverImage;
	private Integer categoryId;
	private Integer genreId;
	private String serialDay;
	private List<String> customTag;
    private Timestamp createdAt;
	private String age;
	private MultipartFile bookCover;
    private Integer likes;	
    private Integer views;
	private String uploadPath;

	public Book toBook(Integer userId) {
		return Book.builder().userId(userId).title(this.title).authorComment(this.authorComment).author(this.author)
				.serialDay(this.serialDay).categoryId(this.categoryId).genreId(this.genreId)
				.bookCoverImage(this.bookCoverImage).introduction(this.introduction).age(this.age).views(views).build();
	}

	public Book updateBook(Integer bookId) {
		return Book.builder().bookId(bookId).title(this.title).authorComment(this.authorComment)
				.introduction(this.introduction).serialDay(this.serialDay).age(this.age).likes(likes).customtags(this.customTag)
				.bookCoverImage(this.bookCoverImage).views(views).likes(likes).build();
	}
}
