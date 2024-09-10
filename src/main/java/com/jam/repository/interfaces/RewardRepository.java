package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Reward;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface RewardRepository {

    public void insertRewardByProjectId(@Param("projectId")Integer projectId,@Param("reward") Reward reward);

    public List<Reward> finRewardByProjectId(Integer projectId);

    public void updateRewardByProjectId(@Param("reward") Reward reward, @Param("projectId") Integer projectId);
}
