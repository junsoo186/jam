package com.jam.dto;

import com.jam.repository.model.Reward;

public class RewardDTO {
    private Integer rewardId;
    private Integer projectId; 
    private String rewardContent;
    private long rewardPoint;
    
    public Reward toReward(Integer projectId) {
    	return Reward.builder()
    			.projectId(projectId)
    			.rewardContent(this.rewardContent)
    			.rewardPoint(this.rewardPoint)
    			.build();
    }
}
