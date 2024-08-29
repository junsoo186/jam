
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="/css/noticeList.css"> 

<div class="container mt-5">
    <h2>공지사항</h2>
    <button type="button" onclick="window.location.href='insertForm';" class="btn btn-insert">글쓰기</button>

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
                            <input type="hidden" name="noticeId" value="${notice.noticeId}">
                            <button type="submit" onclick="confirmDelete()" class="btn btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
        // 삭제 버튼 클릭 시 경고 팝업창
        function confirmDelete() {
            var result = confirm("정말로 삭제하시겠습니까?");
            if (result) {
                // 사용자가 "확인" 을 클릭한 경우
                alert("삭제가 완료되었습니다."); 
                //document.getElementById("deleteForm").submit();
            } else {
                // 사용자가 "취소" 를 클릭한 경우
                return
            }
        }
    </script>
