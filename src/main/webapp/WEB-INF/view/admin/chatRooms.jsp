<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<ul>
		<c:forEach var="roomId" items="${roomIds}">
        <li><a href="/admin/chatRoom/${roomId}">방 ${roomId}로 이동</a></li>
    </c:forEach>
	</ul>
	
	
	<script>
/*  
    // WebSocket 연결 설정 (JavaScript 사용)
    // roomId는 서버에서 제공된 방 ID로 대체되어야 함
    // `ws://localhost:8080/ws/chat/${roomId}` 경로로 WebSocket 연결 생성
    
    const ws = new WebSocket(`ws://localhost:8080/ws/chat/${roomId}`);
	
 	// 서버로부터 메시지를 수신할 때마다 호출됨
    ws.onmessage = function(event) {
        const messagesDiv = document.getElementById('messages'); // 메시지를 출력할 div 요소
        const messageContainer = document.createElement('div'); // 새로운 메시지를 담을 div 생성
        messageContainer.innerHTML = event.data; // 서버에서 받은 메시지를 HTML로 추가
        messagesDiv.appendChild(messageContainer); // 메시지를 화면에 추가 
    };
	
    // 메시지를 전송하는 함수
    function sendMessage() {
        const input = document.getElementById('messageInput'); // 메시지를 입력하는 input 필드
        const message = input.value.trim(); // 입력된 메시지를 가져와 앞뒤 공백을 제거
        if (message) { // 메시지가 비어 있지 않으면
            ws.send(message);
            input.value = '';  // 전송 후 입력 필드를 비웁니다.
        }
    }
 */	 
</script>

</body>
</html>