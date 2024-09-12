<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/eventList.css">

<div class="container mt--5">
    <h2>이벤트 관리</h2>
    <button type="submit" class="btn btn--primary"
        onclick="window.location.href='write';">이벤트 추가</button>
    <table class="table table--striped mt--3">
        <thead>
            <tr>
                <th>등록일</th>
                <th>마감일</th>
                <th>내용</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="event" items="${eventList}" varStatus="status">
                <tr>
                
                 <a href=""><tr>
                        <td>${event.startDay}</td>
                        <td>${event.endDay}</td>
                        <td><a href="/event/detail/${event.eventId}">${event.eventContent}</a></td>
                    <td>
                        <button class="btn btn--primary" onclick="window.location.href='/event/updateE/${event.eventId}'">수정</button>
                        <button class="btn btn--info" onclick="window.location.href='/event/deleteE/${event.eventId}'">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="bottom--page--area">
    <ul class="pagination">
        <!-- 이전 페이지 링크 -->
        <li class="page--item"><a class="page--link"
            href="?type=${type}&page=${currentPage - 1}&size=${size}"
            <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>><</a>
        </li>

        <!-- 페이지 번호 -->
        <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="page--item <c:if test='${page == currentPage}'>active</c:if>">
                <a class="page--link" href="?type=${type}&page=${page}&size=${size}"
                   onclick="animateStickEffect(event)">${page}</a>
            </li>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <li class="page--item"><a class="page--link"
            href="?type=${type}&page=${currentPage + 1}&size=${size}"
            <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>></a>
        </li>
    </ul>
</div>

<script type="text/javascript" src="/js/page.js"></script>
