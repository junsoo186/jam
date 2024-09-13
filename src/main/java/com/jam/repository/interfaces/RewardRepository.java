package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.RewardDTO;
import com.jam.repository.model.Reward;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface RewardRepository {

    public void insertRewardByProjectId(@Param("reward") RewardDTO reward);

    public List<Reward> findRewardByProjectId(Integer projectId);

    public List<RewardDTO> findRewardDTOByProjectId(Integer projectId);

    public void updateRewardByProjectId(@Param("reward") RewardDTO rewardDTO);

    public void deleteReward(Integer rewardId);

    public Reward findRewardByRewardId(Integer rewardId);
}
