
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="/css/noticeList.css"> 

<div class="container mt-5">
    <h2>Q&A</h2>
	<button type="submit" class="btn btn-danger" onclick="window.location.href='write';">문의 남기기</button>
    <table class="table table-striped mt-3">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>질문</th>   
                <th>작성자</th>
                <th>작성일</th>
             
            </tr>
        </thead>
        <tbody>
            <c:forEach var="qna" items="${qnaList}">
                <tr>
                    <td>${qna.qnaId}</td>
                    <td>${qna.title}</td>
                    <td>${qna.nickname}</td>
            		 <td>${qna.questionContent}</td>
                    <td>${qna.createdAt}</td>
                    <td>
                     <%--    <form action="/notice/delete" method="post" class="d-inline">
                            <input type="hidden" name="staffId" value="${qna.staffId}">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form> --%>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
