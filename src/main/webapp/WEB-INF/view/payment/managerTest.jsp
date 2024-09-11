<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    /* 기본 스타일 */
    body {
        font-family: Arial, sans-serif;
        background-color: #fddede; /* 페이지 배경색 */
        margin: 0;
        padding: 0;
    }

    /* 상단 제목 스타일 */
    h1 {
        text-align: left;
        padding-left: 20px;
        padding-top: 20px;
        font-size: 24px;
        color: #333;
    }

    /* 테이블 컨테이너 */
    .table--container {
        margin: 20px;
        background-color: white;
        border-radius: 8px;
        padding: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* 탭 메뉴 스타일 */
    .tab--menu {
        display: flex;
        background-color: #ff4d6d;
        border-radius: 8px 8px 0 0;
    }

    .tab--menu button {
        background-color: #ff4d6d;
        border: none;
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }

    .tab--menu button.active {
        background-color: white;
        color: #ff4d6d;
        font-weight: bold;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th, td {
        padding: 12px;
        border: 1px solid #ddd;
    }

    th {
        background-color: #666;
        color: white;
        font-weight: bold;
    }

    td {
        color: #333;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    /* 정렬 버튼 스타일 */
    .top--btn {
        float: right;
        margin: 10px;
    }

    .top--btn button {
        padding: 8px 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .top--btn button:hover {
        background-color: #0056b3;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        table {
            font-size: 14px;
        }

        .tab--menu button {
            font-size: 14px;
        }

        .top--btn button {
            font-size: 14px;
            padding: 6px 10px;
        }
    }
</style>

</head>
<body>

<p>여기에 결제 리스트 내역 </p>
	
<c:if test="${not empty payList}">
	<table border="1">
		<tr>
			<th>결제 번호</th>
			<th>유저 번호</th>
			<th>환불 금액</th>
			<th>결제 날짜</th>
			<th>사유</th>
			<th>상태</th>
			<th>처리 날짜</th>
			<th></th>
			<th>유무</th>
		</tr>
		<c:forEach var="payment" items="${payList}">
		    <tr>
		        <td>${payment.refundId}</td> <!-- 주문 번호 출력 -->
		        <td>${payment.userId}</td>  <!-- 결제 금액 출력 -->
		        <td>${payment.refundAmount}원</td> <!-- 결제 날짜 출력 -->
		    	<td>${payment.createdAt}</td>
		    	<td>${payment.refundReason}</td> <!-- 결제 히든키 출력 -->
		    	<td>${payment.status}</td> 
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
