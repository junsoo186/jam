package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.vo.GraphVO;

@Mapper
public interface GraphRepository {
	
	public List<GraphVO> find(GraphVO vo);

}
