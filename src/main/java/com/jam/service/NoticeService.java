package com.jam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.NoticeRepository;
import com.jam.repository.model.Notice;
@Service
public class NoticeService {
	
	private final NoticeRepository noticeRepository;

	@Autowired
	public NoticeService(NoticeRepository noticeRepository) {
		this.noticeRepository = noticeRepository;
	}

/**
 * 게시글 등록 , 저장
 * @return
 */
	public int noticeInsert(Notice notice) {
		return noticeRepository.insert(notice);
	}
	
	
	
	public List<Notice> findAll() {
		return noticeRepository.findAll();
	}

	public void update(PathRequest params) {
		// TODO Auto-generated method stub
		
	}

}
