<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 리스트</title>
<script type="text/javascript">
    // 부모 창에서 실행되는 함수: 팝업 창에서 호출
    function submitRefundForm(paymentKey) {
        document.getElementById('refundForm_' + paymentKey).submit();
    }

    function showAlertAndOpenTerms(paymentKey, refundAmount) {
        // 약관 창을 새 탭으로 열기
        window.open('/pay/termsAndConditions?paymentKey=' + paymentKey, '_blank', 'width=500,height=500');
    }
</script>
</head>
<body>
	
	<p>여기에 결제 리스트 내역 </p>
	
	<c:if test="${not empty payList}">
		<table border="1">
			<tr>
				<th>주문 번호</th>
				<th>결제 금액</th>
				<th>잔액</th>
				<th>결제 상품</th>
				<th>결제 날짜</th>
				<th>결제 히든키</th>
				<th>환불</th>
				<th>버튼</th>
			</tr>
			<c:forEach var="payment" items="${payList}">
			    <tr>
			        <td>${payment.accountHistoryId}</td> <!-- 주문 번호 출력 -->
			        <td>${payment.deposit}</td>  <!-- 결제 금액 출력 -->
			        <td>${payment.point} 코인</td>  <!-- 결제 상품 출력 -->
			        <td>${payment.createdAt}</td> <!-- 결제 날짜 출력 -->
			        <td>${payment.afterBalance}</td>
			    	<td>${payment.paymentKey}</td> <!-- 결제 히든키 출력 -->
			    	<td>${payment.status}</td>
			    	
			            <!-- 환불 버튼이 있는 폼 -->
<td>		            
<c:choose>
    <c:when test="${payment.status == 'PENDING'}">
        <!-- status가 'PENDING'일 때만 환불 버튼을 보여줌 -->
        <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST">
            <!-- hidden input으로 paymentKey와 refundAmount (deposit) 전달 -->
            <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
            <input type="hidden" name="refundAmount" value="${payment.deposit}">
            <input type="hidden" name="userId" value="${payment.userId}">
            <input type="hidden" name="refundReason" value="환불"> <!-- 기본 환불 이유 -->

            <!-- 환불 버튼 클릭 시 showAlertAndOpenTerms 함수 호출 -->
            <button type="button" id="button" onclick="showAlertAndOpenTerms('${payment.paymentKey}', '${payment.deposit}')">환불</button>
        </form>
    </c:when>
    <c:otherwise>
        <!-- status가 'PENDING'이 아닐 때 버튼을 숨김 -->
        <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST" style="display:none;">
            <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
            <input type="hidden" name="refundAmount" value="${payment.deposit}">
            <input type="hidden" name="userId" value="${payment.userId}">
            <input type="hidden" name="refundReason" value="환불">
            
            <!-- 환불 버튼은 숨겨짐 -->
            <button type="button" onclick="showAlertAndOpenTerms('${payment.paymentKey}', '${payment.deposit}')">환불</button>
        </form>
    </c:otherwise>
</c:choose>
			            
		       </td>
			    </tr>
			</c:forEach>
		</table>
	</c:if>
	
	<c:if test="${empty payList}">
		<p>결제 내역이 없습니다.</p>
	</c:if>
	

	
</body>
</html>
