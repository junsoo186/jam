<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Core 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Core 라이브러리 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% // 바디 상단의 작품 등록 버튼 %>
	<div class="btn-area">
		<form action="workInsert" method="get">
			<button type="submit" id="btnInsert">신규 작품 등록</button>
		</form>
	</div>
	
<%-- 작품 확인 중단 바디 --%>
<%-- 조건절 1: bookList가 null이 아닐 때 --%>
<c:choose>
    <c:when test="${bookList != null}">
        <%-- bookList가 존재할 때 --%>
        <div style="border: 1px solid black">
            <%-- 반복문 시작: bookList의 각 항목에 대해 --%>
            <c:forEach var="list" items="${bookList}">
                <%-- 조건절 2: 유저가 작가일 때 자기 작품과 대조 --%>
                <c:choose>
                    <c:when test="${list.userId == 1}">
                    <%-- js를 이용해서 영역 자체를 클릭시 이동으로 할예정 --%>
                        <div class="item-container">
                            ${list.userId} 작가의 작품 <br>
                            <a href="/write/workDetail?bookId=${list.bookId}">${list.title}</a>, ${list.author} <br>
                            ${list.authorComment} <br>
                            ${list.likes} <br>
                            <%-- 태그 목록 출력 --%>
                            <c:forEach var="tag" items="${list.tagNames}">
                                ${tag}
                            </c:forEach>
                        </div>

                        <div class="btn-area">
                            <form action="storyInsert" method="get">
                                <button type="submit" id="btnInsert">회차 등록</button>
                            </form>
                        </div>
                        <%-- 조건절 2 끝 --%>
                    </c:when>
                    <%-- 조건절 2가 아닐 때: 빈 처리로 아무것도 표시하지 않음 --%>
                    <c:otherwise>
                        <!-- 빈 영역: 아무것도 표시되지 않음 -->
                    </c:otherwise>
                    <%-- 조건절 2 끝 --%>
                </c:choose>
            </c:forEach>
        </div>
    </c:when>
    <%-- 조건절 1 끝 --%>
</c:choose>



	<script>
		
	</script>
</body>
</html>