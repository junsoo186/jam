package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Funding;

import org.apache.ibatis.annotations.Param;

@Mapper
public interface FundingRepository {

	public int insertFunding(Funding funding);

	public List<Funding> selectAllByUserId();

	public void deleteByRewardId(Integer rewardId);

	public List<Funding> findFundingByUserId(int userId);

	public void updatePoint(@Param("userId") Integer userId, @Param("totalAmount") int totalAmount);

	public void updateCanceled(@Param("fundingId") Integer fundingId);

	public void updatePointByRefund(@Param("userId") Integer userId, @Param("totalAmount") int totalAmount);
}
