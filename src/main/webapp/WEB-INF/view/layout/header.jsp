<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JAM</title>
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/common.css">
</head>
<body>
<header>

	<div class= "top-area">
		<nav class="top-nav">
			<div class="top-logo">
				<a href=""></a>
			</div>
			<div class="nav-item">
				<label><a href="">글쓰기</a></label>
			<c:choose>	
				<c:when test="${principal != null}">
					<label class="nav-login" ><a href="/user/sign-in">프로필</a></label>
				</c:when>
					<c:otherwise>	
					<label class="nav-login" ><a href="/user/sign-in">로그인</a></label>
					</c:otherwise>
			</c:choose>	
			</div>
		</nav>
		
		<section class="center-search">
		<form action="">
		 		<div class="search-container">
                    <input type="text" class="search-box" placeholder="검색란">
                    <button type="button" class="btn-search"></button>
                </div>
		</form>
				 
		
		</section>
		<!-- 상단 카테고리 란  -->
		<section class="center-category">
			<ul>
				<li><a href="">베스트 10</a><li>
				<li><a href="">나의 찜목록</a><li>
				<li><a href="">오늘의 펀딩</a><li>
			</ul>
		</section>
	</div>
		
		<!--사이드 바 영역  -->
		<section class="side-bar">
			<div class="side-top-profile">	
				<label><a href="">프로필</a></label>
				<label><a href="">마이페이지</a></label>
				<label><a href="">보유포인트</a></label>
				<label><a href="">포인트충전</a></label>>
			</div>
			<div class="side-center-cupon">
				<label><a href="">쿠폰함</a></label>
				<label><a href="">선물함</a></label>
			</div>
		
		</section>
	
	<script type="text/javascript" src=".../js/header.js"></script>
</header>
