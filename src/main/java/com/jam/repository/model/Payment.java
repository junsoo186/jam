package com.jam.repository.model;

import com.jam.dto.CardDTO;
import com.jam.dto.CheckoutDTO;
import com.jam.dto.ReceiptDTO;

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
public class Payment {
	private String userId; // 유저 아이디
	private String mId;                    // 가맹점 ID
    private String lastTransactionKey;     // 마지막 거래 키
    private String paymentKey;             // 결제 키
    private String orderId;                // 주문 ID
    private String orderName;              // 주문명
    private int taxExemptionAmount;        // 비과세 금액
    private String status;                 // 결제 상태
    private String requestedAt;            // 요청 시간
    private String approvedAt;             // 승인 시간
    private boolean useEscrow;             // 에스크로 사용 여부
    private boolean cultureExpense;        // 문화비 지출 여부
    private CardDTO card;                  // 카드 정보
    private String secret;                 // 비밀키
    private String type;                   // 결제 유형
    private boolean isPartialCancelable;   // 부분 취소 가능 여부
    private ReceiptDTO receipt;            // 영수증 정보
    private CheckoutDTO checkout;          // 체크아웃 URL
    private String currency;               // 통화 단위
    private int totalAmount;               // 총 금액
    private int balanceAmount;             // 잔액 금액
    private int suppliedAmount;            // 공급 금액
    private int vat;                       // 부가세
    private int taxFreeAmount;             // 면세 금액
    private String method;                 // 결제 방식
    private String version;                // API 버전
}
