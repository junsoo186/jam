package com.jam.dto;

import com.jam.repository.model.BookComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder 
public class BookCommentDto {
    private int userId;
    private int bookId;
    private String comment;

    public BookCommentDto toBookComment(int userId){

        return BookCommentDto.builder()
        		.userId(userId)
                .bookId(this.bookId)
                .comment(this.comment)
                .build();
        		

    }
}


