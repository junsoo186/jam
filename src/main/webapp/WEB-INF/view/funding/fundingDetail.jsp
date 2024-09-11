<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <!DOCTYPE html>
                <link rel="stylesheet" href="/css/funding/fundingDetail.css">

                <body>

                    <main class="main-container">
                        <div class="main-area">
                            <!-- Left side: Main Area/Funding -->
                            <div class="funding-area">
                                <h2>${project.categoryName}</h2>
                                <h1>${project.title}</h1>
                                <div class="main--img">
                                    <img src="${project.mainImg}" alt="메인 이미지">
                                </div>

                                <!-- Sample Images Section -->
                                <div class="sample-images">
                                    <h4>샘플 이미지</h4>
                                    <div class="sample-images-container">
                                        <c:forEach items="${projectImgs}" var="img">
                                            <img src="${img}" alt="Sample Image" class="sample-img">
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="funding-info">
                                    <div class="goal-amount">
                                        <span><b>모인금액</b></span>
                                        <div class="funding--amount">
                                            <span id="goalAmount" data-goal="${project.goal}"
                                                style="display: none;">${project.goal}</span>
                                            <span id="totalAmount" data-total="${project.totalAmount}">
                                                <fmt:formatNumber value="${project.totalAmount}" pattern="#,###" /> 원
                                            </span>
                                            </span>
                                            <span id="percentage"></span> <!-- 달성률이 표시될 영역 -->
                                        </div>
                                    </div>
                                    <div class="remaining-time" data-dateEnd="${project.dateEnd}">
                                        남은 시간 : <span id="remainingTime"></span>
                                    </div>
                                    <div class="participant-count">후원자 : ${project.participantCount}명</div>
                                </div>
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
                                        <fmt:formatNumber value="${reward.rewardPoint}" type="currency" />
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </main>

                    <script src="/js/funding/fundingDetail.js"></script>
                </body>

                </html>