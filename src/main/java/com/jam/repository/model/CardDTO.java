package com.jam.repository.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class CardDTO {
    private String issuerCode;             // 발행자 코드
    private String acquirerCode;           // 매입자 코드
    private String number;                 // 카드 번호
    private int installmentPlanMonths;     // 할부 개월 수
    private boolean isInterestFree;        // 무이자 여부
    private String interestPayer;          // 이자 부담자
    private String approveNo;              // 승인 번호
    private boolean useCardPoint;          // 카드 포인트 사용 여부
    private String cardType;               // 카드 유형
    private String ownerType;              // 소유자 유형
    private String acquireStatus;          // 매입 상태
    private int amount;                    // 결제 금액
}
