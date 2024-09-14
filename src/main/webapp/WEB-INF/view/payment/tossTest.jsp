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

.pay-list {
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

.pay---button {
    padding: 10px 20px;
    background-color: #ff00ff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.pay---button:hover {
    background-color: #ff00ee;
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
    <h2 id="event-message">이벤트 상태 확인 중...</h2> <!-- 이벤트 상태를 표시하는 메시지 -->
</div>

	<!-- 결제하기 버튼 리스트 -->
<div class="pay-list">
    <div class="pay--item">
        <h3>1000원</h3>
        <h3 id="coin-1000">1000코인</h3>  <!-- 코인 수량을 보여줌 -->
        <button class="pay---button" id="payment-button-1000" onclick="requestPayment(1000, '1000코인')">결제하기</button>  <!-- 결제 버튼 -->
    </div>
    <div class="pay--item">
        <h3>2000원</h3>
        <h3 id="coin-2000">2000코인</h3>  <!-- 코인 수량을 보여줌 -->
        <button class="pay---button" id="payment-button-2000" onclick="requestPayment(2000, '2000코인')">결제하기</button>  <!-- 결제 버튼 -->
    </div>
    
    <div class="pay--item">
        <h3>3000원</h3>
        <h3 id="coin-2000">3000코인</h3>  <!-- 코인 수량을 보여줌 -->
        <button class="pay---button" id="payment-button-3000" onclick="requestPayment(3000, '3000코인')">결제하기</button>  <!-- 결제 버튼 -->
    </div>
    
    <div class="pay--item">
        <h3>4000원</h3>
        <h3 id="coin-2000">4000코인</h3>  <!-- 코인 수량을 보여줌 -->
        <button class="pay---button" id="payment-button-4000" onclick="requestPayment(4000, '4000코인')">결제하기</button>  <!-- 결제 버튼 -->
    </div>
    
    <div class="pay--item">
        <h3>5000원</h3>
        <h3 id="coin-2000">5000코인</h3>  <!-- 코인 수량을 보여줌 -->
        <button class="pay---button" id="payment-button-5000" onclick="requestPayment(5000, '5000코인')">결제하기</button>  <!-- 결제 버튼 -->
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
    
    
 // 페이지가 로드될 때 이벤트 상태를 자동으로 확인함
    document.addEventListener('DOMContentLoaded', checkEventStatus);

    // 이벤트 토글 버튼을 클릭했을 때 상태를 변경하는 함수
    document.getElementById("toggle-event-button").addEventListener("click", function() {
        fetch("/pay/toggleEvent", { method: 'POST' })  // /pay/toggleEvent API에 POST 요청을 보냄
            .then(response => response.text())  // 서버로부터 텍스트 응답을 받음
            .then(message => {
                alert(message);  // 이벤트 상태 변경 메시지를 알림으로 표시
                checkEventStatus();  // 상태를 다시 확인해서 화면을 업데이트함
            });
    });
    
	// 페이지가 로드되면 이벤트 상태를 확인하는 함수
    async function checkEventStatus() {
        const response = await fetch("/pay/eventStatus");  // /pay/eventStatus API에 GET 요청을 보냄
        const isEventActive = await response.json();  // JSON 응답을 받음

     // 이벤트가 활성화된 경우
        if (isEventActive) {
            document.getElementById('event-message').innerText = "이벤트 중! 추가 할인이 적용됩니다.";  // 이벤트 활성화 메시지 표시
            document.getElementById('coin-1000').innerText = "1100코인";  // 이벤트 시 추가 코인 수량 적용
            document.getElementById('coin-2000').innerText = "2100코인";  // 이벤트 시 추가 코인 수량 적용
            document.getElementById('coin-3000').innerText = "3100코인";  // 이벤트 시 추가 코인 수량 적용
            document.getElementById('coin-4000').innerText = "4100코인";  // 이벤트 시 추가 코인 수량 적용
            document.getElementById('coin-5000').innerText = "5100코인";  // 이벤트 시 추가 코인 수량 적용

            // 버튼 클릭 시 동적으로 변경된 값으로 결제 요청
            document.getElementById('payment-button-1000').setAttribute('onclick', "requestPayment(1000, '1100코인')");
            document.getElementById('payment-button-2000').setAttribute('onclick', "requestPayment(2000, '2100코인')");
            document.getElementById('payment-button-3000').setAttribute('onclick', "requestPayment(3000, '3100코인')");
            document.getElementById('payment-button-4000').setAttribute('onclick', "requestPayment(3000, '4100코인')");
            document.getElementById('payment-button-5000').setAttribute('onclick', "requestPayment(3000, '5100코인')");
        } else {
            // 이벤트가 비활성화된 경우
            document.getElementById('event-message').innerText = "일반 결제입니다.";  // 일반 결제 메시지 표시
            document.getElementById('coin-1000').innerText = "1000코인";  // 기본 코인 수량
            document.getElementById('coin-2000').innerText = "2000코인";  // 기본 코인 수량
            document.getElementById('coin-3000').innerText = "3000코인";  // 기본 코인 수량
            document.getElementById('coin-4000').innerText = "4000코인";  // 기본 코인 수량
            document.getElementById('coin-4000').innerText = "5000코인";  // 기본 코인 수량

            // 버튼 클릭 시 기본 값으로 결제 요청
            document.getElementById('payment-button-1000').setAttribute('onclick', "requestPayment(1000, '1000코인')");
            document.getElementById('payment-button-2000').setAttribute('onclick', "requestPayment(2000, '2000코인')");
            document.getElementById('payment-button-3000').setAttribute('onclick', "requestPayment(3000, '3000코인')");
            document.getElementById('payment-button-4000').setAttribute('onclick', "requestPayment(4000, '4000코인')");
            document.getElementById('payment-button-5000').setAttribute('onclick', "requestPayment(5000, '5000코인')");
        }
    }

    </script>

	<%@ include file="/WEB-INF/view/layout/footer.jsp"%>