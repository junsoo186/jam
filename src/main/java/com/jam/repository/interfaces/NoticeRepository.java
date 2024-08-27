package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Notice;

/**
 *  공지사항 인터페이스
 *  1.모델 (notice) 만들기
 *  기본기능 : 리스트 출력 , 상세보기  
 *  관리자 : 기본기능 + 공지 추가 , 수정 , 삭제  
 */
@Mapper // << notice.xml 
public interface NoticeRepository {

	public int insert(); // 게시글 작성
	public int delete(); // 게시글 삭제 
	public int update(); // 게시글 수정
	
	public List<Notice> findAll(); // 게시글 조회
	
	
}
