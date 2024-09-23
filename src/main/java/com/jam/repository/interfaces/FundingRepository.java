package com.jam.repository.interfaces;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.repository.model.Funding;
import com.jam.repository.model.User;

import org.apache.ibatis.annotations.Param;

@Mapper
public interface FundingRepository {

	public int insertFunding(Funding funding);

	public List<Funding> selectAllByUserId();

	public void deleteByRewardId(Integer rewardId);

<<<<<<< HEAD
    public List<Funding> findFundingByUserId(int userId);
	public void updateFundingByUserId(@Param("funding") Funding funding, @Param("userId") int userId);
	public void deleteFundingByUserId(@Param("userId") int userId);
	
	public List<Funding> selectAll();
	public Funding selectById(int fundId);
	public List<Funding> selectByUserId(int UserId);
	public int countFundingById(int fundId);
	public int countFundingId();
=======
	public List<Funding> findFundingByUserId(int userId);

	public void updatePoint(@Param("userId") Integer userId, @Param("totalAmount") int totalAmount);

	public void updateCanceled(@Param("fundingId") Integer fundingId);

	public void updatePointByRefund(@Param("userId") Integer userId, @Param("totalAmount") int totalAmount);

    public List<Funding> findByProjectId(@Param("projectId") int projectId);

	public void updateFundingStatus(Funding funding);
>>>>>>> sub-dev
}
