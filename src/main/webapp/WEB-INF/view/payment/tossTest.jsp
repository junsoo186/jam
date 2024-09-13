
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@page import="com.jam.repository.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/signIn.css">

<!-- SDK 추가 -->
<script src="https://js.tosspayments.com/v2/standard"></script>

<style>

body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 20px;
}

h1 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

.pay--list {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    max-width: 1000px;
    margin: 0 auto;
}

.pay--item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 48%; /* Adjust based on your preference for two items per row */
    margin-bottom: 10px;
    padding: 15px;
    border: 1px solid #ccc;
    background: #fff;
    border-radius: 5px;
}

.coin-info {
    display: flex;
    align-items: center;
    font-size: 16px;
}

.coin-info img {
    margin-right: 10px;
    width: 30px; /* Adjust size as needed */
}

.coin-price {
    margin-right: auto;
    margin-left: 20px;
    font-size: 16px;
}

.button {
    padding: 10px 20px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.button:hover {
    background-color: #0056b3;
}

</style>

</head>
<body>

	<%
	User user = (User) session.getAttribute("principal");
	String userEmail = user.getEmail(); // 이메일 값 가져오기
	String userName = user.getNickName(); // 닉네임 가져오기
	String userNumber = user.getPhoneNumber();
	
	// 기본값 지정
    String customerNumber = null; // 기본적인 값
	
 	// user 세션의 userNumber 값이 null 비교 
    if (userNumber != null) {
        customerNumber = userNumber.replace("-", ""); // 토스 전화번호는 010-0000-0000 형식을 지원하지 않음
    } else {
    	customerNumber = "01012345678";
    }
	
	%>

	<div>
		<h1>충전 페이지</h1>
	</div>

	<!-- 결제하기 버튼 -->
	<div class="pay--list">
		<div class="pay--item">
				<h3>1000원</h3>
				<h3>1000코인</h3>
				<button class="button" style="margin-top: 30px" onclick="requestPayment(1000, '1000코인')">결제하기</button>
		</div>

		<div class="pay--item">
			<h3>2000원</h3>
			<h3>2000코인</h3>
			<button class="button" style="margin-top: 30px" onclick="requestPayment(2000, '2000코인')">결제하기</button>
		</div>

		<div class="pay--item">
			<h3>3000원</h3>
			<h3>3000코인</h3>
			<button class="button" style="margin-top: 30px" onclick="requestPayment(3000, '3000코인')">결제하기</button>
		</div>

		<div class="pay--item">
			<h3>4000원</h3>
			<h3>4000코인</h3>
			<button class="button" style="margin-top: 30px" onclick="requestPayment(4000, '4000코인')">결제하기</button>
		</div>
	</div>
	<a href="/">홈페이지로 돌아가기</a>

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
      const customerEmail = "<%=userEmail%>"; <%-- 유저 이메일 --%>
      const customerName = "<%=userName%>"; <%-- 유저 이름 --%>
      const customerNumber = "<%=customerNumber%>";
      <%-- const customerNumber = "<%=(userNumber != null) ? userNumber : "01012345678"%>"; --%>
  	  console.log(customerNumber);

      
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

	<%@ include file="/WEB-INF/view/layout/footer.jsp"%>