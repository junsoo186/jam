<%@page import="com.jam.repository.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<!-- SDK 추가 -->
<script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
	
	<%
		User user = (User)session.getAttribute("principal");
		String userEmail = user.getEmail(); // 이메일 값 가져오기
		String userName = user.getNickName(); // 닉네임 가져오기
		String userNumber = user.getPhoneNumber().replaceAll("-", ""); // 유저 전화번호에서 '-' 제거 ex) 010-1234-5678 => 01012345678
	%>
	
	<!-- 결제하기 버튼 -->
	<div>
		<p>1000원 1000코인</p>
		<button class="button" style="margin-top: 30px" onclick="requestPayment(1000, '1000코인')">결제하기</button>
	</div>
	
	<div>
		<p>2000원 2000코인</p>
		<button class="button" style="margin-top: 30px" onclick="requestPayment(2000, '2000코인')">결제하기</button>
	</div>
	
	<div>
		<p>3000원 3000코인</p>
		<button class="button" style="margin-top: 30px" onclick="requestPayment(3000, '3000코인')">결제하기</button>
	</div>
	
	<div>
		<p>4000원 4000코인</p>
		<button class="button" style="margin-top: 30px" onclick="requestPayment(4000, '4000코인')">결제하기</button>
	</div>
	
	
	
	
	<script>
      // ------  SDK 초기화 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
      const clientKey = "test_ck_ma60RZblrqzdY5bJvqgW8wzYWBn1";
      const customerKey = "T0BQbwdc9MRxAIPmJw9xs";
      const tossPayments = TossPayments(clientKey);
      // 회원 결제
      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
      const payment = tossPayments.payment({ customerKey });
      
      // JSP에서 전달된 값 가져오기
      const customerEmail = "<%= userEmail %>"; <%-- 유저 이메일 --%>
      const customerName = "<%= userName %>"; <%-- 유저 이름 --%>
      const customerNumber = "<%= userNumber %>"; <%-- 유저 전화번호 --%>
      
      
   // UUID 생성 함수
      function generateUUID() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
          var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
          return v.toString(16);
        });
      }
   
      // 비회원 결제
      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})
      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
      async function requestPayment(pay, pay2) {
    	  
    	  const randomOrderId = generateUUID(); // 고유한 주문번호 생성
    	  console.log("주문번호 orderId : ", randomOrderId); // 고유한 주문번호 출력
    	  
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        await payment.requestPayment({
          method: "CARD", // 카드 결제
          amount: {
            currency: "KRW",
            value: pay, // 현금
          },
          orderId: randomOrderId, // 고유 주분번호
          orderName: pay2, // 포인트
          successUrl:"http://localhost:8080/pay/success", // 결제 요청이 성공하면 리다이렉트되는 URL
          failUrl: "http://localhost:8080/pay/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
          customerEmail: customerEmail, // 유제 이메일
          customerName: customerName, // 유저 이름
          customerMobilePhone: customerNumber, // 유저 전화번호 특수문자 못씀 ex) 010-1234-5678 이런거 안됨
          // 카드 결제에 필요한 정보
          card: {
            useEscrow: false,
            flowMode: "DEFAULT", // 통합결제창 여는 옵션
            useCardPoint: false,
            useAppCardOnly: false,
          },
        });
      }
    </script>
</body>
</html>