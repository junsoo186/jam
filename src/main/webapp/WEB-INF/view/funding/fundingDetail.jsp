<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <!DOCTYPE html>
                <html lang="ko">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link rel="stylesheet" href="/css/funding/fundingDetail.css">
                    <title>${project.title}</title>
                </head>

                <body>

                    <main class="main-container">
                        <div class="main-area">
                            <!-- Left side: Main Area/Funding -->
                            <div class="funding-area">
                                <h2>${project.categoryName}</h2>
                                <h1>${project.title}</h1>

                                <!-- Image Slider -->
                                <div class="image-slider">
                                    <div class="slides">
                                        <c:forEach var="img" items="${projectImgs}" varStatus="status">
                                            <img src="${img.img}" alt="Sample Image ${status.index}"
                                                class="slide ${status.first ? 'active' : ''}">
                                        </c:forEach>
                                    </div>

                                    <!-- 이전, 다음 버튼 -->
                                    <button class="prev">&#10094;</button>
                                    <button class="next">&#10095;</button>

                                    <!-- Dot Indicators -->
                                    <div class="dot-container">
                                        <c:forEach var="img" items="${projectImgs}" varStatus="status">
                                            <span class="dot ${status.first ? 'active' : ''}"
                                                data-slide="${status.index}"></span>
                                        </c:forEach>
                                    </div>
                                </div>


                                <!-- Funding Info -->
                                <div class="funding-info">
                                    <div class="goal-amount">
                                        <span><b>모인금액</b></span>
                                        <div class="funding--amount">
                                            <span id="goalAmount" data-goal="${project.goal}"
                                                style="display: none;">${project.goal}</span>
                                            <span id="totalAmount" data-total="${project.totalAmount}">
                                                <fmt:formatNumber value="${project.totalAmount}" pattern="#,###" /> 원
                                            </span>
                                            <span id="percentage"></span> <!-- 달성률이 표시될 영역 -->
                                        </div>
                                    </div>
                                    <div class="remaining-time" data-dateEnd="${project.dateEnd}">
                                        남은 시간 : <span id="remainingTime"></span>
                                    </div>
                                    <div class="participant-count">후원자 : ${project.participantCount}명</div>
                                </div>

                                <!-- Description Area -->
                                <div class="description-area">
                                    <h4>작품 소개</h4>
                                    <c:out value="${project.contents}" escapeXml="false" />
                                </div>
                            </div>

                            <!-- Right side: Funding Selection -->
                            <div class="reward-selection">
                                <div class="reward-title">펀딩 선택</div>
                                <c:forEach items="${rewards}" var="reward">
                                    <button class="reward-button">
                                        ${reward.rewardContent}<br>
                                        <fmt:formatNumber value="${reward.rewardPoint}" pattern="#,###" /> 원
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </main>

                    <script src="/js/funding/fundingDetail.js"></script>
                </body>

                </html>