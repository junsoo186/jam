package com.jam.dto;

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
public class QnaDTO {
	private int qnaId;
	private int userId; //  사용자 아이디
	private int staffId; //  관리자인 경우 staff id 저장
	private String adminCheck; // 관리자 확인
	private String title; // 제목 질문
	private String nickname; // 사용자 닉네임
	private String questionContent; // 문의 내용
	private String answerContent; // 문의 내용
	private Timestamp createdAt; // 생성 시간
}
