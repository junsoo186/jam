package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.FundingResult;

@Mapper
public interface FundingResultRepository {

    FundingResult findByProjectId(@Param("projectId") int projectId);

    void updateFundingResult(FundingResult fundingResult);

}
