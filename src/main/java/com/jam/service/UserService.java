package com.jam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jam.dto.UserDTO;
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
	public void createUser(signUpDTO dto) {
		int result = 0;
		System.out.println("dto : " + dto);
		result = userRepository.insert(dto);

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
	public UserDTO login(UserDTO dto) {

		UserDTO user = null;
		System.out.println("userDTO : " + dto);
		user = userRepository.findByEmailAndPassword(dto);

		return user;

	}

}
