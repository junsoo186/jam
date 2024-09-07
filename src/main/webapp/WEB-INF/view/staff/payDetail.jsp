<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>거래 상세 페이지</title>
</head>
<body>

    <div class="container">
        <h1>거래 상세 페이지</h1>

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
                    <td>결제 금액</td>
                    <td>10,000 원</td>
                </tr>
                <tr>
                    <td>결제 수단</td>
                    <td>100코인</td>
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
                    <td>사용자</td>
                    <td>사용자1</td>
                </tr>
                <tr>
                    <td>금액(코인)</td>
                    <td>100코인</td>
                </tr>
                <tr>
                    <td>결제 방법</td>
                    <td>신용카드</td>
                </tr>
                <tr>
                    <td>결제 금액</td>
                    <td>10,000 원</td>
                </tr>
                <tr>
                    <td>상태</td>
                    <td>환불 대기</td>
                </tr>
            </table>
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
                    <td>환불 금액</td>
                    <td>10,000 원</td>
                </tr>
                <tr>
                    <td>환불 수단</td>
                    <td>신용카드</td>
                </tr>
                <tr>
                    <td>환불 설명</td>
                    <td>단순 변심</td>
                </tr>
            </table>
            <button onclick="completeRefund()">환불 완료</button>
        </div>

        <!-- 결제 방법 및 승인 -->
        <div class="box">
            <h2>결제 방법 및 승인</h2>
            <table>
                <tr>
                    <th>결제 방법</th>
                    <th>결제 상세</th>
                    <th>승인</th>
                </tr>
                <tr>
                    <td>신용카드</td>
                    <td>1***-7***-****-*****</td>
                    <td>결제 승인</td>
                </tr>
                <tr>
                    <td>신용카드</td>
                    <td>1***-7***-****-*****</td>
                    <td>환불 요청</td>
                </tr>
            </table>
            <button onclick="updateStatus()">상태 업데이트</button>
        </div>
    </div>

</body>
</html>
