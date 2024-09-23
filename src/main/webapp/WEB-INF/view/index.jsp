<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메인화면</title>
<link rel="stylesheet" href="/css/index.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="font/GmarketSansMedium.css" />
	<div class="back-ground"></div>
<main>

 <!-- 1. 배너 Swiper -->
 <div class="swiper-container banner-swiper-container">
	 <!-- 부모보다 넓게 적용할 배경색 요소 -->
	 <div class="banner-swiper-wrapper-bg"></div>
	 
	 <div class="swiper-wrapper">
		 <!-- 배너 슬라이드 내용 -->
	 </div>
	 <div class="swiper-button-prev banner-swiper-button-prev"></div>
	 <div class="swiper-button-next banner-swiper-button-next"></div>
	 <div class="swiper-pagination banner-swiper-pagination"></div>
 </div>
  

    <!-- 1. 배너 Swiper -->

	

	
<h3 style="margin-top: 100px">요일별 인기작품</h3>
<!-- 요일별 작품 영역 -->
<div class="day--area--filter" id="dayFilter"></div>

<!-- 버튼 대신 셀렉박스가 나을지도  -->
<div class="btn--area" > 
	<div class="btn--area--day">
    <button class="btn--day--views active" id="dayViewsButton" onclick="toggleDayViewsOrder()">조회수</button>
    <button class="btn--day--views" id="dayLikesButton" onclick="toggleDayLikesOrder()">선호</button>

    </div>
</div>

<div class="book--list--1" id="dayContent"></div>
	
			<!-- 인기 순위 -->
		<h3>문학장르 인기작품 </h3>
<!-- 카테고리별 필터 영역 -->
<div class="category--area--filter" id="categoryFilter"></div>

<div class="btn--area">
	<div class="btn--area--category">
	    <!-- 카테고리별 정렬 버튼 -->
	    <button class="btn--category--views active" id="categoryViewsButton" onclick="toggleCategoryViewsOrder()">조회수</button>
	    <button class="btn--category--likes" id="categoryLikesButton" onclick="toggleCategoryLikesOrder()">선호</button>
	</div>
</div>


<!-- 선택된 카테고리의 책 목록 -->
<div class="book--list--1" id="categoryContent"></div>

		<h3>장르별 인기 작품</h3>
<!-- 장르별 필터 영역 -->
<div class="genre--area--filter" id="genreFilter"></div>
<br>
<div class="btn--area">
	<div class="btn--area--genre">
	    <!-- 장르별 정렬 버튼 -->
	    <button class="btn--genre--views active" id="genreViewsButton" onclick="toggleGenreViewsOrder()">조회수</button>
	    <button class="btn--genre--likes"  id="genreLikesButton" onclick="toggleGenreLikesOrder()">선호</button>
	</div>
</div>
<!-- 선택된 장르의 책 목록 -->
<div class="book--list--1" id="genreContent"></div>



		<h3>오늘 인기 작품</h3>

    <div class="book--list--1" id="newDayContent" >
        <!-- 책 목록이 여기에 동적으로 추가됨 -->
    </div>



</main>
	<!-- JavaScript 파일을 여기에 포함 -->
	<script type="text/javascript" src="/js/index.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>

