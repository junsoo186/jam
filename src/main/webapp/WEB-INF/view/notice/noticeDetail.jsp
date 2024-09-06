<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/noticeInsert.css">

<main>
	<div class="container p-5">
		<div class="card">
			<div class="card-header">
				<b>공지사항</b>
			</div>
			<div class="mb-3">제목: ${notice.noticeTitle}</div>
			<div class="mb-3">작성자: ${notice.staffId}</div>
			<div class="mb-3">내용: ${notice.noticeContent}</div>
			<div class="mb-3">작성일: ${notice.createdAt}</div>

			<!-- 버튼 부분  -->
			<form action="/notice/delete" method="post" class="d-inline">
				<input type="hidden" name="noticeId" value="${notice.noticeId}">
				<button type="submit" class="btn btn-primary form-control">삭제</button>
			</form>



			<form action="/notice/update/${notice.noticeId}" method="get"
				class="d-inline">
				<input type="hidden" name="qnoticeId" value="${notice.noticeId}">
				<button type="submit" class="btn btn-primary form-control">수정</button>
			</form>




		</div>
	</div>
</main>