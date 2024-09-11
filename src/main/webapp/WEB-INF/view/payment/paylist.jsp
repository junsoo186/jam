<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel="stylesheet" href="/css/signIn.css">
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	
	    /* 기본 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        font-size: 16px;
        font-family: 'Arial', sans-serif;
        text-align: left;
    }

    th, td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }

    /* 테이블 헤더 스타일 */
    th {
        background-color: #f4f4f4;
        font-weight: bold;
    }

    /* 테이블 셀 스타일 */
    td {
        background-color: #fff;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    /* 버튼 스타일 */
    button {
        background-color: #4CAF50; /* Green */
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 8px;
    }

    button:hover {
        background-color: #45a049;
    }

    /* 거절 버튼 스타일 */
    button[type="submit"]:nth-child(2) {
        background-color: #f44336; /* Red */
    }

    button[type="submit"]:nth-child(2):hover {
        background-color: #e53935;
    }

    /* '처리 완료' 텍스트 스타일 */
    p {
        font-weight: bold;
        color: #888;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        table {
            font-size: 14px;
        }

        button {
            padding: 8px 16px;
            font-size: 14px;
        }
    }
	
</style>


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
	
<section class="center--paylist--area">
	<c:if test="${not empty payList}">
		<table border="1" class="center--paylist--area--list">
			<tr>
				<th>주문 번호</th>
				<th>결제 금액</th>
				<th>충전 포인트</th>
				<th>결제 날짜</th>
				<th>잔액</th>
				<th>승인여부</th>
				<th>버튼</th>
			</tr>
			
			<c:forEach var="payment" items="${payList}">
			<tr>
			    <td>${payment.accountHistoryId}</td> <!-- 주문 번호 출력 -->
			    <td>${payment.deposit}원</td>  <!-- 결제 금액 출력 -->
			    <td>${payment.point} 코인</td>  <!-- 결제 상품 출력 -->
			    <td>${payment.createdAt}</td> <!-- 결제 날짜 출력 -->
			    <td>${payment.afterBalance}코인</td>
			    <td>${payment.status}</td>		    	
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
	
</section>
	

	
</body>

</html>
