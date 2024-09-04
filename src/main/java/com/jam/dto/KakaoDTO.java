package com.jam.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;
import lombok.ToString;

@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
@Data
@ToString
public class KakaoDTO {

	private String cid;
	private String partnerOrderId;
	private String partnerUserId;
	private String itemName;
	private String quantity;
	private String totalAmount;
	private String taxFreeAmount;
	private String approvalUrl;
	private String cancelUrl;
	private String failUrl;

}
