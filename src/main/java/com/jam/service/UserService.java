package com.jam.service;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.EmailVerificationResult;
import com.jam.dto.signInDTO;
import com.jam.dto.signUpDTO;
import com.jam.repository.interfaces.UserRepository;
import com.jam.repository.model.AccountHistoryDTO;
import com.jam.repository.model.Payment;
import com.jam.repository.model.User;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	private static final String AUTH_CODE_PREFIX = "AuthCode ";

	private final MailService mailService;

	// 메모리 기반으로 인증 코드를 저장하는 맵
	private final Map<String, String> authCodeStore = new ConcurrentHashMap<>();

	@Value("${spring.mail.auth-code-expiration-millis}")
	private long authCodeExpirationMillis;
	
	@Value("${file.upload-dir}")
	private String uploadDir;

	/**
	 * 
	 * @param user
	 */
	@Transactional // 트랜잭션 처리
	public void createUser(signUpDTO dto) {
		int result = 0;
		if (dto.getMFile() != null && !dto.getMFile().isEmpty()) {
			// 파일 업로드 로직 구현
			String[] fileNames = uploadFile(dto.getMFile());

			dto.setOriProfileImg(fileNames[0]);
			dto.setProfileImg(fileNames[1]);
		}
		String hashPwd = passwordEncoder.encode(dto.getPassword());
		dto.setPassword(hashPwd);
		result = userRepository.insert(dto);
		
		
		System.out.println("회원가입 서비스 : "+dto.toString());

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
		// 이메일로 유저를 조회
		User user = userRepository.findEmail(dto.getEmail());
		if (user == null) {
			throw new IllegalArgumentException("User not found with the provided email.");
		}

		// 비밀번호 확인
		if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
			throw new IllegalArgumentException("Password is incorrect.");
		}

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
	 * 
	 * @param password
	 * @param email
	 * @return
	 */
	public int updatePasswordByEmail(String password, String email) {
		int result = 0;
		try {
			String hashPwd = passwordEncoder.encode(password);
			result = userRepository.updatePasswordByEmail(hashPwd, email);
		} catch (Exception e) {
			// TODO - 오류 처리
		}
		return result;
	}
	

	/**
	 * 서버 운영체제에 파일 업로드 기능 MultipartFile getOriginalFilename : 사용자가 작성한 파일 명
	 * uploadFileName : 서버 컴퓨터에 저장 될 파일 명
	 * 
	 * @param mFile
	 * @return
	 */
	private String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > Define.MAX_FILE_SIZE) {
			// TODO - 오류 처리
//			throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.", HttpStatus.BAD_REQUEST);
		}

		// 코드 수정
		// File - getAbsolutePath()
		// (리눅스 또는 MacOS)에 맞춰서 절대 경로 생성을 시킬 수 있다.
		String saveDirectory = new File(uploadDir).getAbsolutePath();

		// 파일 이름 생성(중복 이름 예방)
		String uploadFileName = UUID.randomUUID() + "_" + mFile.getOriginalFilename();
		// 파일 전체 경로 + 새로생성한 파일명
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		File destination = new File(uploadPath);
		
		// 반드시 수행
		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			// TODO - 오류 처리
//			e.printStackTrace();
//			throw new DataDeliveryException("파일 업로드 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { mFile.getOriginalFilename(), uploadFileName };
	}
	
	/**
	 * 유저 회원정보 수정
	 * @param user
	 */
	public void updateProfile(User user) {
		userRepository.updateProfileByUserTb(user);
		userRepository.updateProfileByUserDeTb(user);
	}
	
	/**
	 * 유저 회원정보 수정 후 다시 정보 뿌리기 (1)
	 * @param email
	 */
	public User InformationUpdate(String email) {
		User user = null;
		user = userRepository.InformationUpdate(email);
		return user;
	}
	
	/**
	 * 유저 상세정보
	 * @param email
	 */
	public User createDetail(signUpDTO dto) {
		// TODO Auto-generated method stub
		User user = userRepository.emailsearch(dto);
		userRepository.insertbyUserTb(user.getUserId());
				
		System.out.println("@@@@"+user.toString());
		
		return user;
		
	}
	
	/**
	 * 유저 포인트 충전 내역이 들어간다.  (결제 히스토리)
	 * @param userId
	 * @param deposit
	 * @param point
	 * @param afterBalance
	 */
	public void insertPoint(int userId, long deposit, long point, long afterBalance, String payKey) {
		userRepository.insertPoint(userId, deposit, point, afterBalance, payKey);
	}
	
	/**
	 * 유저 아이디로 유저의 포인트를 조회한다.
	 * @param userId
	 */
	public int searchPoint(int userId) {
		
		int a = userRepository.selectUserPoint(userId);
		
		if(a == 1) {
			System.out.println("유저 포인트 조회 완료");
		} else {
			System.out.println("포인트 조회 실패 유저 없음!");
		}
		return a;
	}
	
	/**
	 * (결제)유저 포인트를 저장한다. 유저 상세 페이지를 연결
	 *  user_de_tb
	 * @param amount
	 * @param userId
	 */
	public void insert(Integer amount, long balance, int userId) {
		
		userRepository.insertUserTbPoint(amount, balance, userId);
		
	}
	
	/**
	 * 유저가 결제한 정보를 리스트로 뽑아낸다.
	 * @param userId
	 * @return
	 */
	public List<AccountHistoryDTO> findPayList(int userId) {
		// TODO Auto-generated method stub
		List<AccountHistoryDTO> dto = userRepository.findPayList(userId);
		return dto;
	}
	
	/**
	 * (환불) 유저 포인트를 저장한다. 유저 상세 페이지를 연결
	 * @param refundAmount
	 * @param balance
	 * @param userId
	 */
	public void delete(long refundAmount, long balance, int userId) {
		userRepository.deleteUserTbPoint(refundAmount, balance, userId);
		
	}
	
	
	

}
