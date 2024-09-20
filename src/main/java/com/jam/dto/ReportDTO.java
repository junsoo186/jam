package com.jam.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.AllArgsConstructor;

import java.sql.Timestamp;

import com.google.auto.value.AutoValue.Builder;
import com.jam.repository.model.Report;

@Data // Lombok이 getter, setter, toString, equals, hashCode 등을 자동으로 생성
@NoArgsConstructor // 기본 생성자 생성
@AllArgsConstructor // 모든 필드를 인자로 받는 생성자 생성
@ToString
@Builder
public class ReportDTO {

    private int reportId;
    private int alertId;
    private int userId;
    private Integer reportUserId;
    private Integer projectId;
    private Integer bookId;
    private String periodContent;
    private Timestamp createdAt;
    private String processing;

    // Lombok annotations (getter, setter, etc.)

    public Report toReport(Integer userId) {
        return Report.builder()
                .reportId(this.reportId)
                .alertId(this.alertId)
                .userId(userId != null ? userId : this.userId) // 받아온 userId가 있으면 사용
                .reportUserId(this.reportUserId)
                .projectId(this.projectId)
                .bookId(this.bookId)
                .periodContent(this.periodContent)
                .createdAt(this.createdAt != null ? this.createdAt : new Timestamp(System.currentTimeMillis())) // 현재 시간
                .processing(this.processing != null ? this.processing : "N") // 기본값 N
                .build();
    }
}
