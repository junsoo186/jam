<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/noticeInsert.css">

<div class="container mt-5">
    <h2>상세보기</h2>
    <table class="table table-striped mt-3">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>           
                <th>작성자</th>
                <th>작성일</th>
             
            </tr>
        </thead>
        <tbody>
            <c:forEach var="qna" items="${qnaList}">
               <a href=""><tr>
                    <td>${qna.qnaId}</td>
                    <td><a href="/qna/detail/${qna.qnaId}}"><${qna.title}</a></td>
                    <td>${qna.nickname}</td>            
                    <td>${qna.createdAt}</td>
                    <td>
                     <%--    <form action="/notice/delete" method="post" class="d-inline">
                            <input type="hidden" name="staffId" value="${qna.staffId}">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form> --%>
                    </td>
                </tr>
                </a> 
            </c:forEach>
        </tbody>
    </table>
</div>
