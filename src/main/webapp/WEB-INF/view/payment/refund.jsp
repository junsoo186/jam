<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <form action="/pay/refund" method="post">
        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
        <label for="refundAmount">환불 금액:</label>
        <input type="number" name="refundAmount" id="refundAmount" value="100000" required>
        
        <label for="refundReason">환불 사유:</label>
        <input type="text" name="refundReason" id="refundReason" value="결제 취소" required>
        
        <button type="submit">환불 요청</button>
    </form>
</body>
</html>