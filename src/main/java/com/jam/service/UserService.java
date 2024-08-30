package com.jam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.interfaces.UserRepository;
import com.jam.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	/**
	 * 
	 * @param user
	 */
	@Transactional // 트랜잭션 처리
	public void createUser(signUpDTO dto) {
		int result = 0;
		System.out.println("dto : " + dto);
		result = userRepository.insert(dto.toUser());

		if (result == 1) {
			System.out.println("회원가입 성공");
		} else {
			System.out.println("회원가입 실패");
		}

	}

	/**  
	 * 로그인 기능
	 * 
	 * @param dto
	 * @return
	 */
	public signInDTO login(signInDTO dto) {

		signInDTO user = null;
		System.out.println("signInDTO : " + dto);
		user = userRepository.findByEmailAndPassword(dto);
		return user;

	}

}
