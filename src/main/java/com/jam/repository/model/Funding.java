package com.jam.repository.model;

import java.sql.Date;
import java.sql.Timestamp;

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

}
