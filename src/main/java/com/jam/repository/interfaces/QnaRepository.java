package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.QnaDTO;

// Q&A 인터페이스 
@Mapper //qna.xml 매칭
public interface QnaRepository {
	/**
	 * Model 클래스 만들기 
	 * 1. Q&A 전제 선택
	 * 2. 사용자가 ->  관리자에게 Q 남기기
	 * 3. 관리자가 ->  사용자에게 A 남기기
	 */

	public int insertQ(QnaDTO qnaDto); // 질문 남기기 (사용자)
	public int updateQ(QnaDTO qnaDto); // 질문 수정  (사용자)
	public int deletByUserId(int userId); // 질문 지우기(사용자)
	public int updateA(QnaDTO qnaDto); // 답변 남기기 (관리자)
	public List<QnaDTO> selectAllQna(); // QnA 전체 화면에 출력
	public List<QnaDTO> selectAllQnaByUserId(); // QnA 전체 화면에 출력(유저)
} 
	