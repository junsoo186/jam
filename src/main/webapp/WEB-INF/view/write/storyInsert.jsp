<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>
<body>
    <h1>회차 생성</h1>
    <div class="btn-area">
        <form action="storyInsert" method="post">
            <table>
                <tr>
                    <td>회차 번호:</td>
                    <td><input type="number" id="number" name="number" value="123" /></td>
                </tr>
                <tr>
                    <td>유형:</td>
                    <td>
                        <select id="type" name="type">
                            <option value="prologue" selected>프롤로그</option>
                            <option value="free">무료</option>
                            <option value="paid">유료</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>제목:</td>
                    <td><input type="text" id="title" name="title" value="testTitle" /></td>
                </tr>
                <tr>
                    <td>업로드 날짜:</td>
                    <td><input type="date" id="uploadDay" name="uploadDay" value="2024-01-01" /></td>
                </tr>
                <tr>
                    <td>저장 여부:</td>
                    <td><input type="checkbox" id="save" name="save" checked /></td>
                </tr>
                <tr>
                    <td>비용:</td>
                    <td><input type="number" id="cost" name="cost" value="1000" /></td>
                </tr>
                <tr>
                    <td>내용:</td>
                    <td><textarea id="contents" name="contents">testContents</textarea></td>
                </tr>
            </table>
            <input type="hidden" name="bookId" value="1">
            <button type="submit" id="btnInsert">회차 등록</button>
        </form>
    </div>
</body>
</html>
