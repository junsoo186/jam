<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp" %>
<script type="text/javascript" src="/js/pay/payment.js"></script>
<body>
    <div class="container">
        <h1>결제 및 금융관리</h1>

        <!-- 환불 요청 테이블 -->
        <div class="section">
            <h2>환불 요청</h2>
            <table>
                <thead>
                    <tr>
                        <th>날짜</th>
                        <th>트랜잭션 ID</th>
                        <th>사용자</th>
                        <th>결제유형</th>
                        <th>금액</th>
                        <th>상태</th>
                        <th>상세</th>
                    </tr>
                </thead>
                <tbody id="paymentTableBody">
                    <!-- JavaScript가 데이터를 여기에 렌더링 -->
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 버튼 -->
        <div id="pagination">
            <!-- JavaScript가 페이지 버튼을 동적으로 렌더링 -->
        </div>
    </div>

    <!-- 모달 영역 -->
    <div id="payModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="payModalBody"></div>
        </div>
    </div>

    <!-- JavaScript 파일 불러오기 -->
</body>
</html>
