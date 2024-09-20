package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jam.dto.BookCommentDto;
import com.jam.repository.interfaces.BookCommentRepository;
import com.jam.repository.model.BookComment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class BookCommentsService {
     
    @Autowired
    private BookCommentRepository bookCommentRepository;
    private static final Logger logger = LoggerFactory.getLogger(BookCommentsService.class);
    
    /**
     * 책에 대한 댓글을 다양한 기준으로 조회
     *
     * @param bookId 책 ID
     * @param sortBy 정렬 기준 (newest, oldest, likes)
     * @return 댓글 리스트
     */
    public List<BookComment> getCommentsByCriteria(int bookId, String sortBy) {
        return bookCommentRepository.selectCommentsByCriteria(bookId, sortBy);
    }

   

    /**
     * 새로운 댓글을 작성
     *
     * @param bookCommentDto 댓글 작성용 DTO
     * @return 성공적으로 삽입된 행 수
     */
    public int writeComment(BookCommentDto dto, int userId) {
        return bookCommentRepository.insertComment(dto.toBookComment(userId));
    }

}
