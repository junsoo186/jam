
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeUpdate.css">

<div class="container p-5">
    <div class="card">
        <div class="card-header"><b>게시글 수정</b></div>
        <div class="card-body">
            <!-- 폼 액션 URL 수정 -->
            <form action="/notice/update/${noticeList.noticeId}" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" value="${noticeList.noticeTitle}" name="noticeTitle"required>
                </div>
               
               
                <div class="mb-3">
                    <textarea class="form-control" rows="5" name="noticeContent" required> ${noticeList.noticeContent}</textarea>
                </div>
                <button type="submit" class="btn btn-primary form-control">수정</button>
            </form>
        </div>
    </div>
</div>
