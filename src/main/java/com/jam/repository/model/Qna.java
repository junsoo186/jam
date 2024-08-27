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

public class Qna {

	private int staffId; //  관리자 아이디
	private int userId; //  사용자 아이디
	private String qnaContent; // 문의 내용
	private Timestamp createdAt; // 생성 시간
	
}
