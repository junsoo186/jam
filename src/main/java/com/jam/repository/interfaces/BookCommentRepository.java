package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.BookCommentDto;
import com.jam.repository.model.BookComment;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface BookCommentRepository {
    
   
    


    /**
     * 댓글을 다양한 기준으로 조회
     *
     * @param bookId 책 ID
     * @param sortBy 정렬 기준 (newest, oldest, likes)
     * @return 댓글 리스트
     */
    List<BookComment> selectCommentsByCriteria(
            @Param("bookId") int bookId, 
            @Param("sortBy") String sortBy
    );


    /**
     * 새로운 댓글을 추가
     *
     * @param bookCommentDto 댓글 작성용 DTO
     * @return 삽입된 행 수
     */
    int insertComment(@Param("bookComment") BookCommentDto dto);


}
    

    
    

