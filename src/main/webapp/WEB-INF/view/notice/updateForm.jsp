
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeUpdate.css">

<div class="container p-5">
    <div class="card">
        <div class="card-header"><b>새글작성</b></div>
        <div class="card-body">
            <!-- 폼 액션 URL 수정 -->
            <form action="/notice/update/${notice.noticeId}" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="제목" name="title" required>
                </div>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="작성자" name="staff_id" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="비밀번호" name="password" required>
                </div>
                <div class="mb-3">
                    <textarea class="form-control" rows="5" name="content" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary form-control" onclick="window.location.href='updateForm';">수정</button>
            </form>
        </div>
    </div>
</div>
