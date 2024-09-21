package com.jam.repository.model;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.BookDTO;

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
    private String bookCoverImage;
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
	private MultipartFile bookCover;
	private String originalBookCoverImage;
    private List<String> customtags;
    private String introduction;
    private Timestamp createdAt;
    private String age;
    private Integer likes;
    private Integer	bookTotalScore;
    private Integer views;
    private String serialDay;

    
    private int totalViews;  // 책의 총 조회수를 저장하는 필드
    private int totalLikes;  // 책의 총 좋아요 수를 저장하는 필드
    
    
    // tagNames를 List<String>으로 변환하는 메서드
    public List<String> getTagNamesList() {
        if (tagNames != null && !tagNames.isEmpty()) {
            return Arrays.asList(tagNames.split(","));
        }
        return Collections.emptyList();
    }
    
    public String setUpUserImage() {
		if (bookCoverImage == null) {
			return "/images/cover/winterCover.jpg";
		} else {
			return "/images/" + bookCoverImage;
		}
	}
    
    public BookDTO toBookDTO() {
    	 return BookDTO.builder()
    			 .bookId(bookId).userId(userId) //아이디
    			 .title(title).authorComment(authorComment).author(author) //제목 코멘트 작가
    			 .categoryId(categoryId).genreId(genreId).tagNames(tagNames) //카테고리 장르 태그
    			 .bookCover(bookCover).originalBookCoverImage(originalBookCoverImage) //북커버
    			 .customTag(customtags).introduction(introduction) // 커스텀태그 소개글
    			 .createdAt(createdAt).age(age).likes(likes).serialDay(serialDay).views(views) // 생성일자, 나이제한, 좋아요 ,연재일
    			 .build();
    			 
    	
    }
}
