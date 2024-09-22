<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/qnaDetail.css">

<main>
<div class="container p-5">
	<div class="card">
		<div class="card-header">
			<b>QnA 상세보기</b>
		</div>
		<div class="the-title"> ${qna.title}</div>
	
		<div class="content"> ${qna.questionContent}</div>
		<div class="date">작성일: ${qna.createdAt}</div>
	
		
		<!-- 버튼 부분  -->
		<form action="/qna/delete" method="post" class="d-inline">
			<input type="hidden" name="qnaId" value="${qna.qnaId}">
			<button type="submit" class="btn btn-primary form-control">삭제</button>
		</form>
		<!-- 답변이 달린 글은 수정 버튼 없음  -->
		<c:choose>
		<c:when test="${qna.answerContent != null}">
		<b></b>
		</c:when>
		<c:otherwise>
		<form action="/qna/updatePage/${qna.qnaId}" method="get" class="d-inline">
			<input type="hidden" name="qnaId" value="${qna.qnaId}">
			<button type="submit" class="btn btn-primary form-control">수정</button>
		</form>
		</c:otherwise>
		</c:choose>

	</div>
	<c:choose>
		<c:when test="${qna.answerContent != null}">
			<div class="answer"> ${qna.answerContent}</div>
		</c:when>
		<c:otherwise>
			<div class="answer"> 아직 답변이 없습니다.</div>
		</c:otherwise>
	</c:choose>
</div>

</main>
<%@ include file="/WEB-INF/view/layout/footer.jsp" %>