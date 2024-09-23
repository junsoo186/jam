package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.QnaDTO;
import com.jam.repository.interfaces.QnaRepository;
import com.jam.repository.model.Notice;
import com.jam.repository.model.Qna;

@Service
public class QnaService {
	
	private final QnaRepository qnaRepository;
	
	@Autowired
	public QnaService(QnaRepository qnaRepository) {
		this.qnaRepository = qnaRepository;
	}
	
	@Transactional
	public void qnaWrite(QnaDTO dto, int userId) {
		int result = 0;
		result = qnaRepository.insertQ(dto.toQna(userId));
	}
	
	
	public List<Qna> selectAllQna(int page, int size) {
		List<Qna> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = qnaRepository.selectAllQnaPage(limit,offset);
		return list;
	}

	/**
	 * 페이징 처리 전체 숫자 확인
	 * 
	 */
	public int allList(){
		return qnaRepository.countAll();
	}
	
	/**
	 * qnaId 확인후 select
	 * @param qnaId
	 */
	public Qna selectByQnaId(int qnaId) {
		Qna qna = qnaRepository.selectQnaByQnaId(qnaId);
		return qna ;	
	}
	
	/**
	 * Delete
	 * @param qnaId
	 */
	@Transactional
	public void delete(int qnaId) {
		int result =0;
		result = qnaRepository.deleteByQnaId(qnaId);
	}
	
	
	
	/**
	 * 
	 * @param dto
	 * @param qnaId
	 * @return
	 */
	@Transactional
	public int updateMyqna(QnaDTO dto, int qnaId) {
		int result = qnaRepository.updateQ(qnaId,dto.getTitle(),dto.getQuestionContent());
		return result;
	}

	public Qna findQnaByQnaId(Integer qnaId) {
		return qnaRepository.findQnaByQnaId(qnaId);
	}
	
	public void updateQnaAnswer(String answerContent, Integer staffId, Integer qnaId) {
		qnaRepository.updateQnaAnswer(answerContent, staffId, qnaId);
	}

	public void deleteQnaAnswer(int qnaId) {
		qnaRepository.deleteQnaAnswer(qnaId);
	}
	
}
