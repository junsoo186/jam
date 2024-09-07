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
    private int rewardId;
    private int projectId; 
    private String rewardContent;
    private int rewardPoint;
}
