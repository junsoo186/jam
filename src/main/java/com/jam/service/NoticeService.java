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
    public int noticeInsert(Notice notice) {
        return noticeRepository.insert(notice);
    }

    // 게시글 삭제
    @Transactional
	public void delete(int noticeId) {
		int result =0;
		try {
			result = noticeRepository.delete(noticeId);
		}catch (Exception e) {
			// TODO: handle exception
		}
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
	
    
    // 게시글 수정
    @Transactional
    public int uploading(int noticeId, NoticeDTO dto) {
    	int resultRow = noticeRepository.update(noticeId, dto.getNoticeTitle(),dto.getStaffId(), dto.getNoticeContent());
    	return resultRow;

    }



    @Transactional
	public Notice findForUpdate(int noticeId) {
    	Notice NoticeListEntity = noticeRepository.findById(noticeId);
		return NoticeListEntity;
				
	}
	

	public int upload(Integer noticeId, NoticeDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Notice selectByNoticeId(int noticeId ,int userId) {
		Notice	notice=new Notice();
		 notice = noticeRepository.selectByNoticeId(noticeId,userId);
		return notice;
	}
}
