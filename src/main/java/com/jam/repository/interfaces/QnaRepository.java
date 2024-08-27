package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Qna;

// Q&A 인터페이스 
@Mapper //qna.xml 매칭
public interface QnaRepository {
	/**
	 * Model 클래스 만들기 
	 * 1. Q&A 전제 선택
	 * 2. 사용자가 ->  관리자에게 Q 남기기
	 * 3. 관리자가 ->  사용자에게 A 남기기
	 */

	public int insertQ(Qna qna); // 질문 남기기 (사용자)
	public int insertA(Qna qna); // 답변 남기기 (관리자)
	public int deletByUserId(int userId, String name); // 질문 지우기(사용자)
	public List<Qna> selectAllQnaStaff(@Param("staffId") int principalId); // QnA 전체 화면에 출력(스태프)
	public List<Qna> selectAllQnaUser(@Param("userId") int principalId); // QnA 전체 화면에 출력(유저)
} 
	