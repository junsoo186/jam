<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/noticeInsert.css"> 

	<div class="container p-5">
    <div class="card">
       <div class="card-header"><b>상세보기 남기기</b></div>
              <div class="mb-3">제목: ${qna.title}</div>
              <div class="mb-3">작성자: ${qna.nickname}</div>
              <div class="mb-3">내용: ${qna.questionContent}</div>
              <div class="mb-3">작성일: ${qna.createdAt}</div>
         <c:choose>
         	<c:when test="${qna.answerContent != null}">
         	<div class="mb-3">답변: ${qna.answerContent}</div>
         	</c:when>
         	<c:otherwise>
         	<div class="mb-3">답변: 아직 답변이 없습니다.</div>
         	</c:otherwise>
         </c:choose>
          
   
                   
                        <form action="/notice/delete" method="post" class="d-inline">
                            <input type="hidden" name="qnaId" value="${qna.qnaId}">
                            <button type="submit" class="btn btn-primary form-control">삭제</button>
                        </form>
                        
                  
                   
    </div>
	</div>
