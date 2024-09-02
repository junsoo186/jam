package com.jam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public User login(UserDTO dto) {

		User user = null;
		System.out.println("signInDTO : " + dto);
		user = userRepository.findByEmailAndPassword(dto);
		return user;

	}

	/**
	 * 카카오 휴대폰 번호가 +82 10-1234-5678 인데 --> 010-1234-5678로 변경
	 */
	public String convertPhoneNumber(String internationalNumber) {

		// 국제 전화번호 형식에서 국가 코드(+82)와 공백을 제거
		if (internationalNumber.startsWith("+82")) {
			// 국가 코드를 제거하고 남은 숫자를 추출
			String localNumber = internationalNumber.substring(3).trim();
			// 남은 번호가 '10'으로 시작하면 앞에 '0'을 추가하여 국내 형식으로 변환
			if (localNumber.startsWith("10")) {
				return "0" + localNumber;
			}
		}
		// 다른 경우 기본적으로 입력을 그대로 반환 (기타 형식 처리 가능)
		return internationalNumber;
	}
	
	/**
	 * 네이버 (카카오?) 휴대폰 번호가 010-1234-5678 인데 --> 01012345678 로 변경
	 * @param internationalNumber 
	 */
	public String removeHyphens(String phoneNumber) {
		return phoneNumber.replace("-", "");
	}

	

	/**
	 * 회원가입 시 이메일 중복체크
	 * @param email
	 */
	
	public int checkEemail(String email) {
		// TODO Auto-generated method stub
		int result = 0;
		result = userRepository.findByUserEmail(email);
		if(result == 0) {
			System.out.println("생성가능");
		} else {
			System.out.println("생성 불가능");
		}
		return result;
	}
	

}
