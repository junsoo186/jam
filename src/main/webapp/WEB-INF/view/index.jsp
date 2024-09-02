<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메인화면</title>
<link rel="stylesheet" href="/css/index.css">
</head>
<body>

	<div class="container--banner">
		<!-- 배너 -->
		<section class="top--banner">
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
				<div class="visual--image">
					<img alt="banner--image" src="/images/bookimg1.jpg" class="fixed--size">
				</div>
				<div class="banner--text--container">
					<div class="banner--textBox">
						<p class="strong--text">명문 고등학교에서 일어난</p>
						<p class="strong--text">충격적인 살인사건</p>
						<p>시간 순삭 ! 추리소설</p>
					</div>
					<!-- 페이지 번호는 텍스트 박스 아래에 위치 -->
					<div class="page--number">
						<strong>1</strong> <span class="dash">/</span> <strong>2</strong> <span class="dash">/</span> <strong>3</strong>
					</div>
				</div>
			</div>
		
			<!-- <img alt="banner1-2" src="/images/banner2.jpg" class="fixed--size"> <img alt="banner1-3" src="/images/banner3.jpg" class="fixed--size"> -->
		</section>

		<!-- 추가 배너 섹션 -->
		<!-- <section class="banner"></section>
		<section class="banner"></section> -->
	</div>

	<div class="container mt--5">
		<!-- 카테고리 필터 -->
		<div class="category--filter">
			<button class="category--btn active">종합</button>
			<button class="category--btn">인기</button>
			<button class="category--btn">신작</button>
			<button class="category--btn">소설</button>
			<button class="category--btn">시/에세이</button>
			<button class="category--btn">인문/교양</button>
			<button class="category--btn">어린이/청소년</button>
			<button class="category--btn">판타지/무협</button>
		</div>

		<!-- 책 목록 -->
		<h3>지금 가장 인기있는 웹소설</h3>
		<div class="book--list--1">
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="매직 스플릿">
				<div class="book--info">
					<h4>매직 스플릿</h4>
					<p>박성현</p>
					<p>밀리의 발견</p>

				</div>
			</div>
			<!-- 다른 책 아이템을 추가로 작성 -->
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
		</div>

		<!-- 신작 -->
		<!-- 책 목록 -->
		<h3>따끈 따끈 , 새로들어온 책</h3>
		<div class="book--list--2">
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="매직 스플릿">
				<div class="book--info">
					<h4>매직 스플릿</h4>
					<p>박성현</p>
					<p>밀리의 발견</p>

				</div>
			</div>
			<!-- 다른 책 아이템을 추가로 작성 -->
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
		</div>

		<!-- 이번주 주목할 펀딩 -->
		<!-- 책 목록 -->
		<h3>이번주 주목할 펀딩</h3>
		<div class="book--list--3">
			<div class="book--item--funding">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info--funding">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item--funding">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info--funding">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
			<div class="book--item--funding">
				<img src="/images/bookimg1.jpg" alt="역대급 포식능력자의...">
				<div class="book--info--funding">
					<h4>역대급 포식능력자의...</h4>
					<p>박성현</p>
					<p>이세계사장</p>
				</div>
			</div>
		</div>
	</div>



</body>
</html>
