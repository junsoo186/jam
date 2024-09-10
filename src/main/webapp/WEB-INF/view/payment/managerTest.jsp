<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p>여기에 결제 리스트 내역 </p>
	
<c:if test="${not empty payList}">
	<table border="1">
		<tr>
			<th>번호</th>
			<th>유저 번호</th>
			<th>결제 상품</th>
			<th>결제 날짜</th>
			<th>결제 히든키</th>
			<th>환불</th>
			<th>상태</th>
			<th>날짜</th>
			<th></th>
			<th>유무</th>
		</tr>
		<c:forEach var="payment" items="${payList}">
		    <tr>
		        <td>${payment.refundId}</td> <!-- 주문 번호 출력 -->
		        <td>${payment.userId}</td>  <!-- 결제 금액 출력 -->
		        <td>${payment.refundAmount}</td> <!-- 결제 날짜 출력 -->
		        <td>${payment.paymentKey} 코인</td>  <!-- 결제 상품 출력 -->
		    	<td>${payment.refundReason}</td> <!-- 결제 히든키 출력 -->
		    	<td>${payment.status}</td> 
		    	<td>${payment.createdAt}</td>
		    	<td>${payment.approvedAt}</td>
		    	<td>${payment.rejectedAt}</td>
		        <td>
		            <!-- 승인/거절 버튼이 있는 폼을 숨기기 위한 조건 -->
		            <c:choose>
		                <c:when test="${payment.status == '승인' or payment.status == '거절'}">
		                    <!-- 버튼 숨김 -->
		                    <p>처리 완료</p>
		                </c:when>
		                <c:otherwise>
		                    <!-- 환불 승인 버튼 -->
		                    <form id="refundForm_${payment.paymentKey}" action="/pay/reques" method="POST">
		                        <!-- hidden input으로 paymentKey와 refundAmount 전달 -->
		                        <input type="hidden" name="userId" value="${payment.userId}">	
		                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
		                        <input type="hidden" name="refundAmount" value="${payment.refundAmount}">
		                        <input type="hidden" name="refundReason" value="환불"> <!-- 기본 환불 이유 -->
		                        <button type="submit">승인</button>
		                    </form>

		                    <!-- 환불 거절 버튼 -->
		                    <form action="/pay/requesrefusal" method="POST">
		                        <input type="hidden" name="userId" value="${payment.userId}">	
		                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
		                        <input type="hidden" name="refundAmount" value="${payment.refundAmount}">
		                        <input type="hidden" name="refundReason" value="환불"> <!-- 기본 환불 이유 -->
		                        <button type="submit">거절</button>
		                    </form>
		                </c:otherwise>
		            </c:choose>
		        </td>
		    </tr>
		</c:forEach>
	</table>
</c:if>

<c:if test="${empty payList}">
	<p>환불 요청이 없습니다.</p>
</c:if>

</body>
</html>
