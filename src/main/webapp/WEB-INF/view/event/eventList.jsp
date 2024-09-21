<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/eventList.css">
<%@ page import="java.time.LocalDate"%>

<% 
    // 현재 날짜 가져오기
    LocalDate currentDate = LocalDate.now();
    request.setAttribute("currentDate", currentDate);
%>
<div class="container mt--5">
    <!-- 타이틀과 버튼을 배치 -->
    <div class="title--box">
        <h2>이벤트</h2>
        <button class="btn-filter" id="btn-active-events" onclick="filterEvents('active')">진행중인 이벤트</button>
        <button class="btn-filter" id="btn-ended-events" onclick="filterEvents('ended')">마감된 이벤트</button>
    </div>
    
    <div class="event-items">
        <c:forEach var="event" items="${eventList}" varStatus="status">
            <c:choose>
                <c:when test="${event.endDay >= currentDate}">
                    <div class="event-item active-event">
                        <img class="thumbnail-image" src="/images/${event.eventImage}" alt="${event.eventTitle}">
                        <div class="event-info">
                            <h3>${event.eventTitle}</h3>
                            <p>등록일: ${event.startDay}</p>
                            <p class="endDay">마감일: ${event.endDay}</p>
                            <a href="/event/detail/${event.eventId}" class="btn-detail">자세히 보기</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="event-item ended-event">
                        <img class="thumbnail-image" src="/images/${event.eventImage}" alt="${event.eventTitle}">
                        <div class="event-info">
                            <h3>${event.eventTitle}</h3>
                            <p>등록일: ${event.startDay}</p>
                            <p class="endDay">마감일: ${event.endDay}</p>
                            <a href="/event/detail/${event.eventId}" class="btn-detail">자세히 보기</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>

<div class="bottom--page--area">
    <ul class="pagination">
        <!-- 이전 페이지 링크 -->
        <li class="page--item">
            <a class="page--link" href="?type=${type}&page=${currentPage - 1}&size=${size}" 
                <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>>이전</a>
        </li>

        <!-- 페이지 번호 -->
        <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="page--item <c:if test='${page == currentPage}'>active</c:if>">
                <a class="page--link" href="?type=${type}&page=${page}&size=${size}"
                   onclick="animateStickEffect(event)">${page}</a>
            </li>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <li class="page--item">
            <a class="page--link" href="?type=${type}&page=${currentPage + 1}&size=${size}" 
                <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>다음</a>
        </li>
    </ul>
</div>

<script type="text/javascript" src="/js/page.js"></script>

<script>
    // 필터 기능
    function filterEvents(type) {
        const activeEvents = document.querySelectorAll('.active-event');
        const endedEvents = document.querySelectorAll('.ended-event');
        
        if (type === 'active') {
            activeEvents.forEach(event => event.style.display = 'block');
            endedEvents.forEach(event => event.style.display = 'none');
        } else if (type === 'ended') {
            activeEvents.forEach(event => event.style.display = 'none');
            endedEvents.forEach(event => event.style.display = 'block');
        }
    }
</script>
