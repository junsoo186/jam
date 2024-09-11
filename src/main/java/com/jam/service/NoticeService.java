package com.jam.service;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.NoticeDTO;
import com.jam.repository.interfaces.NoticeRepository;
import com.jam.repository.model.Notice;
import com.jam.repository.model.Qna;

@Service
public class NoticeService {

    private final NoticeRepository noticeRepository;

    @Autowired
    public NoticeService(NoticeRepository noticeRepository) {
        this.noticeRepository = noticeRepository;
    }

    // 게시글 등록
    public NoticeDTO Insertnotice(NoticeDTO notice) {
        noticeRepository.insert(notice);
        return notice;
    }

    // 게시글 삭제
    @Transactional
	public int deleteNotice(int noticeId) {
		int result =0;
		try {
			result = noticeRepository.delete(noticeId);
		}catch (Exception e) {
			System.out.println("딜리트 실패");
		}
		return result;
    }

    // 게시글 전체 조회
    public List<Notice> findAll(int page, int size) {
		List<Notice> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = noticeRepository.findAll(limit,offset);
        return list;
    }
    
	/**
	 * 페이징 처리 전체 숫자 확인
	 * 
	 */
	public int allList(){
		return noticeRepository.countAll();
	}
	
    
    // 게시글 
    @Transactional
    public Notice updateNotice(int noticeId, NoticeDTO dto) {
    	int resultRow = noticeRepository.update(noticeId, dto.getNoticeTitle(), dto.getNoticeContent());
    	Notice notice = noticeRepository.selectByNoticeId(noticeId);
    	System.out.println("수정결과 : " + resultRow);
    	return notice;

    }



    @Transactional
	public Notice findForUpdate(int noticeId) {
    	Notice NoticeListEntity = noticeRepository.findById(noticeId);
		return NoticeListEntity;
				
	}
	


	public Notice selectByNoticeId(int noticeId ) {
		Notice	notice=new Notice();
		 notice = noticeRepository.selectByNoticeId(noticeId);
		return notice;
	}
	
	// 스태프 게시글 조회
	public List<Notice> staffFindAll(int page, int size){
		List<Notice> list = new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		list = noticeRepository.staffFindAll(limit,offset);
		return list;
	}
	
	
}
