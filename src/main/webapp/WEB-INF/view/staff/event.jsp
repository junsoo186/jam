<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- /WEB-INF/views/event.jsp -->
<!DOCTYPE html>
<html lang="ko">
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
		<button id="openEventModal" class="left--modal--btn">이벤트 등록</button>

		<!-- 모달 구조 -->
		<div id="eventModal" class="modal" style="display: none;">
			<div class="modal-content">
				<span class="close">&times;</span>
				<h3>이벤트 등록</h3>
				<form id="eventForm" action="/staffEvent/write" method="post">
					<label for="event-title">이벤트 제목:</label> <input type="text"
						id="event-title" name="eventTitle" placeholder="이벤트 제목을 입력하세요">

					<label for="event-description">이벤트 설명:</label>
					<textarea id="event-description" name="eventContent" rows="5"
						placeholder="이벤트 설명을 입력하세요"></textarea>

					<label for="start-day">시작 날짜:</label> <input type="date"
						id="start-day" name="startDay"> <label for="end-day">종료
						날짜:</label> <input type="date" id="end-day" name="endDay">

					<button type="submit">이벤트 등록</button>
				</form>
			</div>
		</div>


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
						<td>${event.startDay}- ${event.endDay}</td>
						<td>${event.endDay}</td>
						<td><a href="/staff/eventDetail/${event.eventId}">${event.eventContent}</a></td>
						<td>
							<button class="btn btn--primary"
								onclick="window.location.href='/event/eventUpdate/${event.eventId}">수정</button>
							<button class="btn btn--info"
								onclick="window.location.href='/event/eventDelete/${event.eventId}">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>