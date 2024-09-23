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
@Builder
@ToString
public class Notice {
	private int noticeId;
	private int staffId;
	private String noticeTitle; // 공지 사항 제목
	private String noticeContent; // 공지 사항 내용
	private String comment; // 공지 사항 댓글
	private Timestamp createdAt; // 작성시간 
	private String nickName;
	
}
