package com.jam.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class refundRequestTbDTO {
	// refund_request_tb
	private long refundId;
	private int userId;
	private int staffId;
	private int paymentKey;
	private long refundAmount;
	private String refundReason;
	private String status;

}
