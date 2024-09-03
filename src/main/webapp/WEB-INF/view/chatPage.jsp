<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${nickname}님 채팅</title>
</head>
<body>
	
	<section>
		<c:choose>
			<c:when test="${chatRoom.roomId} != null">
			<label><a href="#">${chatRoom.roomname}</a></label>
			</c:when>
			<c:otherwise>
			<label>입장하실 채팅방이 없습니다.</label>
			</c:otherwise>
		</c:choose>
	</section>
	

</body>
</html>