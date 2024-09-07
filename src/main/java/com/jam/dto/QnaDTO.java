package com.jam.dto;

import java.sql.Timestamp;

import com.jam.repository.model.Qna;

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
	private String title; // 제목 질문
	private String questionContent; // 문의 내용
	private String answerContent; // 문의 내용
	
	public Qna toQna(int userId) {
		return Qna.builder()
				.userId(userId) //  <- principal.userId 넣어야 함
				.title(this.title)
				.questionContent(this.questionContent)
				.build();	
			
	}
}

