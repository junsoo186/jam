package com.jam.repository.model;

import java.sql.Date;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

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

@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class AccountHistoryDTO {

	  	private int accountHistoryId; // 히스토리 id
	  	private int userId; // 유저 아이디
	  	private long deposit; // 현금
	  	private long point; // 포인트
	  	private long afterBalance; // 결제후 포인트 합계
	  	private Date createdAt; // 결제 날짜
	  	
	  	 // 필요한 필드 추가
	    private String orderId;      // 주문 번호
	    private long amount;         // 결제 금액
	    private Date paymentDate;    // 결제 날짜
	    private String paymentKey;
		

}
