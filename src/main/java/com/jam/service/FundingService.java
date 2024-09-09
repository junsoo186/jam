package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.FundingRepository;
import com.jam.repository.model.Funding;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FundingService {

	private final FundingRepository fundingRepository;
	
	
	
	 public List<Funding> selectAllFund() {
		 List<Funding> list= new ArrayList<>();
		 list=fundingRepository.selectAll();
		 
		 return list;
	 }
	 
	 public int countFundingById(int fundingId) {
		 int countNum=fundingRepository.countFundingById(fundingId);
		 
		 return countNum;
	 }
	 
	 public int countFundingAll() {
		 int countNum=fundingRepository.countFundingId();
		 
		 return countNum;
	 }
	
}
