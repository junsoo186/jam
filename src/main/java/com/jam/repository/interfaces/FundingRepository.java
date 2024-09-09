package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.repository.model.Funding;
import com.jam.repository.model.User;

@Mapper
public interface FundingRepository {

	public void insertFunding(Funding funding);
	public void updateFundingByUserId(@Param("funding") Funding funding, @Param("userId") int userId);
	public void deleteFundingByUserId(@Param("userId") int userId);
	
	public List<Funding> selectAll();
	public Funding selectById(int fundId);
	public List<Funding> selectByUserId(int UserId);
	public int countFundingById(int fundId);
	public int countFundingId();
}
