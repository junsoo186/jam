
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeList.css">
<link rel="stylesheet" href="/css/layout/page.css">

<div class="container mt-5">
	<h2>공지사항</h2>

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
			    <c:forEach var="notice" items="${noticeList}" varStatus="status">
			        <tr style="${notice.noticeId%2== 1 ? '' : 'background-color: #dddddd4d;'}">
			            <td>${(currentPage -1)*size + status.index + 1}</td>
			            <td><a href="/notice/detail/${notice.noticeId}">${notice.noticeTitle}</a></td>
			            <td>${notice.nickName}</td>
			            <td>${notice.createdAt}</td>
			        </tr>
			    </c:forEach>
			</tbody>
	</table>
	<div class="bottom--page--area">
		<ul class="pagination" style="display: flex;">
			<!-- Previous Page Link -->
			<li class="page-item"><a class="page-link"
				href="?type=${type}&page=${currentPage - 1}&size=${size}"
				<c:if test='${currentPage == 1}'>onclick="return false;"</c:if>><</a>
			</li>

			<!-- Page Numbers -->
			<c:forEach begin="1" end="${totalPages}" var="page">
				<li
					class="page-item <c:if test='${page == currentPage}'>active</c:if>">
					<a class="page-link" href="?type=${type}&page=${page}&size=${size}"
					onclick="animateStickEffect(event)">${page}</a>
				</li>
			</c:forEach>

			<!-- Next Page Link -->
			<li class="page-item"><a class="page-link"
				href="?type=${type}&page=${currentPage + 1}&size=${size}"
				<c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>></a>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript" src="/js/page.js"></script>
