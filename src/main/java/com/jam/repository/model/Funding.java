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
    private int fundingId;
    private int userId; // Foreign key to user_tb
    private int rewardId; // Foreign key to reward_tb
    private Timestamp createdAt;
    private Date canceledAt;
    private String confirmSuccess; // Enum ('N', 'Y')
}
