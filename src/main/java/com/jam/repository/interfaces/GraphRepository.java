package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.jam.vo.GraphVO;

@Mapper
@Repository
public interface GraphRepository {
	
	public List<GraphVO> find();


}
