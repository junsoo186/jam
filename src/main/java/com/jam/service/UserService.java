package com.jam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void createUser(User dto) {
		int result = 0;
		System.out.println("dtp : " +dto);
		result = userRepository.insert(dto);
		
		if(result == 1) {
			System.out.println("회원가입 성공");
		} else {
			System.out.println("회원가입 실패");
		}
		
	}

}
