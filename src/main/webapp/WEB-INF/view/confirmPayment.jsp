<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="paymentModal" class="modal">
    <div class="modal-content">
      <h3>결제 확인</h3>
      <p>이야기를 열람하려면 <%=cost%> 포인트가 차감됩니다. 결제하시겠습니까?</p>
      <button id="confirmPaymentBtn">결제하기</button>
      <button id="cancelPaymentBtn">취소</button>
    </div>
  </div>
  <script>
    document.getElementById('confirmPaymentBtn').addEventListener('click', function() {
        // 결제 확인 시 서버로 결제 요청
        window.location.href = "/write/processPayment?storyId=<%=storyContent.getId()%>&cost=<%=cost%>";
    });
    
    document.getElementById('cancelPaymentBtn').addEventListener('click', function() {
        // 취소 시 메인 페이지로 이동
        window.location.href = "/main";
    });
    </script>