package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.QnaDTO;
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
	public int updateQ(@Param("qnaId") int qnaId,@Param("title") String title,@Param("questionContent") String questionContent); // 질문 수정  (사용자)
	public int deleteByQnaId(int qnaID); // 질문 지우기
	public int updateA(QnaDTO qnaDto); // 답변 남기기 (관리자)
	public List<Qna> selectAllQnaPage(@Param("limit")int limit, 
									@Param("offset")int offset); // QnA 전체 화면에 출력 페이징 진행
	public Qna selectQnaByQnaId(int qnaId); // qna 아이디 값으로 불러오기
	public int countAll();
	public List<Qna> selectAllQnaByUserId(); // QnA 전체 화면에 출력(유저)
    public Qna findQnaByQnaId(Integer qnaId);

	public void updateQnaAnswer(@Param("answerContent") String answerContent, @Param("staffId") Integer staffId, @Param("qnaId") Integer qnaId);
	public void deleteQnaAnswer(int qnaId);
} 
	