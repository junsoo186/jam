
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/writeNotice.css">
<div class="container p-5">
	<div class="card">


		<div class="card-header">
			<h2>공지사항 글쓰기</h2>
		</div>
		<div class="card-body">

			<form action="/staff/insert" method="post">
				<div class="mb-3">

					<input type="text" value="${noticeList.noticeTitle}" name="noticeTitle" required>
				</div>
				<div class="mb-3">

					<textarea name="noticeContent" rows="5" required>${noticeList.noticeContent}</textarea>
					<div class="mb-3">

						<button type="submit">글쓰기</button>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/navigation.js"></script>

