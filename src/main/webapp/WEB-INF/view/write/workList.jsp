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
	
	<%// 바디 중단 작품 확인하기
	// 조건절1 생성
	%>
	<c:choose>
		<c:when test="${bookList != null}">
	<%// 받아온 list가 존재할때 %>
		<div style="border: 1px solid black">
	<%// 반복문 생성 %>
				<c:forEach var="list" items="${bookList}">
	<%// 조건절 2 유저가 작가일때 자기 작품 대조%>
				<c:choose>
					<c:when test="${list.userId == 1}">
						<div class="item-container">
							${list.userId}작가의 작품 <br>
							${list.title}, ${list.author} <br> ${list.authorComment} <br> ${list.likes} <br>
							<c:forEach var="tag" items="${list.tagNames}">
                            ${tag}
                        </c:forEach>
						</div>
	<%//  %>
						<div class="btn-area">
							<form action="storyInsert" method="get">
								<input type="hidden" name="bookId" value="${list.bookId}">
								<button type="submit" id="btnInsert">회차 등록</button>
							</form>
						</div>
					</c:when>
				<c:otherwise>
                
            	</c:otherwise>
			</c:choose>
				</c:forEach>
		</div>
		</c:when>
		<c:otherwise>
			<div class="item-container">작품 없음.</div>
		</c:otherwise>
	</c:choose>


	<script>
		
	</script>
</body>
</html>