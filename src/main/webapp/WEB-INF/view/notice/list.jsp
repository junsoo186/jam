
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="/css/noticeList.css"> 

<div class="container mt-5">
    <h2>공지사항</h2>

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
                        <form action="/notice/delete" method="post" class="d-inline">
                            <input type="hidden" name="staffId" value="${notice.staffId}">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
