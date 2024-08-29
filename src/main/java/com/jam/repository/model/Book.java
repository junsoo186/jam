package com.jam.repository.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

	private Integer bookId;
	private Integer userId;
	private String title;
	private String authorComment;
	private String author;
	private String bookCoverImage;
    private Integer categoryId;  
    private Integer genreId;     
    private List<String> tagNames;  
	private String introduction;
	private Timestamp createdAt;
	private String age;
	private Integer likes;
	private String serialDay;

}
