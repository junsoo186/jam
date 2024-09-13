<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>거래 상세 페이지</title>
        <link rel="stylesheet" href="/css/staff/payDetail.css">
    </head>

    <body>

        <div class="container--top--area">
            <h1 class="title--center--area">거래 상세 페이지</h1>

            <!-- 세부 사항 -->
            <div class="box--content--area">
                <h2 class="title--center--area">세부 사항</h2>
                <table class="table--content--area">
                    <tr>
                        <th>항목</th>
                        <th>세부 사항</th>
                    </tr>
                    <tr>
                        <td>날짜</td>
                        <td>${refund.createdAt}</td>
                    </tr>
                    <tr>
                        <td>트랜젝션 ID</td>
                        <td>${refund.paymentKey}</td>
                    </tr>
                    <tr>
                        <td>사용자</td>
                        <td>${refund.email}</td>
                    </tr>
                    <tr>
                        <td>금액(코인)</td>
                        <td>${refund.refundAmount}</td>
                    </tr>
                    <tr>
                        <td>결제 방법</td>
                        <td>신용카드</td>
                    </tr>
                    <tr>
                        <td>상태</td>
                        <td>${refund.status}</td>
                    </tr>
                </table>
            </div>

            <!-- 환불 내역 -->
            <div class="box--content--area">
                <h2 class="title--center--area">환불 내역</h2>
                <table class="table--content--area">
                    <tr>
                        <th>항목</th>
                        <th>세부 사항</th>
                    </tr>
                    <tr>
                        <td>날짜</td>
                        <td>${refund.createdAt}</td>
                    </tr>
                    <tr>
                        <td>환불 금액</td>
                        <td>${refund.refundAmount}</td>
                    </tr>
                    <tr>
                        <td>환불 수단</td>
                        <td>신용카드</td>
                    </tr>
                    <tr>
                        <td>환불 설명</td>
                        <td>${refund.refundReason}</td>
                    </tr>
                </table>
                <div style="display: flex;">
                    <form action="/pay/reques" method="post">
                        <input type="hidden" name="paymentKey" value="${refund.paymentKey}">
                        <input type="hidden" name="refundAmount" value="${refund.refundAmount}">
                        <input type="hidden" name="refundReason" value="${refund.refundReason}">
                        <input type="hidden" name="userId" value="${refund.userId}">
                        <button type="submit" class="btn--refund--action" onclick="completeRefund()">환불 승인</button>
                    </form>
                    <form action="/pay/requesrefusal" method="post">
                        <input type="hidden" name="paymentKey" value="${refund.paymentKey}">
                        <input type="hidden" name="refundAmount" value="${refund.refundAmount}">
                        <input type="hidden" name="refundReason" value="${refund.refundReason}">
                        <input type="hidden" name="userId" value="${refund.userId}">
                        <button type="submit" class="btn--refund--action" onclick="completeRefund()">환불 거절</button>
                    </form>
                </div>
            </div>
        </div>

    </body>

    </html>