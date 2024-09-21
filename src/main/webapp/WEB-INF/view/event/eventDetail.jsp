<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/eventDetail.css">

<main class="event-detail-container">

   
  	<!-- 이벤트 상세 내용 -->
  	<div class="mb-3">제목: ${event.eventTitle}</div>
    <section class="event-detail-content">
        <!-- 이미지 또는 추가 내용 -->
        <div class="event-images">
            <img src="${event.eventImage}" alt="이벤트 이미지 1">
            <!-- 필요한 만큼 이미지를 추가 -->
        </div>
    </section>
</main>
