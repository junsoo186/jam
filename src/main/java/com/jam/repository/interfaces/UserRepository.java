package com.jam.repository.interfaces;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.signUpDTO;
import com.jam.repository.model.AccountHistoryDTO;
import com.jam.repository.model.Payment;
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
	
	// 유저가 포인트를 적립하려면 유저ID, 입금금액, 충전포인트, 기존포인트 +(-) 충전포인트 
	public int insertPoint(@Param("userId") Integer userId , @Param("deposit") long deposit, @Param("point") long point, @Param("afterBalance") long afterBalance, @Param("paymentKey") String paymentKey);
	
	public int selectUserPoint(@Param("userId") Integer userId);
	// 유저 상세 정보 db에 결제한 포인트 값을 넣는다.
	public int insertUserTbPoint(@Param("amount") Integer amount, @Param("balance") long balance , @Param("userId") Integer userId);
	
	// 유저가 포인트를 환불하면 유저ID, 출금금액, 충전포인트, 기존포인트 - 충전포인트
	public int deleteUserTbPoint(@Param("refundAmount") long refundAmount, @Param("balance") long balance , @Param("userId") Integer userId);
	
	// 유저가 결제한 정보를 출력한다. (유저 아이디를 기준으로 한다.)
	List<AccountHistoryDTO> findPayList(@Param("userId") int userId);
}