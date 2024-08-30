package com.jam.repository.interfaces;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Notice;

@Mapper
public interface NoticeRepository  {

    int insert(Notice notice); // 게시글 작성
    

    public int delete(int noticeId); // 게시글 삭제
    
    int update(int noticeId); // 게시글 수정
    
    List<Notice> findAll(); // 게시글 조회

    Notice findById(@Param("noticeId") int noticeId); // 게시글 상세 조회 메서드 추가
}
