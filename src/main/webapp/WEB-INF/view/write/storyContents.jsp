<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Core 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Core 라이브러리 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${storyContent.title}</h1>

	<p>${storyContent.contents}</p>

	<div class="btn-area">
		<form action="workDetail" method="get">
			<input type="hidden" name="bookId" value="${storyContent.bookId}">
			<button type="submit" id="btnInsert">홈</button>
		</form>
	</div>
	<div class="btn-area">
		<form action="storyUpdate " method="get">
			<button type="submit" id="btnInsert">회차수정</button>
		</form>
	</div>
</body>
</html>