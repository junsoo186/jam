<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/css/signIn.css">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- JSTL 함수 라이브러리 선언 -->

<style>
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

th {
	background-color: #f4f4f4;
	font-weight: bold;
}

td {
	background-color: #fff;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

button {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 8px;
}

button:hover {
	background-color: #45a049;
}

button[type="submit"]:nth-child(2) {
	background-color: #f44336;
}

button[type="submit"]:nth-child(2):hover {
	background-color: #e53935;
}

p {
	font-weight: bold;
	color: #888;
}

@media ( max-width : 768px) {
	table {
		font-size: 14px;
	}
	button {
		padding: 8px 16px;
		font-size: 14px;
	}
}
</style>


<link rel="stylesheet" href="/css/signIn.css">

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
	background-color: #4CAF50;
	/* Green */
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
	background-color: #f44336;
	/* Red */
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
@media ( max-width : 768px) {
	table {
		font-size: 14px;
	}
	button {
		padding: 8px 16px;
		font-size: 14px;
	}
}
</style>

<script src="/js/payList.js"></script>

<script>
function setRefundReasonAndSubmit(paymentKey, deposit) {
    // 환불사유 입력 필드에서 값을 가져옴
    var refundReason = document.getElementById('refundReason_' + paymentKey).value;

    // 숨겨진 환불 사유 필드에 값을 설정
    document.getElementById('refundReasonHidden_' + paymentKey).value = refundReason;

    // 폼을 제출
    document.getElementById('refundForm_' + paymentKey).submit();
}
</script>

</head>
<body>

	<p>결제 리스트</p>
	<a href="/">홈페이지로 돌아가기</a>

	<section class="center--paylist--area">
		<c:if test="${not empty payList}">
			<table border="1" class="center--paylist--area--list">
				<tr>
					<th>주문 번호</th>
					<th>결제 금액</th>
					<th>충전 포인트</th>
					<th>결제 날짜</th>
					<th>잔액</th>
					<th>환불사유</th>
					<th>승인여부</th>
					<th>버튼</th>
				</tr>

				<c:forEach var="payment" items="${payList}">
					<tr>
						<td>${payment.accountHistoryId}</td>
						<!-- 주문 번호 출력 -->
						<td>${payment.deposit}원</td>
						<!-- 결제 금액 출력 -->
						<td>${payment.point}코인</td>
						<!-- 결제 상품 출력 -->
						<td>${payment.createdAt}</td>
						<!-- 결제 날짜 출력 -->
						<td>${payment.afterBalance}코인</td>
						<td>
						  <!-- 환불 사유 입력 필드, status가 null이 아닐 때만 보이도록 설정 -->
            <c:choose>
                <c:when test="${payment.status != null}">
                    <input type="text" id="refundReason_${payment.paymentKey}" placeholder="환불 사유 입력" value="${payment.refundReason}">
                </c:when>
                <c:otherwise>
                    <!-- status가 null일 경우 status 값만 출력 -->
                    ${payment.status}
                </c:otherwise>
            </c:choose>
        </td>
        <td>${payment.status}</td>
        <td>
            <c:choose>
                <c:when test="${payment.status == 'PENDING'}">
                    <!-- status가 'PENDING'일 때만 환불 버튼을 보여줌 -->
                    <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST">
                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
                        <input type="hidden" name="refundAmount" value="${payment.deposit}">
                        <input type="hidden" name="userId" value="${payment.userId}">
                        <!-- 자바스크립트를 통해 환불 사유를 제출할 수 있도록 설정 -->
                        <input type="hidden" id="refundReasonHidden_${payment.paymentKey}" name="refundReason" value="">
                        <button type="button" id="refundButton_${payment.paymentKey}" onclick="setRefundReasonAndSubmit('${payment.paymentKey}', '${payment.deposit}')">환불</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- status가 'PENDING'이 아닐 때 버튼 숨김 -->
                    <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST" style="display: none;">
                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
                        <input type="hidden" name="refundAmount" value="${payment.deposit}">
                        <input type="hidden" name="userId" value="${payment.userId}">
                        <input type="hidden" id="refundReasonHidden_${payment.paymentKey}" name="refundReason" value="${payment.paymentKey}">
                        <button type="button" id="refundButton_${payment.paymentKey}" onclick="setRefundReasonAndSubmit('${payment.paymentKey}', '${payment.deposit}')">환불</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<hr />
		<c:choose>
			<c:when test="${not empty fundingList}">
				<c:forEach var="funding" items="${fundingList}">
					<table>
						<tr>
							<th>결제 날짜</th>
							<th>결제 포인트</th>
							<th>결제 리워드</th>
							<th>구매 개수</th>
							<th>배송지 주소</th>
							<c:choose>
								<c:when test="${funding.cancelConfirm eq 'Y'}">
									<th>취소 여부</th>
									<th>취소 날짜</th>
								</c:when>
								<c:otherwise>
									<th>펀딩 취소</th>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<td>${funding.createdAt}</td>
							<td>${funding.rewardPoint}</td>
							<td>${funding.rewardContent}</td>
							<td>${funding.rewardQuantity}</td>
							<td>${funding.shippingAddress}</td>
							<c:choose>
								<c:when test="${funding.cancelConfirm eq 'Y'}">
									<td>취소됨</td>
									<td>${funding.canceledAt}</td>
								</c:when>
								<c:otherwise>
									<td><button type="button" id="cancleFunding">펀딩 취소</button></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<p>펀딩 구매 내역이 없습니다.</p>
			</c:otherwise>
		</c:choose>

	</section>



</body>

</html>