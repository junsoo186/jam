package com.jam.repository.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Report {

    private int reportId; // 신고 ID
    private int alertId; // 경고 ID
    private int userId; // 신고한 유저 ID
    private Integer reportUserId; // 신고된 유저 ID (NULL 가능)
    private Integer projectId; // 신고된 프로젝트 ID (NULL 가능)
    private Integer bookId; // 신고된 책 ID (NULL 가능)
    private String periodContent; // 신고 내용
    private Timestamp createdAt; // 신고 생성 시간
    private String processing; // 신고 처리 상태 ('N', 'Y')

    // 추가 필드
    private String userName; // 신고한 유저 닉네임
    private String alertContent; // 경고 내용
    private String bookTitle; // 책 제목
    private String bookAuthor; // 책 저자
    private String adminName; // 처리한 관리자 닉네임
    private String reportedUserName; // 신고 대상자 닉네임
    private String projectTitle; // 프로젝트 제목
    private LocalDateTime processedAt; // 처리 날짜
    private LocalDateTime releaseDate; // 처리 날짜
    private Integer periodDate; // 처리 기간

    private Date processedAtDate;
    private Date releasedDate;



    // 누적 신고 횟수
    private int userReportCount; // 유저의 누적 신고 횟수
    private int projectReportCount; // 프로젝트의 누적 신고 횟수
    private int bookReportCount; // 책의 누적 신고 횟수
}
