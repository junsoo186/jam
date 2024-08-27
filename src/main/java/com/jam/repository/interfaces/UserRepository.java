package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(User user); // 회원가입
}
