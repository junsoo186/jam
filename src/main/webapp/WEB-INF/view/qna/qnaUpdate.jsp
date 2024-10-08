<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="/css/qnaWrite.css">

<div class="container p-5">
    <div class="card">
        <div class="card-header"><b>질문 수정</b></div>
        <div class="card-body">
            <!-- 폼 액션 URL 수정 -->
            <form action="/qna/update" method="post">
              <input type="hidden" name="qnaId" value="${qna.qnaId}">
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="${qna.title}" name="title" required>
                </div>
                <div class="mb-3">
                    <textarea class="form-control" rows="5"  placeholder="${qna.questionContent}" name="questionContent"  required></textarea>
                </div>
                <button type="submit" class="btn btn-primary form-control">등록</button>
            </form>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp" %>