<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Core 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Core 라이브러리 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>책 상세페이지</h1>
	<div class="novel-details">
		<p>
			<strong>제목:</strong> ${bookDetail.title}
		</p>
		<p>
			<strong>작가:</strong> ${bookDetail.author}
		</p>
		<p>
			<strong>작가 코멘트:</strong> ${bookDetail.authorComment}
		</p>
		<p>
			<strong>소개:</strong> ${bookDetail.introduction}
		</p>

		<%-- 
	join 시 사용
        <!-- 카테고리 출력 -->
        <p><strong>카테고리:</strong> 
            <c:forEach var="category" items="${bookDetail.categoryNames}">
                ${category} 
            </c:forEach>
        </p>

        <!-- 장르 출력 -->
        <p><strong>장르:</strong> 
            <c:forEach var="genre" items="${bookDetail.genreNames}">
                ${genre} 
            </c:forEach>
        </p>

        <!-- 태그 출력 -->
        <p><strong>태그:</strong> 
            <c:forEach var="tag" items="${bookDetail.tagNames}">
                ${tag} 
            </c:forEach>
        </p> --%>

		<!-- 생성일을 년-월-일 형식으로 출력 -->
		<p>
			<strong>작성일:</strong>
			<fmt:formatDate value="${bookDetail.createdAt}" pattern="yyyy-MM-dd" />
		</p>

		<p>
			<strong>연령 제한:</strong> ${bookDetail.age}
		</p>
		<p>
			<strong>좋아요 수:</strong> ${bookDetail.likes}
		</p>
		<p>
			<strong>연재 요일:</strong> ${bookDetail.serialDay}
		</p>
		<form action="workUpdate" method="get">
			<input type="hidden" name="bookId" value="${bookId}">
			<button type="submit" id="btnInsert">작품 수정</button>
		</form>
	</div>

	<div class="btn-area">
		<h2>스토리 목록</h2>

		<!-- 스토리 목록 출력 -->
		<c:forEach var="story" items="${storyList}">
			<div class="story-container">
				<div class="story-title">${story.title}</div>
				<div class="story-meta">
					<span>번호: ${story.number}</span> | <span>타입: ${story.type}</span> | <span>작성일: <fmt:formatDate value="${story.createdAt}" pattern="yyyy-MM-dd" /></span> | <span>비용:
						${story.cost}</span> | <span>조회수: ${story.views}</span>
				</div>
				<div class="story-content">
					<!-- 여기에 스토리 요약이나 추가 정보를 넣을 수 있습니다. -->
				</div>
			</div>
			<a href="/write/storyContents?number=${story.number}">회차보기</a>
		</c:forEach>
	</div>

</body>
</html>