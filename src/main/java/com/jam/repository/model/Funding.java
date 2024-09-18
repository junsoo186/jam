package com.jam.repository.model;

import java.sql.Date;
import java.sql.Timestamp;

import com.jam.dto.FundingDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Funding {
    private int fundingId; // 기본 키
    private int userId; // user_tb와의 외래 키
    private int rewardId; // reward_tb와의 외래 키
    private Timestamp createdAt; // 생성 시간에 대한 타임스탬프
    private Date canceledAt; // 취소된 날짜
    private String cancelConfirm; // 상태 ('N', 'Y')를 나타내는 열거형
    private int rewardQuantity; // 선택한 리워드의 수량
    private int rewardPoint;
    private String rewardContent;

    // Address fields
    private String zipcode; // 우편번호
    private String basicAddress; // 기본 주소 (시/구)
    private String detailedAddress; // 상세 주소 (번지, 건물 등)
    private String extraAddress; // 참고 항목 (동, 호수 등)
    private String shippingAddress; // 전체 주소
    private String confirmSuccess; // Enum ('N', 'Y')
    
    
    public FundingDTO tofundingDTO() {
    	return FundingDTO.builder()
    			.fundingId(fundingId)
    			.userId(userId)
    			.rewardId(rewardId)
    			.createdAt(createdAt)
    			.canceledAt(canceledAt)
    			.confirmSuccess(confirmSuccess)
    			.build();
	}
}
