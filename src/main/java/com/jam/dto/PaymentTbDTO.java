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
public class PaymentTbDTO {
	// PAYMENT_TB 
	
	private int paymentId; // payment ID
	private int userId; // 유저 아이디 
	private long price; // 결제 가격
	private long point; // 포인트 (구매)
	private char evnet; // 이벤트 여부 'Y', 'N' 
	private String paymentKey; // 결제 고유 키 (이거 없으면 안됨)
	
	
}
