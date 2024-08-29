package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;

@Mapper
public interface UserRepository {
	public int insert(signUpDTO dto); // 회원가입
	
	public signInDTO findByEmailAndPassword(signInDTO dto); // 로그인
}
