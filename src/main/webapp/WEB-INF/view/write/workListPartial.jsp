<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이야기 목록과 페이지네이션 버튼을 감싸는 컨테이너 -->
<div class="story-list-container">
    <!-- 페이징 버튼 (왼쪽) -->
    <a class="page-link prev" data-book-id="${bookId}" data-current-page="${currentPage}" data-total-pages="${totalPages}" 
       href="?bookId=${bookId}&page=${currentPage - 1}&size=${size}" 
       <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>><</a>

    <!-- 책의 이야기 목록을 페이징 처리하여 출력하는 영역 -->
    <div class="story-list">
        <c:forEach var="story" items="${storyMap[bookId]}">
            <div class="story--content">
                <a href="/write/storyContents?storyId=${story.storyId}">
                    <c:choose>
                        <c:when test="${story.number == 0}">
                            <p class="story--part">프롤로그</p>
                        </c:when>
                        <c:otherwise>
                            <p class="story--part">${story.number}화</p>
                        </c:otherwise>
                    </c:choose>
                    <p class="story--title">${story.title}</p>
                    <p class="story--other">${story.createdAt}</p>
                    <p class="story--other">${story.views}</p>
                </a>
            </div>
        </c:forEach>
    </div>

    <!-- 페이징 버튼 (오른쪽) -->
    <a class="page-link next" data-book-id="${bookId}" data-current-page="${currentPage}" data-total-pages="${totalPages}" 
       href="?bookId=${bookId}&page=${currentPage + 1}&size=${size}" 
       <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>></a>
</div>