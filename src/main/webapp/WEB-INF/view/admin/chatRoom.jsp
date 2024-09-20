<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<link rel="stylesheet" href="/css/chat/chat.css">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>관리자 채팅</title>
</head>
<body>
    <h1>관리자 채팅방: ${roomId}</h1>
    
   <div id="messages"></div>
        <div  class= " bottom--sendarea" style="display: flex; align-items: center;">
            <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
            <button onclick="sendMessage()">전송</button>
        </div>

    <script>
    
    const profileImg = '${profileImg}';
    const userId = '${userId}';
    const nickname = '${nickname}'; 
    
</script>
    <script type="text/javascript" src="/js/chat.js"></script>
</body>
</html>