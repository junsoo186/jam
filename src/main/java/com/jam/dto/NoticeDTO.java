package com.jam.dto;


import java.sql.Timestamp;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Builder;


@Data 
@NoArgsConstructor 
@AllArgsConstructor 
@ToString
@Builder
public class NoticeDTO {

    private int noticeId; // 공지사항 ID (테이블에 있는 경우)
    private int staffId;  // 직원 ID
    private String noticeTitle;  // 공지사항 제목
    private String noticeContent;  // 공지사항 내용
    private String comment;  // 댓글 (코멘트)
    private LocalDateTime createdAt;  // 생성 시간

    // 다른 메서드나 로직이 필요하다면 여기에 추가할 수 있습니다.
}
