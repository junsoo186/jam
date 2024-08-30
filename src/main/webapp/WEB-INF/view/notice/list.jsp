
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeList.css">

<div class="container mt-5">
	<h2>공지사항</h2>
	<button type="button" onclick="window.location.href='insertForm';" class="btn btn-insert">글쓰기</button>

	<table class="table table-striped mt-3">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>작업</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${noticeList}">
				<tr>
					<td>${notice.noticeId}</td>
					<td>${notice.noticeTitle}</td>
					<td>${notice.noticeContent}</td>
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
							<button type="submit">수정</button>
						</form> <script>
							function confirmDelete() {
								var result = confirm("정말로 삭제하시겠습니까?");

								if (result) {
									document.getElementById('delete').submit(); // 폼 제출
								}
							}
						</script>


					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


