<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메인화면</title>
<link rel="stylesheet" href="/css/index.css">
<main>

	<div class="container--banner">
		<!-- 배너 -->
		<section class="top--banner" id="top--banner">
			<div class="banner--back--container">
				<div class="banner--paging">
					<div class="banner--paging--inner">
						<div class="paging--progress"></div>
						<div class="percent--transition"></div>
					</div>
				</div>
			</div>

			<!-- 배너 이미지와 텍스트박스 -->
			<div class="visual--meta">
				<div class="visual--image" id="banner--1">
					<img alt="banner--image" src="/images/banner/bannerimg1.jpg" class="fixed--size">
				</div>
				<div class="visual--image" id="banner--2" style="display: none;">
					<img alt="banner--image" src="/images/banner/bannerimg2.jpg" class="fixed--size">
				</div>
				<div class="visual--image" id="banner--3" style="display: none;">
					<img alt="banner--image" src="/images/banner/bannerimg3.jpg" class="fixed--size">
				</div>
				<div class="banner--text--container">
					<div class="banner--text--box" id="text--1">
						<p class="strong--text">명문 고등학교에서 일어난</p>
						<p class="strong--text">충격적인 살인사건</p>
						<p>시간 순삭 ! 추리소설</p>
					</div>
					<div class="banner--text--box" id="text--2" style="display: none;">
						<p class="strong--text">나도? 웹소설 작가!</p>
						<p>
							<b>잼</b> 을 통해 데뷔할 신입작가를 모집합니다!
						</p>
					</div>
					<div class="banner--text--box" id="text--3" style="display: none;">
						<p class="strong--text">당신의 밤을 몰수하는 톨쥬</p>
						<p class="strong--text">혼불</p>
						<p>펀딩시 50화 무료</p>
					</div>
					<!-- 페이지 번호는 텍스트 박스 아래에 위치 -->
					<div class="page--number">
						<strong class="page--num active" data--page="1">1</strong> <span class="dash">/</span> <strong class="page--num" data--page="2">2</strong> <span class="dash">/</span> <strong
							class="page--num" data--page="3">3</strong>
					</div>
				</div>
			</div>
		</section>
	</div>
	
<h3> 요일 별 작품</h3>
<div id="dayButtons"></div>

<!-- 책 목록을 보여줄 영역 -->
<div class="book--list--1" id="bookList"></div>

<!-- Views, Likes 정렬 버튼 -->
<div class="btn--area">
    <button id="viewsButton" onclick="sortBy('views')">VIEWS</button>
    <button id="likesButton" onclick="sortBy('likes')">LIKES</button>
</div>
	
	
			<!-- 인기 순위 -->
		<h3> 가장 인기있는 웹소설</h3>
<!-- 카테고리별 필터 영역 -->
<div class="category--area--filter" id="categoryFilter"></div>

<div class="btn--area">
	<div class="btn--area--category">
	    <!-- 카테고리별 정렬 버튼 -->
	    <button class="btn--category--views" id="categoryViewsButton" onclick="toggleCategoryViewsOrder()">VIEWS</button>
	    <button class="btn--category--likes" id="categoryLikesButton" onclick="toggleCategoryLikesOrder()">LIKES</button>
	</div>
</div>


<!-- 선택된 카테고리의 책 목록 -->
<div class="book--list--1" id="categoryContent"></div>

		<h3>가장 선호하는 웹소설</h3>
<!-- 장르별 필터 영역 -->
<div class="genre--area--filter" id="genreFilter"></div>
<br>
<div class="btn--area">
	<div class="btn--area--genre">
	    <!-- 장르별 정렬 버튼 -->
	    <button class="btn--genre--views" id="genreViewsButton" onclick="toggleGenreViewsOrder()">VIEWS</button>
	    <button class="btn--genre--likes"  id="genreLikesButton" onclick="toggleGenreLikesOrder()">LIKES</button>
	</div>
</div>

<!-- 선택된 장르의 책 목록 -->
<div class="book--list--1" id="genreContent"></div>





		<div >
			<div class="book--item">
				<img src="/images/bannerimg1.jpg" alt="매직 스플릿">
				<div class="book--info">
					<h4>매직 스플릿</h4>
					<p>박성현</p>
					<p>밀리의 발견</p>
				</div>
			</div>
			<!-- 다른 책 아이템을 추가로 작성 -->
			<div class="book--item">
				<img src="/images/bannerimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bannerimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">

			</div>
			<div class="book--item">

				</div>
			</div>
		</div>

		<!-- 책 목록 -->

		<!-- 신작 -->
		<h3>따끈 따끈 , 새로들어온 책</h3>

		<div class="book--list--2">
			<div class="book--item">
				<img src="/images/bannerimg1.jpg" alt="매직 스플릿">
				<div class="book--info">
					<h4>매직 스플릿</h4>
					<p>박성현</p>
					<p>밀리의 발견</p>
				</div>
			</div>
			<!-- 다른 책 아이템을 추가로 작성 -->
			<div class="book--item">
				<img src="/images/bannerimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">

			</div>
			<div class="book--item">

				</div>
			</div>
			<div class="book--item">

			</div>
		</div>

		<div class="event--container">
			<div class="slider--wrapper">
				<div class="slider">
					<div class="slide">
						<a href=""><img class="event--banner" src="" alt="슬라이드 이미지 1"></a> 
						<a href=""><img class="event--banner" src="" alt="슬라이드 이미지 2"></a>
						<a href=""><img class="event--banner" src="" alt="슬라이드 이미지 3"></a>
					</div>
				</div>
			</div>
		</div>
		<!-- 책 목록 -->

		<!-- 이번주 주목할 펀딩 -->
		<h3>이번주 주목할 펀딩</h3>
		<div class="book--list--3">
			<div class="book--item--funding">
				<img src="/images/bannerimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info--funding">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item--funding">

				</div>
			</div>
			<div class="book--item--funding">

				</div>
			</div>
		</div>
	</div>
</main>
	<!-- JavaScript 파일을 여기에 포함 -->
	<script type="text/javascript" src="/js/index.js"></script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>

