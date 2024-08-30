<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>
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
			<input type="hidden" name="storyId" value="${storyContent.storyId}">
			<button type="submit" id="btnInsert">회차수정</button>
		</form>
	</div>
	<%-- 댓글 이동창은 js로 --%> 
</body>
</html>