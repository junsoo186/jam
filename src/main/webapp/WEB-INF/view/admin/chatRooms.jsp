<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="/">메인으로 돌아가기</a>

	<ul>
		<c:forEach var="roomId" items="${roomIds}">
        <li><a href="/admin/chatRoom/${roomId}">방 ${roomId}로 이동</a></li>
    </c:forEach>
	</ul>
	
	
	<script>
    // 사용자 WebSocket 연결 (roomId는 서버에서 전달)
    const ws = new WebSocket(`ws://localhost:8080/ws/chat/${roomId}`);

    ws.onmessage = function(event) {
        const messagesDiv = document.getElementById('messages');
        const messageContainer = document.createElement('div');
        messageContainer.innerHTML = event.data;
        messagesDiv.appendChild(messageContainer);
    };

    function sendMessage() {
        const input = document.getElementById('messageInput');
        const message = input.value.trim();
        if (message) {
            ws.send(message);
            input.value = '';  // 전송 후 입력 필드를 비웁니다.
        }
    }
</script>

</body>
</html>