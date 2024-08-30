<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
}

.novel-details {
    display: flex;
    flex-direction: row;
    gap: 20px;
    padding: 20px;
    background-color: #fefefe;
    border-radius: 8px;
    border: 1px solid #ccc;
}

.book-cover-section {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

.book-cover {
    width: 100%;
    max-width: 200px;
    height: auto;
}


.cover-image {
    width: 100%;
    height: auto;
    display: block;
}

.details-section {
    flex: 2;
}

.buttons-section {
    display: flex;
    gap: 10px;
    margin-top: 20px;
}

.story-list-section {
    margin-top: 40px;
}

.story-container {
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 10px;
    background-color: #ffffff;
}

.story-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 5px;
}

.story-meta {
    font-size: 14px;
    color: #777;
    margin-bottom: 10px;
}

.story-actions {
    display: flex;
    gap: 10px;
}

.btn {
    padding: 10px 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
}

.btn:hover {
    background-color: #0056b3;
}

form {
    display: inline;
}

</style>
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
                <p><strong>제목:</strong> ${bookDetail.title}</p>
                <p><strong>작가:</strong> ${bookDetail.author}</p>
                <p><strong>작가 코멘트:</strong> ${bookDetail.authorComment}</p>
                <p><strong>소개:</strong> ${bookDetail.introduction}</p>
                <p><strong>카테고리:</strong> ${bookDetail.categoryName}</p>
                <p><strong>장르:</strong> ${bookDetail.genreName}</p>
                <%-- 태그가 있다면 표시합니다. --%>
                <c:if test="${not empty bookDetail.tagNames}">
                    <p><strong>태그:</strong> 
                        <c:forEach var="tag" items="${bookDetail.tagNames}">
                            #${tag}
                        </c:forEach>
                    </p>
                </c:if>
                <p><strong>작성일:</strong> <fmt:formatDate value="${bookDetail.createdAt}" pattern="yyyy-MM-dd" /></p>
                <p><strong>연령 제한:</strong> ${bookDetail.age}</p>
                <p><strong>좋아요 수:</strong> ${bookDetail.likes}</p>
                <p><strong>연재 요일:</strong> ${bookDetail.serialDay}</p>
            </div>
            
            <%--  후원,펀딩 버튼위치와 고민중 --%>
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
        </div>

		<%-- 책형태로 css 수정해야함 --%>
        <div class="story-list-section">
            <h2>스토리 목록</h2>
            <c:forEach var="story" items="${storyList}">
                <div class="story-container">
                    <div class="story-title">${story.title}</div>
                    <div class="story-meta">
                        <span>번호: ${story.number}</span> | 
                        <span>타입: ${story.type}</span> | 
                        <span>작성일: <fmt:formatDate value="${story.createdAt}" pattern="yyyy-MM-dd" /></span> | 
                        <span>비용: ${story.cost}</span> | 
                        <span>조회수: ${story.views}</span>
                    </div>
                    <div class="story-actions">
                        <a href="/write/storyContents?storyId=${story.storyId}" class="button">회차보기</a>
                        <form action="storyUpdate" method="get">
                            <input type="hidden" name="storyId" value="${story.storyId}">
                            <button type="submit" class="button">회차수정</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>



</body>
</html>