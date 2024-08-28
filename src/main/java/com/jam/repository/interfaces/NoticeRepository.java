package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param; // MyBatis에서 파라미터 어노테이션을 사용하여 정확히 매핑

import com.jam.repository.model.Notice;

/**
 * 공지사항 인터페이스
 * 1. 모델 (notice) 만들기
 * 기본기능 : 리스트 출력, 상세보기  
 * 관리자 : 기본기능 + 공지 추가, 수정, 삭제  
 */
@Mapper // MyBatis 매퍼 인터페이스 어노테이션
public interface NoticeRepository {

    int insert(Notice notice); // 게시글 작성
    
    int delete(@Param("staffId") int staffId); // 게시글 삭제

    int update(Notice notice); // 게시글 수정 (매개변수 추가)
    
    List<Notice> findAll(); // 게시글 조회

    Notice findById(@Param("noticeId") int noticeId); // 게시글 상세 조회 메서드 추가

}
