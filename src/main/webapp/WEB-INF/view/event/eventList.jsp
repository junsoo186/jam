
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="/css/eventList.css"> 

<div class="container mt-5">
    <h2>eventPage</h2>
	<button type="submit" class="btn btn-danger" onclick="window.location.href='write';">문의 남기기</button>
    <table class="table table-striped mt-3">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>           
                <th>작성자</th>
                <th>작성일</th>
             
            </tr>
        </thead>
        <tbody>
            <c:forEach var="event" items="${eventList}" varStatus="status">
               <a href=""><tr>
                    <td>${status.index + 1}</td>
                    <td><a href="/event/detail/${event.eventId}">${event.eventTitle}</a></td>
                   <!-- 여기서 부터 수정하기  -->
                   
                    <td>${qna.nickname}</td>            
                    <td>${qna.createdAt}</td>
                    <td>
                     <%--    <form action="/notice/delete" method="post" class="d-inline">
                            <input type="hidden" name="staffId" value="${qna.staffId}">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form> --%>
                    </td>
                </tr>
                </a> 
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="bottom--page--area">
    <ul class="pagination">
        <!-- Previous Page Link -->
        <li class="page-item">
            <a class="page-link" href="?type=${type}&page=${currentPage - 1}&size=${size}" <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>><</a>
        </li>

        <!-- Page Numbers -->
        <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="page-item <c:if test='${page == currentPage}'>active</c:if>">
                <a class="page-link" href="?type=${type}&page=${page}&size=${size}" onclick="animateStickEffect(event)">${page}</a>
            </li>
        </c:forEach>

        <!-- Next Page Link -->
        <li class="page-item">
            <a class="page-link" href="?type=${type}&page=${currentPage + 1}&size=${size}" <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>></a>
        </li>
    </ul>
</div>
<script type="text/javascript" src="/js/page.js"></script>