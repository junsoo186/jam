package com.jam.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.jam.repository.model.Book;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.String;

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
	private String originalBookCoverImage;
	private Integer categoryId;
	private Integer genreId;
	private String serialDay;
	private List<String> customTag;
	private String age;
	private MultipartFile bookCover;
	private String uploadPath;

	public Book toBook(Integer userId) {
		return Book.builder().userId(userId).title(this.title).authorComment(this.authorComment).author(this.author)
				.serialDay(this.serialDay).categoryId(this.categoryId).genreId(this.genreId)
				.bookCoverImage(this.bookCoverImage).introduction(this.introduction).age(this.age).build();
	}

	public Book updateBook(Integer bookId) {
		return Book.builder().bookId(bookId).title(this.title).authorComment(this.authorComment)
				.introduction(this.introduction).serialDay(this.serialDay).age(this.age).customtags(this.customTag)
				.bookCoverImage(this.bookCoverImage).build();
	}
}
