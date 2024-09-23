package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.MainBanner;


@Mapper
public interface MainBannerRepository {

	
	public  MainBanner selectByEventId(int Eventid);
	public MainBanner selectById(int id);
	public List<MainBanner> selectAllMainBanner(@Param("limit") int limit,@Param("offset") int offset);
	public int countAllMainBanner();
}
