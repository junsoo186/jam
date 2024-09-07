<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<<<<<<< HEAD
<link rel="stylesheet" href="/css/chat/chat.css">
=======
>>>>>>> d807565 (create - chat)
<html>
<head>
<meta charset="UTF-8">
<title>${nickname}님 채팅</title>
<<<<<<< HEAD
<<<<<<< HEAD

</head>
<body>


     <div id="messages"></div>
        <div  class= " bottom--sendarea" style="display: flex; align-items: center;">
            <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
            <button onclick="sendMessage()">전송</button>
        </div>
    </div>
    <script type="text/javascript">
    const profileImg = '${profileImg}';
    const userId = '${userId}';
    const nickname = '${nickname}'; 
    </script>
    <script type="text/javascript" src="/js/chat.js"></script>
=======
</head>
<body>
	<section>
=======
 <style>
        #messages {
            height: 300px;
            border: 1px solid #ccc;
            overflow-y: scroll;
            margin-bottom: 10px;
        }
        #messageInput {
            width: 80%;
        }
    </style>
</head>
<body>
    <div id="messages"></div>
    <input type="text" id="messageInput" placeholder="Type your message here...">
    <button onclick="sendMessage()">Send</button>
	<%-- <section>
>>>>>>> d11dece (update-chat)
		<c:choose>
			<c:when test="${chatRoom.roomId} != null">
			<label><a href="#">${chatRoom.roomname}</a></label>
			</c:when>
			<c:otherwise>
			<label>입장하실 채팅방이 없습니다.</label>
			</c:otherwise>
		</c:choose>
	</section>
	
 --%>
 

<<<<<<< HEAD
>>>>>>> d807565 (create - chat)
</body>
=======
>>>>>>> d11dece (update-chat)
</html>