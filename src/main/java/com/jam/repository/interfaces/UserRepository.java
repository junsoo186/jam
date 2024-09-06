package com.jam.repository.interfaces;

import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(signUpDTO user); // 회원가입 (닉네임, 이메일, 비밀번호, 사진)

	public void insertbyUserTb(@Param("userId") Integer userId); // 회원가입 (포인트, 이름, 생일, 주소) 등록

	public User emailsearch(signUpDTO user); // 회원 가입 후 유저 디테일에 연결하기 위해서 작성

	public User findEmail(@Param("email") String email); // 로그인

	public int findByUserEmail(String email); // 이메일 찾기

	Optional<User> findByEmail(String email); // 이메일 중복 확인

	public int fineByUserNickName(String nickName); // 닉네임 찾기

	Optional<User> findByNickName(String nickName); // 닉네임으로 사용자 찾기

	int updatePasswordByEmail(@Param("password") String password, @Param("email") String email);

	int updateProfileByUserTb(User user); // 유저 프로필 업데이트 UserTb

	int updateProfileByUserDeTb(User user); // 유저 프로필 업데이트 UserDeTb

	public User InformationUpdate(@Param("email") String email); // 유저 프로필 업데이트 후 갱신

}