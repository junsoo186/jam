<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- /WEB-INF/views/event.jsp -->
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp" %>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객지원 이벤트</title>
<link rel="stylesheet" href="/css/staff.css">

</head>
<body>



	<div class="main-content">
		<h1>고객지원 이벤트 관리</h1>
		<!-- 이벤트 등록 버튼 -->
		<a href="staffEvent/write">이벤트 등록</a>

		<h2>등록된 이벤트 목록</h2>
		<table>
			<thead>
				<tr>
					<th>이벤트기간</th>
					<th>작성일</th>
					<th>제목</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="event" items="${eventList}">
					<tr>
						<td>${event.startDay}-${event.endDay}</td>
						<td>${event.endDay}</td>
						<td><a href="/staffEvent/detail/${event.eventId}">${event.eventTitle}</a></td>
						<td>
						<td><a href="/staffEvent/update/${event.eventId}">
								<button>수정</button>
						</a>
						<td><a href="/staffEvent/delete/${event.eventId}">
								<button>삭제</button>
						</a></td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>