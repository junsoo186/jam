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
                                <c:if test="${principal.userId eq project.userId}">
                                    <c:if test="${project.staffAgree eq 'N'}">
                                        <div class="button-container">
                                            <a class="funding--update--button"
                                                href="/funding/updateFunding?projectId=${project.projectId}">프로젝트 수정</a>
                                        </div>
                                    </c:if>
                                </c:if>

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
                                            <span id="goalAmount" data-goal="${project.goal}" style="display: none;">
                                                ${project.goal}</span>
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
                                <!-- 장바구니 항목 -->
                                <div class="cart-detail hidden" id="rewardDetail">
                                    <div id="cartItems">
                                        <!-- 리워드 항목이 여기에 동적으로 추가됩니다. -->

                                    </div>
                                    <div class="cart-total">
                                        <p>총 합계: <span id="cartTotal">0</span></p>
                                    </div>
                                    <button id="checkoutButton">결제하기</button>
                                </div>

                                <!-- 리워드 선택 영역 -->
                                <c:forEach items="${rewards}" var="reward">
                                    <button
                                        class="reward-button ${reward.rewardQuantity == 0 || project.dateEnd < currentDate ? 'disabled' : ''}"
                                        ${reward.rewardQuantity==0 || project.dateEnd < currentDate ? 'disabled' : '' }
                                        data-reward-id="${reward.rewardId}"
                                        data-reward-content="${reward.rewardContent}"
                                        data-reward-point="${reward.rewardPoint}"
                                        data-reward-quantity="${reward.rewardQuantity}">
                                        ${reward.userCount}명이 선택중!<br>
                                        ${reward.rewardContent}<br>
                                        <fmt:formatNumber value="${reward.rewardPoint}" pattern="#,###" /> 원<br>
                                        <c:choose>
                                            <c:when test="${reward.rewardQuantity == 0}">
                                                <p class="funding--text--deadline">선착순 마감</p>
                                            </c:when>
                                            <c:when test="${reward.rewardQuantity > 0}">
                                                <p>${reward.rewardQuantity} 개 남음!</p>
                                            </c:when>
                                        </c:choose>
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </main>

                    <!-- 숨김 데이터로 사용자 포인트를 포함 -->
                    <div id="userInfo" data-user-point="${principal.point}" style="display: none;"
                        data-user-id="${principal != null ? principal.userId : ''}"></div>

                    <script src="/js/funding/fundingDetail.js"></script>
                </body>

                </html>