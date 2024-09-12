package com.jam.repository.model;

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
public class Reward {
    private Integer rewardId;
    private Integer projectId; 
    private String rewardContent;
    private long rewardPoint;
    private int rewardQuantity;
    private int userCount;
    private String shippingAddress;
}
