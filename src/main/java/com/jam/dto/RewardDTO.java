package com.jam.dto;


import java.util.List;

import com.jam.repository.model.Project;
import com.jam.repository.model.Reward;

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
public class RewardDTO {
    
    private Integer userId;
    private Integer rewardId;
    private Integer projectId; 
    private String content;
    private long point;
    private int userCount;
    
    public Reward toReward() {
    	return Reward.builder()
    			.rewardContent(this.content)
    			.rewardPoint(this.point)
    			.build();
    }

}
