<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 관리</title>
<link rel="stylesheet" href="/css/staff.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 외부 스타일시트 연결 -->
</head>
<body>


	<h2>공지사항 페이지</h2>
	
	
	<a href="/staff/insert">글쓰기</a>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>등록일</th>
				<th></th>
				<th></th>


			</tr>
		</thead>

		<tbody>
			<!-- noticeList를 반복하여 테이블에 출력 -->
			<c:forEach items="${noticeList}" var="notice">
				<tr>
					<td>${notice.noticeId}</td>
					<td>${notice.noticeTitle}</td>
					<td>${notice.noticeContent}</td>
					<td>${notice.staffId}</td>
					<td>${notice.createdAt}</td>
					<td><a href="/staff/update/${notice.noticeId}">
							<button>수정</button></a>
					<td><a href="/staff/delete/${notice.noticeId}">
					<button>삭제</button></a></td>




				</tr>



			</c:forEach>
		</tbody>
	</table>
	
	

	<script type="text/javascript" src="/js/navigation.js"></script>


</body>
</html>
