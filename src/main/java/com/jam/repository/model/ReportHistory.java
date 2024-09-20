package com.jam.repository.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReportHistory {

    private int reportHistoryId; // 신고 이력 고유 ID
    private int reportId;        // 신고 ID (report_tb 참조)
    private int userId;          // 처리 담당자 ID (user_tb 참조)
    private int alertId;         // 경고 ID (user_alert_list_tb 참조)
    private Integer periodDays; // 처리 기간
    private Timestamp createdAt; // 처리 일시
}
