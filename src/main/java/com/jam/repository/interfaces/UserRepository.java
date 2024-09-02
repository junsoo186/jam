package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.UserDTO;
import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(User user); // 회원가입

	public UserDTO findByEmailAndPassword(UserDTO dto); // 로그인
	
	public int findByUserEmail(String email);
	
}
