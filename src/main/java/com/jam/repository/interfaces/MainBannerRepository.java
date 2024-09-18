package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.MainBanner;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface MainBannerRepository {

	
	public  MainBanner selectByEventId(int Eventid);
	public MainBanner selectById(int id);
	public List<MainBanner> selectAllMainBanner(@Param("limit") int limit,@Param("offset") int offset);
}
