<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<link rel="stylesheet" href="/css/workList.css">
<link rel="stylesheet" href="/css/banner.css">
<link rel="stylesheet" href="/css/layout/page.css">
<main>
    <section class="top--nav--area">
        <div class="navbar">
            <a href="#myWorks">작품관리</a>
            <a href="#supportManagement">후원관리</a>
            <a href="#workStatistics">정산</a>
            <a href="#settlement">펀딩관리</a>
        </div>
    </section>

    <section class="top--banner--area">
        <c:forEach items="${banner}" var="bannerItem" varStatus="status">
            <div class="banner--content" style="display: ${status.index == 0 ? 'block' : 'none'};">
                <img src="${bannerItem.imagePath}" alt="배너 이미지" class="banner-img" />
            </div>
        </c:forEach>
    </section>

    <div class="top--btn--area">
        <form action="workInsert" method="get">
            <button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
        </form>
    </div>

    <section class="center--content--container">
        <div class="book--area">
            <c:choose>
                <c:when test="${bookList != null}">
                    <div class="main--content">
                        <c:forEach var="list" items="${bookList}">
                            <div class="nav--story">
                                <a href="/write/storyInsert?bookId=${list.bookId}">
                                    <div class="href--btn">
                                        <label class="story--write">회차쓰기</label>
                                    </div>
                                </a>
                                <a href="/write/workUpdate?bookId=${list.bookId}">
                                    <div class="href--btn" style="margin-left: 6px;">
                                        <label class="book--write">소설관리</label>
                                    </div>
                                </a>
                                <div class="book--title">${list.title}</div>
                            
                                <div class="star-rating">
                                    <c:forEach var="i" begin="1" end="5">
                                        <div class="star">
                                            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path class="${i <= list.bookTotalScore ? 'filled' : 'empty'}"
                                                d="M12 .587l3.668 7.429 8.2 1.191-5.934 5.781 1.4 8.161L12 18.896l-7.334 3.863 1.4-8.161L.132 9.207l8.2-1.191z"/>
                                            </svg>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="likes-container">
                                    <div class="likes--shap">
                                        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                        </svg>
                                    </div>
                                    ${list.likes} 
                                </div>
                            </div>

                            <div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
                                <div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
                                    <img src="${pageContext.request.contextPath}${list.bookCoverImage}" class="img--cover">

                                    <div class="overlay">
                                        <div class="overlay-content">
                                            <p>저자: ${list.author}</p>
                                            <p>제목: ${list.title}</p>
                                            <div>${list.tagNames}</div>
                                        </div>
                                    </div>    
                                </div>

                                <div id="story-list-${list.bookId}" 
                                     class="story-list-container"
                                     data-book-id="${list.bookId}" 
                                     data-current-page="${currentPageMap[list.bookId]}" 
                                     data-total-pages="${totalPagesMap[list.bookId]}">
                                </div>
                            </div>
                        </c:forEach>
                    </div>


                <div class="flex--page">
                    <div class="pagination">
                        <c:if test="${currentBookPage > 1}">
                            <a href="?bookPage=${currentBookPage - 1}&bookSize=${bookSize}">&laquo; 이전</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalBookPages}">
                            <a href="?bookPage=${i}&bookSize=${bookSize}" class="${i == currentBookPage ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${currentBookPage < totalBookPages}">
                            <a href="?bookPage=${currentBookPage + 1}&bookSize=${bookSize}">다음 &raquo;</a>
                        </c:if>
                    </div>
                </div>
                </c:when>
                <c:otherwise>
                    <p>작성한 책 내역이 존재하지 않습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<script type="text/javascript" src="/js/workList.js"></script>
<script type="text/javascript" src="/js/banner.js"></script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
