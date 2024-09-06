<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				        <form id="eventForm">
				            <label for="event-title">이벤트 제목:</label>
				            <input type="text" id="event-title" name="event-title" placeholder="이벤트 제목을 입력하세요">
				
				            <label for="event-description">이벤트 설명:</label>
				            <textarea id="event-description" name="event-description" rows="5" placeholder="이벤트 설명을 입력하세요"></textarea>
				
				            <label for="start-date">시작 날짜:</label>
				            <input type="date" id="start-date" name="start-date">
				
				            <label for="end-date">종료 날짜:</label>
				            <input type="date" id="end-date" name="end-date">
				
				            <button type="submit">이벤트 등록</button>
				        </form>
				    </div>
				</div>


        <h2>등록된 이벤트 목록</h2>
        <table>
            <thead>
                <tr>
                    <th>이벤트 번호</th>
                    <th>제목</th>
                    <th>기간</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <!-- 이벤트 리스트 반복 -->
            </tbody>
        </table>
    </div>

</body>
</html>
