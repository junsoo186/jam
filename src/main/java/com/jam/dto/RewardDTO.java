package com.jam.dto;

import com.jam.repository.model.Reward;

public class RewardDTO {
    private int rewardId;
    private int projectId; 
    private String rewardContent;
    private int rewardPoint;
    
    public Reward toReward(int id,int projectId) {
    	return Reward.builder()
    			.rewardId(id)
    			.projectId(projectId)
    			.rewardContent(rewardContent)
    			.rewardPoint(rewardPoint)
    			.build();
    			
    }
}
