<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/chat/chat.css">
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">


</style> 
<title>${nickname}님 채팅</title>

</head>
<body>
  <h1>채팅방: ${roomId}</h1>
  

     <div id="messages"></div>
        <div  class= " bottom--sendarea" style="display: flex; align-items: center;">
            <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
            <button onclick="sendMessage()">전송</button>
        </div>
  
    <script type="text/javascript">
    
    const profileImg = '${profileImg}'; // 사용자 프로필 이미지 경로
    const userId = '${userId}'; // 현재 사용자 ID
    const nickname = '${nickname}'; // 현재 사용자 닉네임
    const roomId = '${roomId}'; // 현재 채팅방 ID	
   
    </script>
     <script type="text/javascript" src="/js/chat.js"></script>
    
</body>
</html>