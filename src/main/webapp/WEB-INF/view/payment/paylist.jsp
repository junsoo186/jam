<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/css/signIn.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
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

button:disabled {
    background-color: #d3d3d3; /* 회색 배경 */
    color: #808080; /* 어두운 텍스트 색상 */
    cursor: not-allowed; /* 비활성화된 상태 커서 */
    border: none; /* 테두리 제거 */
}

button:disabled:hover {
    background-color: #d3d3d3; /* hover 상태에도 동일한 배경 */
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

<<<<<<< HEAD
<script type="text/javascript">
    // 부모 창에서 실행되는 함수: 팝업 창에서 호출
    function submitRefundForm(paymentKey, deposit) {
    	
        document.getElementById('refundForm_' + paymentKey).submit();
       
    }

    function setRefundReasonAndSubmit(paymentKey, refundAmount) {
    	 // 환불사유 입력 필드에서 값을 가져옴
        var refundReason = document.getElementById('refundReason_' + paymentKey).value;
    	// 숨겨진 환불 사유 필드에 값을 설정
        document.getElementById('refundReasonHidden_' + paymentKey).value = refundReason;
    	
        // 약관 창을 새 탭으로 열기
        window.open('/pay/termsAndConditions?paymentKey=' + paymentKey, '_blank', 'width=500,height=500');
    }
=======
<script>
    function setRefundReasonAndSubmit(paymentKey, deposit) {
        var refundReason = document.getElementById('refundReason_' + paymentKey).value;
        document.getElementById('refundReasonHidden_' + paymentKey).value = refundReason;
        document.getElementById('refundForm_' + paymentKey).submit();
    }

    function cancelFunding(fundingId, totalAmount) {
        const url = '/funding/cancelFunding';
        const data = {
            fundingId: fundingId,
            totalAmount: totalAmount
        };

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                alert("펀딩이 성공적으로 취소되었습니다.");
                location.reload();
            } else {
                alert("펀딩 취소 중 오류가 발생했습니다.");
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("펀딩 취소 중 오류가 발생했습니다.");
        });
    }

    function calculateRemainingDays(endDateStr) {
        const today = new Date(); // 오늘 날짜
        const endDate = new Date(endDateStr); // 종료일
        const timeDifference = endDate - today;
        const remainingDays = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));
        return remainingDays;
    }

    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('.date-end').forEach(function(el) {
            const endDateStr = el.dataset.endDate;
            const remainingDays = calculateRemainingDays(endDateStr);

            if (remainingDays >= 0) {
                el.textContent = `남은 일: ${remainingDays}일`;
            } else {
                el.textContent = '마감됨';
            }
        });
    });
>>>>>>> 834ff0d546f865f12d767d930f5eaea093c34a41
</script>

</head>
<body>
    <section class="center--paylist--area">
        <p>결제 리스트</p>
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

<<<<<<< HEAD
	<p>결제 리스트</p>
	<a href="/">홈페이지로 돌아가기</a>

	<section class="center--paylist--area">
		<c:if test="${not empty payList}">
			<table border="1" class="center--paylist--area--list">
				<tr>
					<th>결제 번호</th>
					<th>결제 금액</th>
					<th>충전 포인트</th>
					<th>결제 날짜</th>
					<th>잔액</th>
					<th>결제</th>
					<th>이벤트 여부</th>
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
						
						<td>${payment.method}</td>
						
						<td>${payment.event}</td>
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
                <c:when test="${payment.status == 'PENDING' && fn:trim(payment.event) == 'N'}">
                    <!-- status가 'PENDING'일 때만 환불 버튼을 보여줌 -->
                    <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST">
                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
                        <input type="hidden" name="refundAmount" value="${payment.deposit}">
                        <input type="hidden" name="userId" value="${payment.userId}">
                        <input type="hidden" name="point" value="${payment.point}"> <!-- 포인트 -->
                        <input type="hidden" name= "method" value="${payment.method}">
                        
                        <!-- 자바스크립트를 통해 환불 사유를 제출할 수 있도록 설정 -->
                        <input type="hidden" id="refundReasonHidden_${payment.paymentKey}" name="refundReason" value="${payment.refundReason}">
                        <button type="button" id="refundButton_${payment.paymentKey}" onclick="setRefundReasonAndSubmit('${payment.paymentKey}', '${payment.deposit}')">환불</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- status가 'PENDING'이 아닐 때 버튼 숨김 -->
                    <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST" style="display: none;">
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

=======
                <c:forEach var="payment" items="${payList}">
                    <tr>
                        <td>${payment.accountHistoryId}</td>
                        <td>${payment.deposit}원</td>
                        <td>${payment.point}코인</td>
                        <td>${payment.createdAt}</td>
                        <td>${payment.afterBalance}코인</td>
                        <td>
                            <c:choose>
                                <c:when test="${payment.status != null}">
                                    <input type="text" id="refundReason_${payment.paymentKey}"
                                        placeholder="환불 사유 입력" value="${payment.refundReason}">
                                </c:when>
                                <c:otherwise>
                                    ${payment.status}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${payment.status}</td>
                        <td>
                            <c:choose>
                                <c:when test="${payment.status == 'PENDING'}">
                                    <form id="refundForm_${payment.paymentKey}" action="/pay/manager" method="POST">
                                        <input type="hidden" name="paymentKey" value="${payment.paymentKey}">
                                        <input type="hidden" name="refundAmount" value="${payment.deposit}">
                                        <input type="hidden" name="userId" value="${payment.userId}">
                                        <input type="hidden" id="refundReasonHidden_${payment.paymentKey}" name="refundReason" value="">
                                        <button type="button" id="refundButton_${payment.paymentKey}" onclick="setRefundReasonAndSubmit('${payment.paymentKey}', '${payment.deposit}')">환불</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
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
        <p>펀딩 내역</p>
        <c:choose>
            <c:when test="${not empty fundingList}">
                <table>
                    <tr>
                        <th>결제 날짜</th>
                        <th>결제 포인트</th>
                        <th>결제 리워드</th>
                        <th>구매 개수</th>
                        <th>배송지 주소</th>
                        <th>마감 확인</th>
                        <th>펀딩 취소</th>
                    </tr>
                    <c:forEach var="funding" items="${fundingList}">
                        <tr>
                            <td>${funding.createdAt}</td>
                            <td>${funding.rewardPoint}</td>
                            <td><a href="/funding/fundingDetail?projectId=${funding.projectId}">${funding.rewardContent}</a></td>
                            <td>${funding.rewardQuantity}</td>
                            <td>${funding.shippingAddress}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${funding.isClosed eq 'Y'}">
                                        마감됨
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${funding.dateEnd}" pattern="yyyy-MM-dd" />
                                        <span class="date-end" data-end-date="${funding.dateEnd}"></span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
>>>>>>> 834ff0d546f865f12d767d930f5eaea093c34a41

                            <c:choose>
                                <c:when test="${funding.cancelConfirm eq 'Y'}">
                                    <td>취소됨</td>
                                    <td>${funding.canceledAt}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <button type="button" id="cancelFunding_${funding.fundingId}"
                                            onclick="cancelFunding(${funding.fundingId}, ${funding.rewardPoint * funding.rewardQuantity})"
                                            <c:if test="${funding.isClosed eq 'Y'}">disabled</c:if>>
                                            펀딩 취소</button>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <p>펀딩 구매 내역이 없습니다.</p>
            </c:otherwise>
        </c:choose>

    </section>
</body>

</html>
