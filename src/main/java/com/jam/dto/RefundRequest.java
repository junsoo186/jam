package com.jam.dto;

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
public class RefundRequest {
	// 사용자가 환불을 할 때 관리자가 확인할 수 있는 dto
	private long refundId;
    private int userId;
    private String paymentKey;
    private long refundAmount;
    private String refundReason;
    private String status;  // "PENDING", "APPROVED", "REJECTED"

    
}
