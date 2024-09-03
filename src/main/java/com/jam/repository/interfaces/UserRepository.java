package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.UserDTO;
import com.jam.dto.signInDTO;
import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(User user); // 회원가입

	public User findByEmailAndPassword(User dto); // 로그인
}
