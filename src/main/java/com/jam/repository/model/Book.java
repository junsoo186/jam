package com.jam.repository.model;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Collections;
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
    private Integer categoryId;
    private Integer genreId;
    private String categoryName;
    private String genreName;
    private String tagNames;  // String으로 받아오기
	private String bookCoverImage;
	private String originalBookCoverImage;
    private List<String> customtags;
    private String introduction;
    private Timestamp createdAt;
    private String age;
    private Integer likes;	
    private String serialDay;

    // tagNames를 List<String>으로 변환하는 메서드
    public List<String> getTagNamesList() {
        if (tagNames != null && !tagNames.isEmpty()) {
            return Arrays.asList(tagNames.split(","));
        }
        return Collections.emptyList();
    }
    
    public String setUpUserImage() {
		if (bookCoverImage == null) {
			return "https://picsum.photos/id/40/400/400";
		} else {
			return "/images/uploads/" + bookCoverImage;
		}
	}
}
