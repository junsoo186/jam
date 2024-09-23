<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
						<a href="/staffEvent/write" class="btn btn-primary">이벤트 등록</a>

						<h2>등록된 이벤트 목록</h2>
						<table class="table">
							<thead>
								<tr>
									<th>이벤트 기간</th>
									<th>작성일</th>
									<th>제목</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="event" items="${eventList}">
									<tr>
										<td>${event.startDay} - ${event.endDay}</td>
										<td>
											<fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd" />
										</td>
										<td><a href="/staffEvent/detail/${event.eventId}">${event.eventTitle}</a></td>
										<td>
											<button class="btn btn-sm btn-edit" data-id="${event.eventId}">수정</button>
											<button class="btn btn-sm btn-delete" data-id="${event.eventId}">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 기존 삭제 모달 -->
					<div id="deleteEventModal" class="modal" style="display: none;">
						<div class="modal-content">
							<span class="close">&times;</span>
							<h2>이벤트 삭제</h2>
							<p>정말로 이 이벤트를 삭제하시겠습니까?</p>
							<button id="confirmDeleteBtn">삭제</button>
							<button class="close">취소</button>
						</div>
					</div>

					<!-- 수정 모달 -->
					<div id="eventModal" class="modal" style="display: none;">
						<div class="modal-content">
							<span class="close">&times;</span>
							<div id="modalBody">
								<!-- 외부 JSP 파일이 동적으로 여기에 로드됩니다. -->
							</div>
						</div>
					</div>

					<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
					<script src="/js/staff/event.js"></script>
				</body>

			</html>