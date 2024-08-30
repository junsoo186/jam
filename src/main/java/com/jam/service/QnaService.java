package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jam.dto.QnaDTO;
import com.jam.repository.interfaces.QnaRepository;
import com.jam.repository.model.Notice;

@Service
public class QnaService {
	
	private final QnaRepository qnaRepository;
	
	@Autowired
	public QnaService(QnaRepository qnaRepository) {
		this.qnaRepository = qnaRepository;
	}
	
	public List<QnaDTO> selectAllQna(int page, int size) {
		List<QnaDTO> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = qnaRepository.selectAllQnaPage(limit,offset);
		return list;
	}

	
	public int allList(){
		return qnaRepository.countAll();
	}
	
}
