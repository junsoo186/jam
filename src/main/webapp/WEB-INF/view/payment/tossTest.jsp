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

	<!-- 결제하기 버튼 -->
	<div>
		<button class="button" style="margin-top: 30px" onclick="requestPayment()">결제하기</button>
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
      async function requestPayment() {
    	  
    	  const randomOrderId = generateUUID(); // 고유한 주문번호 생성
    	  console.log("주문번호 orderId : ", randomOrderId); // 고유한 주문번호 출력
    	  
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        await payment.requestPayment({
          method: "CARD", // 카드 결제
          amount: {
            currency: "KRW",
            value: 100000, 
          },
          orderId: randomOrderId, // 고유 주분번호
          orderName: "코인 100000개", 
          successUrl:"http://localhost:8080/pay/success", // 결제 요청이 성공하면 리다이렉트되는 URL
          failUrl: "http://localhost:8080/pay/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
          customerEmail: "JoinAndMaker@gmail.com",
          customerName: "그린컴퓨터아카데미",
          customerMobilePhone: "01012341234",
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
