package com.jam.repository.model;


import java.time.LocalDateTime;

import com.google.auto.value.AutoValue.Builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class FundingResult {

    private int fundingResultId;         // auto increment ID
    private int projectId;               // 펀딩된 프로젝트 ID
    private long totalFundingAmount;     // 총 펀딩된 금액
    private int totalBackers;            // 펀딩에 참여한 총 인원 수
    private long fundingGoal;            // 펀딩 목표 금액
    private String fundingStatus;        // 펀딩 상태 (성공, 실패, 취소)
    private boolean isRefunded;          // 환불 여부
    private LocalDateTime finalFundingDate;  // 펀딩 종료 날짜
    private boolean rewardDistributed;   // 보상 지급 여부
    private LocalDateTime refundDate;    // 환불 날짜 (있을 경우)

}
