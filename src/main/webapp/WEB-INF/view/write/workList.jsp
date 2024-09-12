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
                            </div>
                        
                            <!-- 책 영역 시작 -->
                            <div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
                                <div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
                                    <img src="${list.bookCoverImage}" class="img--cover">
                                    <!-- 저자 정보를 위한 오버레이 -->
                                    <div class="overlay">
                                        <div class="overlay-content">
                                            <p>저자: ${list.author}</p>
                                            <p>제목: ${list.title}</p>
                                        </div>
                                    </div>
                                </div>
                        
                                <!-- 회차 목록 영역 -->
                                <div class="story-list">
                                    <c:forEach var="story" items="${storyMap[list.bookId]}">
                                        <div class="story--content">
                                            <a href="/write/storyContents?storyId=${story.storyId}">
                                            <c:choose>
                                                <c:when test="${story.number==0}">
                                                    <p class="story--part"> 프롤로그</p>
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
                        
                                <!-- 페이지네이션 영역 -->
                               
                            </div>
                            <!-- 책 영역 끝 -->
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
