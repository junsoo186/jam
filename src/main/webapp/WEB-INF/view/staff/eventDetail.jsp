
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
     <main class="container">
        <!-- 이벤트 배너 -->
        <section class="event-banner">
            <img src="/images/event-banner.jpg" alt="이벤트 배너">
            <div class="event-text">
                <h1>현재 진행 중인 이벤트!</h1>
                <p>멋진 경품과 혜택이 가득한 이벤트에 참여하세요!</p>
                <a href="#event-details" class="btn-participate">이벤트 참여하기</a>
            </div>
        </section>

        <!-- 이벤트 목록 -->
        <section id="event-details" class="event-list">
            <h2>진행 중인 이벤트</h2>
            <div class="event-items">
                <!-- 이벤트 1 -->
                <div class="event-item">
                    <img src="/images/event1.jpg" alt="이벤트 1">
                    <h3>이벤트 이름 1</h3>
                    <p>이벤트 설명 1</p>
                    <a href="/event/1" class="btn-detail">자세히 보기</a>
                </div>
                <!-- 이벤트 2 -->
                <div class="event-item">
                    <img src="/images/event2.jpg" alt="이벤트 2">
                    <h3>이벤트 이름 2</h3>
                    <p>이벤트 설명 2</p>
                    <a href="/event/2" class="btn-detail">자세히 보기</a>
                </div>
                <!-- 추가 이벤트 -->
                <!-- ... -->
            </div>
        </section>

        <!-- 지난 이벤트 목록 -->
        <section class="past-events">
            <h2>지난 이벤트</h2>
            <div class="event-items">
                <div class="event-item">
                    <img src="/images/event-past1.jpg" alt="지난 이벤트 1">
                    <h3>지난 이벤트 1</h3>
                </div>
                <div class="event-item">
                    <img src="/images/event-past2.jpg" alt="지난 이벤트 2">
                    <h3>지난 이벤트 2</h3>
                </div>
            </div>
        </section>
    </main>