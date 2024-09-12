package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Benner;

@Mapper
public interface BennerRepository {

   public List<Benner> selectAll();
    
}
