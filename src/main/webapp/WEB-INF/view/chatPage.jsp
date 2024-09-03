<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${nickname}님 채팅</title>
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
 

</html>