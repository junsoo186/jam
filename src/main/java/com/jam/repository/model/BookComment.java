package com.jam.repository.model;

import java.sql.Timestamp;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class BookComment { 
    private Integer commentId;  // 댓글 아이디
    private Integer bookId;     // 책 ID
    private Integer userId;     // 작성자 ID
    private String comment;     // 댓글 내용
    private String nickName;    // 작성자의 닉네임 (추가 필드)
    private String profileImg;
    private Timestamp createdAt;
    private int likeCount;      // 좋아요 개수

    public String setUpUserImage() {
		if (profileImg == null) {
			return "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbCXLP7%2FbtrQuNirLbt%2FN30EKpk07InXpbReKWzde1%2Fimg.png";
		} else {
			return "/images/" + profileImg;
		}
	}
}
