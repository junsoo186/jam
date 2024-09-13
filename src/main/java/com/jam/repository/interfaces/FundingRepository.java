package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Funding;

@Mapper
public interface FundingRepository {

	public int insertFunding(Funding funding);
	
	public List<Funding> selectAllByUserId();

    public void deleteByRewardId(Integer rewardId);

    public List<Funding> findFundingByUserId(int userId);
}
