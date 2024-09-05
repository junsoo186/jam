package com.jam.service;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.EmailVerificationResult;
import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.interfaces.UserRepository;
import com.jam.repository.model.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

	private final UserRepository userRepository;

	private static final String AUTH_CODE_PREFIX = "AuthCode ";

	private final MailService mailService;

	// 메모리 기반으로 인증 코드를 저장하는 맵
	private final Map<String, String> authCodeStore = new ConcurrentHashMap<>();

	@Value("${spring.mail.auth-code-expiration-millis}")
	private long authCodeExpirationMillis;

	/**
	 * 
	 * @param user
	 */
	@Transactional // 트랜잭션 처리
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
	public User login(signInDTO dto) {
		User user = null;
		System.out.println("User : " + dto);
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
	 * 
	 * @param internationalNumber
	 */
	public String removeHyphens(String phoneNumber) {
		return phoneNumber.replace("-", "");
	}

	// 이메일 중복 확인
	public int checkDuplicatedEmail(String email) {
		int member = userRepository.findByUserEmail(email);

		return member;
	}

	// 이메일 보내는 메서드
	public void sendCodeToEmail(String toEmail) {
		this.checkDuplicatedEmail(toEmail);
		String title = "JAM 이메일 인증 번호";
		String authCode = this.createCode();

		System.out.println("인증 요청");
		System.out.println(authCode);
		// 이메일 발송
		mailService.sendEmail(toEmail, title, authCode);

		// 인증 코드를 메모리에 저장 ( key = "AuthCode " + Email / value = AuthCode )
		authCodeStore.put(AUTH_CODE_PREFIX + toEmail, authCode);

		// 일정 시간 후 인증 코드를 자동으로 삭제하는 타이머 설정 (대신 Redis TTL을 활용할 수 없기 때문에 직접 처리)
		scheduleCodeExpiry(AUTH_CODE_PREFIX + toEmail, authCodeExpirationMillis);
	}

	// 인증 코드 생성
	private String createCode() {
		int length = 6;
		try {
			Random random = SecureRandom.getInstanceStrong();
			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < length; i++) {
				builder.append(random.nextInt(10)); // 0부터 9 사이의 숫자를 추가
			}
			return builder.toString(); // 루프가 완료된 후 문자열 반환
		} catch (NoSuchAlgorithmException e) {
			log.debug("MemberService.createCode() exception occurred", e);
			throw new RuntimeException("인증 코드 생성 중 오류가 발생했습니다."); // 예외를 던지거나 적절히 처리
		}
	}

	// 인증 코드 검증
	public EmailVerificationResult verifiedCode(String email, String authCode) {
		this.checkDuplicatedEmail(email);
		String storedAuthCode = authCodeStore.get(AUTH_CODE_PREFIX + email);
		boolean authResult = storedAuthCode != null && storedAuthCode.equals(authCode);

		return EmailVerificationResult.of(authResult);
	}

	// 인증 코드 만료 스케줄 설정
	private void scheduleCodeExpiry(String key, long expirationMillis) {
		new Timer().schedule(new TimerTask() {
			@Override
			public void run() {
				authCodeStore.remove(key);
			}
		}, expirationMillis); // 인증 코드 만료 시간 후 삭제
	}

	// 이메일 중복 여부 확인 메서드
	public boolean isEmailDuplicate(String email) {
		// 이메일로 사용자를 조회하고, 있으면 true, 없으면 false 반환
		return userRepository.findByEmail(email).isPresent();
	}	
	
	// 닉네임 중복 체크 메소드
    public boolean isNickNameDuplicate(String nickName) {
        Optional<User> user = userRepository.findByNickName(nickName); // 닉네임으로 사용자 조회
        return user.isPresent(); // 사용자가 존재하면 true 반환
    }
    
    /**
     * 비밀 번호 수정
     * @param password
     * @param email
     * @return
     */
    public int updatePasswordByEmail(String password, String email) {
    	int result = 0;
    	try {
			result = userRepository.updatePasswordByEmail(password, email);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
    	return result;
    }
}
