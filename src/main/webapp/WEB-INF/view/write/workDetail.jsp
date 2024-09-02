<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/workDetail.css">
<script type="text/javascript" src="/js/sort.js"></script>
<main>
	<div class="container">
		<h1>책 상세페이지</h1>
		<div class="novel-details">
			<div class="book-cover-section">
				<div class="book-cover">
					<img src="path/to/book/cover.jpg" alt="북 커버 이미지" class="cover-image">
				</div>
			</div>
			<div class="details-section">
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
				<p>
					<strong>카테고리:</strong> ${bookDetail.categoryName}
				</p>
				<p>
					<strong>장르:</strong> ${bookDetail.genreName}
				</p>
				<%-- 태그가 있다면 표시합니다. --%>
				<c:if test="${not empty bookDetail.tagNames}">
					<p>
						<strong>태그:</strong>
						<c:forEach var="tag" items="${bookDetail.tagNames}">
                            #${tag}
                        </c:forEach>
					</p>
				</c:if>
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
			</div>

			<%--  후원,펀딩 버튼위치와 고민중 --%>
			<c:if test="${principalId eq bookDetail.userId}">
				<div class="btn-section">
					<form action="workUpdate" method="get">
						<input type="hidden" name="bookId" value="${bookId}">
						<button type="submit" class="button">작품 수정</button>
					</form>
					<form action="storyInsert" method="get">
						<input type="hidden" name="bookId" value="${bookId}">
						<button type="submit" class="button">회차 생성</button>
					</form>
				</div>
			</c:if>
		</div>

		<div class="story-list-section">
			<!-- EP 순으로 오름차순 정렬 -->
			<button onclick="sortStories('asc')" class="btn">EP 오름차순 정렬</button>
			<!-- EP 순으로 내림차순 정렬 -->
			<button onclick="sortStories('desc')" class="btn" style="margin-top: 10px;">EP 내림차순 정렬</button>

			<div id="storyListContainer">
				<c:forEach var="story" items="${storyList}">
					<div class="story-container" data-ep="${story.number}">
						<a href="/write/storyContents?storyId=${story.storyId}" class="story-title">${story.title}</a>
						<div class="story-meta">
							<span>Ep.${story.number}</span>
						</div>
						<div class="story-actions">
							<c:if test="${principalId eq story.userId}">
								<form action="storyUpdate" method="get">
									<input type="hidden" name="storyId" value="${story.storyId}">
									<button type="submit" class="btn">수정</button>
								</form>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

	</div>
</main>
</body>
</html>