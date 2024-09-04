package com.jam.repository.interfaces;

import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(signUpDTO user); // 회원가입

	public User findByEmailAndPassword(signInDTO dto); // 로그인
	
	public int findByUserEmail(String email); // 이메일 찾기
	
	Optional<User> findByEmail(String email); // 이메일 중복 확인
	
	public int fineByUserNickName(String nickName); // 닉네임 찾기
}
