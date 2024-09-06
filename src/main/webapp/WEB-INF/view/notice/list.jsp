
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeList.css">

<div class="container mt-5">
	<h2>공지사항</h2>
	<button type="button" onclick="window.location.href='insertForm';"
		class="btn btn-insert">글쓰기</button>

	<table class="table table-striped mt-3">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>작업</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${noticeList}" varStatus="status">
				<tr>
					<td>${status.index +1}</td>
					<td><a href="/notice/detail/S{notice.noticeId}">${notice.noticeTitle}</a></td>
					<td>${notice.staffId}</td>
					<td>${notice.createdAt}</td>
					<td>
						<form id="delete" method="post" action="/notice/delete">
							<input type="hidden" name="noticeId" value="${notice.noticeId}">
							<!-- 실제 noticeId 값을 여기에 설정해야 합니다 -->
							<input type="hidden" name="action" value="delete">
							<button type="button" onclick="confirmDelete()">삭제</button>
							<!-- onclick 이벤트 핸들러 추가 -->
						</form>

						<form id="update" method="post" action="/update">
							<input type="hidden" name="noticeId" value="${notice.noticeId}">
							<!-- 실제 noticeId 값을 여기에 설정해야 합니다 -->
							<input type="hidden" name="action" value="update">
							<button type="button"
								onclick="window.location.href='updateForm';">수정</button>
						</form>

					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="bottom--page--area">
							<ul class="pagination">
								<!-- Previous Page Link -->
								<li class="page-item"><a class="page-link"
									href="?type=${type}&page=${currentPage - 1}&size=${size}"
									<c:if test='${currentPage == 1}'>onclick="return false;"</c:if>><</a>
								</li>

								<!-- Page Numbers -->
								<c:forEach begin="1" end="${totalPages}" var="page">
									<li
										class="page-item <c:if test='${page == currentPage}'>active</c:if>">
										<a class="page-link"
										href="?type=${type}&page=${page}&size=${size}"
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

