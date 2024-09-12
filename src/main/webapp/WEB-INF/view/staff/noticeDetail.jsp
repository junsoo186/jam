
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeDetail.css">

<div class="container p-5">
	<div class="card">
		<div class="card-header">
			<b>게시글 상세보기</b>
		</div>
		<div class="card-body">
			<h3>공지사항 상세</h3>
			<!-- 폼 액션 URL 수정 -->
			<form action="/staff/update/${notice.noticeId}" method="post">
				<div class="mb-3">
					<input type="text" class="form-control" value="${notice.noticeTitle}" name="noticeTitle" required>
				</div>
				<div class="mb-3">
					<textarea class="form-control" rows="5" name="noticeContent" required> ${notice.noticeContent}</textarea>
				</div>
			
			</form>
			<a href="/staff?page=${notice}">돌아가기</a>
			
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/navigation.js"></script>

