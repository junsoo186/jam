<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>

                <head>
                    <link rel="stylesheet" href="/css/funding/checkout.css">
                </head>

                <body>
                    <div class="main--container">
                        <div class="checkout--content--area">
                            <h1 class="checkout--title">결제 확인</h1>

                            <form id="checkoutForm" action="/funding/checkoutPage" method="post">
                                <div>
                                    <h2 class="checkout--info--text">결제 정보</h2>
                                    <c:forEach var="reward" items="${rewards}" varStatus="status">
                                        <p>${reward.rewardContent} - ${reward.rewardPoint}원 (수량:
                                            ${quantities[status.index]}개)</p>
                                        <input type="hidden" name="rewardIds" value="${reward.rewardId}">
                                        <input type="hidden" name="quantities" value="${quantities[status.index]}">
                                    </c:forEach>
                                </div>


                                <div>
                                    <h2 class="checkout--info--text">총 결제 금액</h2>
                                    <p id="totalAmount">${totalAmount} 원</p>
                                </div>
                                <!-- 숨겨진 입력 필드로 totalAmount 전달 -->
                                <input type="hidden" name="totalAmount" value="${totalAmount}" />

                                <div class="input--address--area">
                                    <div class="input--postcode--group">
                                        <input type="text" id="sample6_postcode" name="postcode"
                                            class="input--form--field" placeholder="우편번호">
                                        <input type="button" onclick="sample6_execDaumPostcode()"
                                            class="btn--postcode--search" value="우편번호 찾기">
                                    </div>
                                    <input type="text" id="sample6_address" name="basicAddress"
                                        class="input--form--field" placeholder="주소">
                                    <input type="text" id="sample6_detailAddress" name="detailedAddress"
                                        class="input--form--field" placeholder="상세주소">
                                    <input type="text" id="sample6_extraAddress" name="extraAddress"
                                        class="input--form--field" placeholder="참고항목">
                                </div>

                                <button type="submit" id="finalCheckoutButton" class="btn--checkout">결제하기</button>
                            </form>
                        </div>
                    </div>

                    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script src="/js/funding/checkout.js"></script>
                </body>