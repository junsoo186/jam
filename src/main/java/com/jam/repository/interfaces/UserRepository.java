package com.jam.repository.interfaces;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.signUpDTO;
import com.jam.repository.model.AccountHistoryDTO;
import com.jam.repository.model.RefundRequest;
import com.jam.repository.model.User;

@Mapper
public interface UserRepository {
	public int insert(signUpDTO user); // 회원가입 (닉네임, 이메일, 비밀번호, 사진)

	public void insertbyUserTb(@Param("userId") Integer userId); // 회원가입 (포인트, 이름, 생일, 주소) 등록

	public User emailsearch(signUpDTO user); // 회원 가입 후 유저 디테일에 연결하기 위해서 작성

	public User findEmail(@Param("email") String email); // 로그인

	public int findByUserEmail(String email); // 이메일 찾기
	
	public User selectUserInfo(@Param("userId") Integer userId); // 유저 ID로 찾기

	Optional<User> findByEmail(String email); // 이메일 중복 확인

	public int fineByUserNickName(String nickName); // 닉네임 찾기

	Optional<User> findByNickName(String nickName); // 닉네임으로 사용자 찾기

	int updatePasswordByEmail(@Param("password") String password, @Param("email") String email);

	int updateProfileByUserTb(User user); // 유저 프로필 업데이트 UserTb

	int updateProfileByUserDeTb(User user); // 유저 프로필 업데이트 UserDeTb

	public User InformationUpdate(@Param("email") String email); // 유저 프로필 업데이트 후 갱신 
	
	// 유저가 포인트를 적립하려면 유저ID, 입금금액, 충전포인트, 기존포인트 +(-) 충전포인트 
	public int insertPoint(@Param("userId") Integer userId , @Param("deposit") long deposit, @Param("point") long point, @Param("afterBalance") long afterBalance, @Param("paymentKey") String paymentKey, @Param("event") char event, @Param("method") String method);
	
	// 관리자가 유저의 환불을 승인하면 기존의 포인트에서 업데이트 한다.
	public int updatePoint(@Param("userId") Integer userId , @Param("deposit") long deposit, @Param("point") long point, @Param("afterBalance") long afterBalance, @Param("refundReason")String refundReason , @Param("paymentKey") String paymentKey);
	
	public int selectUserPoint(@Param("userId") Integer userId);
	
	// 유저 상세 정보 db에 결제한 포인트 값을 넣는다.
	public int insertUserTbPoint(@Param("pay2") Integer pay2, @Param("balance") long balance , @Param("userId") Integer userId);
	
	// 유저가 포인트를 환불하면 유저ID, 출금금액, 충전포인트, 기존포인트 - 충전포인트
	public int deleteUserTbPoint(@Param("refundAmount") long refundAmount, @Param("balance") long balance , @Param("userId") Integer userId);
	
	// 유저가 결제한 정보를 출력한다. (유저 아이디를 기준으로 한다.)
	List<AccountHistoryDTO> findPayList(@Param("userId") Integer userId);
	
	// 유저가 환불을 신청하면 환불요청 테이블로 유정의 정보값이 들어간다. (REFUND_REQUEST_TB )
	void findRefundList(RefundRequest refundRequest);
	
	// 환불을 신청한 모든 사람들을 조회한다.
	public List<RefundRequest> selectRefundRequest(@Param("pageSize") int pageSize, @Param("offset") int offset);
	
	// 관리자가 유저의 포인트 환불에 대해 승인 할 수 있다.
	public void pointAudit(RefundRequest dto);
	
	// 관리자가 유저의 포인트 환불에 대해 거절 할 수 있다.
	public void pointreject(RefundRequest dto);
	
	// account_history_tb의 status 가 '승인'으로 변경
	public void updateStatus1(String paymentKey);

	// account_history_tb의 status 가 '거절'으로 변경
	public void updateStatus2(String paymentKey);
	
	// paymentKey 키로 refund_request_tb에 환불을 여러번 넣을 수 없도록 한다.
	public int historyPaymentKeyCheck(String paymentKey);
	
	// 관리자가 유저의 포인트 환불에 대해 심사중으로 변경 할 수 있다. (0911)
	public void pointAuditWait(String paymentKey);
	
	public void updatePointByCheckout(@Param("userId") Integer userId, @Param("point") long point);

	public void updatePointByRefund(@Param("userId") Integer userId, @Param("point") long point);
<<<<<<< HEAD

	public RefundRequest findPayDetailByRefundId(Integer refundId);

	public int getTotalRefundRequestCount();
=======
>>>>>>> sub-dev
	
	// 관리자가 환불을 거절했을 시 상태값 refundReason(사유)를 업데이트 
	public void updaterefundReason(@Param("refundReason") String refundReason, @Param("paymentKey") String paymentKey);
	
	// 사용자가 포인트 구매를 하면 account_history_tb에 기록을 남기고,
	// 포인트 적립 이벤트 테이블인 payment_tb에도 기록을 남긴다. event -> 'Y' or 'N'
	public void InsertPaymentTB(@Param("userId") Integer userId, @Param("paymentKey") String paymentKey, @Param("price") long price, @Param("point") long point, @Param("event") char event);
<<<<<<< HEAD
=======

	public RefundRequest findPayDetailByRefundId(Integer refundId);

	public int getTotalRefundRequestCount();

>>>>>>> sub-dev
}