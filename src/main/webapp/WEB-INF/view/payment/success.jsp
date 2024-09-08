<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 성공</title>
</head>
<body>
    <h1>결제 성공</h1>
    <p>주문 번호 : ${payment.orderId}</p>
    <p>주문명: ${payment.orderName}</p>
    <p>총 금액: ${payment.totalAmount}원</p>
</body>

<div>
	<a href="/">메인 페이지로 이동</a>
	<a href="/pay/refund">환불</a>
</div>

</html>