<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<link rel="stylesheet" href="/css/chat/chat.css">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>관리자 채팅</title>
    <a href="/admin/chatRooms">채팅방 나가기</a>
</head>
<body>
    
    
   <div id="messages"></div>
        <div  class= " bottom--sendarea" style="display: flex; align-items: center;">
            <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
            <button onclick="sendMessage()">전송</button>
        </div>

    <script>
    
    const profileImg = '${profileImg}';  // 사용자 프로필 이미지
    const userId = '${userId}'; // 현재 사용자 ID (관리자)
    const nickname = '${nickname}'; // 현재 사용자 닉네임 (관리자)
    const roomId = '${roomId}'; // 현재 채팅방 ID
    
</script>
    <script type="text/javascript" src="/js/chat.js"></script>
</body>
</html>