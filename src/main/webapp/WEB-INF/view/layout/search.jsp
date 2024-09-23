<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/view/layout/header.jsp" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

            <link rel="stylesheet" href="/css/workList.css">

            <main>
                <section class="top--banner--area">
                    <c:forEach items="${banner}" var="bannerItem">
                        <div class="banner--content">
                            <img src="${bannerItem.imagePath}" alt="banner image" class="banner-img"
                                style="display: none;" />
                        </div>
                    </c:forEach>
                </section>

                <section class="center--content--container">
                    <div class="book--area">
                        <c:choose>
                            <c:when test="${not empty books}">
                                <div class="main--content">
                                    <c:forEach var="list" items="${books}">
                                        <div class="nav--story">
                                            <div class="book--title">${list.title}</div>

                                            <div>찜</div>
                                            <div>별점</div>
                                        </div>

                                        <!-- 책 영역 시작 -->
                                        <div class="book--area novel-${list.bookId} s-inv"
                                            onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
                                            <div class="left-section"
                                                onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
                                                <img src="${pageContext.request.contextPath}${list.bookCoverImage}"
                                                    class="img--cover">
                                                <div class="overlay">
                                                    <div class="overlay-content">
                                                        <p>저자: ${list.author}</p>
                                                        <p>제목: ${list.title}</p>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 이야기 목록과 페이지네이션 영역 -->
                                            <div id="story-list-${list.bookId}" class="story-list-container"
                                                data-book-id="${list.bookId}"
                                                data-current-page="${currentPageMap[list.bookId]}"
                                                data-total-pages="${totalPagesMap[list.bookId]}">
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p>검색 결과가 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>
            </main>