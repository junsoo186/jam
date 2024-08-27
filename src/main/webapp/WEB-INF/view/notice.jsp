<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*, com.jam.repository.model.Notice, com.jam.repository.interfaces.NoticeRepository" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>공지사항</h1>

    <!-- 공지사항 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성자 ID</th>
                <th>작성일</th>
                <th>액션</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td><c:out value="${notice.noticeId}" /></td>
                    <td><c:out value="${notice.noticeTitle}" /></td>
                    <td><c:out value="${notice.noticeContent}" /></td>
                    <td><c:out value="${notice.staffId}" /></td>
                    <td><fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <form action="updateNotice.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="noticeId" value="${notice.noticeId}" />
                            <input type="submit" value="수정" />
                        </form>
                        <form action="deleteNotice.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="noticeId" value="${notice.noticeId}" />
                            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');"/>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 새로운 공지사항 작성 폼 -->
    <h2>새로운 공지사항 추가</h2>
    <form action="insertNotice.jsp" method="post">
        <label for="staffId">작성자 ID:</label><br>
        <input type="text" id="staffId" name="staffId" required><br><br>
        <label for="noticeTitle">제목:</label><br>
        <input type="text" id="noticeTitle" name="noticeTitle" required><br><br>
        <label for="noticeContent">내용:</label><br>
        <textarea id="noticeContent" name="noticeContent" rows="4" cols="50" required></textarea><br><br>
        <input type="submit" value="추가">
    </form>

</body>
</html>
