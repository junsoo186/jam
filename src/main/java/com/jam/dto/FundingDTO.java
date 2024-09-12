package com.jam.dto;

import lombok.*;

import java.sql.Timestamp;
import java.sql.Date;

import com.jam.repository.model.Funding;

@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class FundingDTO {

    private int fundingId; // Primary Key
    private int userId; // Foreign key to user_tb
    private int rewardId; // Foreign key to reward_tb
    private Timestamp createdAt; // Timestamp for creation time
    private Date canceledAt; // Date for cancellation
    private String confirmSuccess; // Enum ('N', 'Y')
    private int rewardQuantity; // Number of rewards selected

    // Address fields
    private String zipcode; // 우편번호
    private String basicAddress; // 기본 주소 (시/구)
    private String detailedAddress; // 상세 주소 (번지, 건물 등)
    private String extraAddress; // 참고 항목 (동, 호수 등)

    public Funding toFunding(Integer userId) {
        return Funding.builder()
                .userId(userId)
                .rewardId(this.rewardId)
                .createdAt(new Timestamp(System.currentTimeMillis())) // 생성 시간
                .canceledAt(this.canceledAt) // 취소된 날짜
                .confirmSuccess(this.confirmSuccess)
                .rewardQuantity(this.rewardQuantity)
                .zipcode(this.zipcode) // 우편번호
                .basicAddress(this.basicAddress) // 기본 주소
                .detailedAddress(this.detailedAddress) // 상세 주소
                .extraAddress(this.extraAddress) // 참고 항목
                .build();
    }
}
