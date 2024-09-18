<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<link rel="stylesheet" href="/css/workList.css">
<main>
    <section class="top--nav--area">
        <div class="navbar">
            <a href="#myWorks">작품관리</a>
            <a href="#supportManagement">후원관리</a>
            <a href="#workStatistics">정산</a>
            <a href="#settlement">펀딩관리</a>
        </div>
    </section>

    <section class="top--benner--area">
        <div class="benner--content">
            <img src="../images/benner/benner.jpg">
        </div>
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
                            
                              <div>찜</div>
                              <div>별점</div>

                            </div>

                            <!-- 책 영역 시작 -->
                            <div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
                                <div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
                                    <img src="${pageContext.request.contextPath}${list.bookCoverImage}" class="img--cover" alt="${list.title} 이미지">
                                    <div class="overlay">
                                        <div class="overlay-content">
                                            <p>저자: ${list.author}</p>
                                            <p>제목: ${list.title}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- 이야기 목록과 페이지네이션 영역 -->
                                <div id="story-list-${list.bookId}" 
                                     class="story-list-container"
                                     data-book-id="${list.bookId}" 
                                     data-current-page="${currentPageMap[list.bookId]}" 
                                     data-total-pages="${totalPagesMap[list.bookId]}">
                                </div>
                            </div>
                        </c:forEach>
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

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>