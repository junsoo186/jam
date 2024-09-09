<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>후원금 상세 페이지</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

    <div class="container">
        <h1>후원금 상세 페이지</h1>

        <!-- 결제 내역 -->
        <div class="box">
            <h2>결제 내역</h2>
            <table>
                <tr>
                    <th>항목</th>
                    <th>세부 사항</th>
                </tr>
                <tr>
                    <td>날짜</td>
                    <td>2024-08-25 14:30</td>
                </tr>
                <tr>
                    <td>트랜젝션 ID</td>
                    <td>TXN123456789</td>
                </tr>
                <tr>
                    <td>후원 코인</td>
                    <td>50 코인</td>
                </tr>
            </table>
            <button onclick="requestPayment()">결제 요청</button>
        </div>

        <!-- 세부 사항 -->
        <div class="box">
            <h2>세부 사항</h2>
            <table>
                <tr>
                    <th>항목</th>
                    <th>세부 사항</th>
                </tr>
                <tr>
                    <td>날짜</td>
                    <td>2024-08-25 14:30</td>
                </tr>
                <tr>
                    <td>트랜젝션 ID</td>
                    <td>TXN123456789</td>
                </tr>
                <tr>
                    <td>후원자</td>
                    <td>사용자1</td>
                </tr>
                <tr>
                    <td>후원 코인</td>
                    <td>50코인</td>
                </tr>
                <tr>
                    <td>펀딩 프로젝트</td>
                    <td>영기금 문작부 매장 S2</td>
                </tr>
                <tr>
                    <td>상태</td>
                    <td>환불 대기</td>
                </tr>
            </table>
            <button onclick="updateStatus()">상태 업데이트</button>
        </div>

        <!-- 환불 내역 -->
        <div class="box">
            <h2>환불 내역</h2>
            <table>
                <tr>
                    <th>항목</th>
                    <th>세부 사항</th>
                </tr>
                <tr>
                    <td>날짜</td>
                    <td>2024-08-25 14:30</td>
                </tr>
                <tr>
                    <td>환불 요청 코인</td>
                    <td>50 코인</td>
                </tr>
                <tr>
                    <td>환불 코인</td>
                    <td>45 코인</td>
                </tr>
                <tr>
                    <td>수수료</td>
                    <td>5 코인</td>
                </tr>
                <tr>
                    <td>환불 사유</td>
                    <td>단순 변심</td>
                </tr>
            </table>
            <button onclick="completeRefund()">환불 완료</button>
        </div>
    </div>

</body>
</html>
