<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	<%-- JS로 화면 클릭시 댓글창 열기, 제목, 회차 넘버링 표시, 좋아요 버튼표시, 홈버튼, 수정버튼(작가면) --%> 
</body>
</html>