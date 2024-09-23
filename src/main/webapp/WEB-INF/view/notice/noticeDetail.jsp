<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/qnaDetail.css">

<main>
	<div class="container p-5">
		<div class="card">
			<div class="card-header">
				<b>공지사항</b>
			</div>
			<div class="the-title"> ${notice.noticeTitle}</div>
			
			<div class="content">내용: ${notice.noticeContent}</div>
			<div class="date">작성일: ${notice.createdAt}</div>


			<form action="/notice/list" method="get"
				class="d-inline">
				<button type="submit" class="btn btn-primary form-control">뒤로가기</button>
			</form>




		</div>
	</div>
</main>