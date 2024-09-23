package com.jam.repository.interfaces;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Banner;



@Mapper
public interface BannerRepository {

    public List<Banner> selectAllBanner();



} 