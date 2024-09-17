package com.jam.dto;

import java.sql.Date;

import com.jam.repository.model.AccountHistoryDTO;

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
	// REFUND_REQUEST_TB 
	private long refundId; // 번호
    private int userId; // 유저 번호
    private int staffId; // 관리자 번호
    private String paymentKey; // 결제 고유번호
    private long refundAmount; // 결제 가격
    private String refundReason; // 환불 이유
    private String status;  // "PENDING", "APPROVED", "REJECTED"
    private Date createdAt; // 날짜
    private Date approvedAt; // 승인날짜
    private Date rejectedAt; // 거절날짜
    
    private long point; // 포인트
    private String method; // 결제 방법

    public AccountHistoryDTO toAccountHistoryDTO() {
    	return AccountHistoryDTO.builder()
    				.status(this.status)
    				.build();
    }
    
}
