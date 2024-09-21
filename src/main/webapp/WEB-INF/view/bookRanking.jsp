<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/bookRanking.css">
<main>
<div class="button-container">
    <h1>랭킹</h1>
    <div class="btn--area" id="btnArea">
        <!-- 정렬 버튼 -->
        <button id="viewsButton" class="btn--day--views active" onclick="toggleActiveButton('views')">조회수</button>
        <button id="likesButton" class="btn--day--likes" onclick="toggleActiveButton('likes')">좋아요</button>
    </div>
</div>

<!-- 리스트가 출력될 영역 -->
<ul id="bookList">
    <c:forEach var="rank" items="${ranks}">
        <li data-views="${rank.totalViews}" data-likes="${rank.totalLikes}">
            <a href="/write/workDetail?bookId=${rank.bookId}">
                <div class="book-item">
                    <div class="book-cover">
                        <img src="${rank.bookCoverImage}" alt="${rank.title}">
                    </div>
                    <div class="book-info">
                        <b class="book-title">${rank.title}</b>
                        <p class="book-author">${rank.author}</p>
                        <p class="book-stats">조회수: ${rank.totalViews} / 좋아요: ${rank.totalLikes}</p>
                    </div>
                </div>
            </a>
        </li>
    </c:forEach>
</ul>
</main>
<script type="text/javascript" src="/js/navigation.js"></script>
