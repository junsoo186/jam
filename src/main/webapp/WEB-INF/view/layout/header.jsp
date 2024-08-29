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
<<<<<<< HEAD
			
				<label><a href="">글쓰기</a></label>

			<c:choose>	
				<c:when test="${principal != null}">
					<label class="nav-login" ><a href="/user/sign-in">프로필</a></label>
				</c:when>
					<c:otherwise>	
					<label class="nav-login" ><a href="/user/login">로그인</a></label>
					</c:otherwise>
			</c:choose>	
=======
				<c:choose>
					<c:when test="${principal != null}">
						<%-- 사용자가 로그인 상태  --%>
								<label><a href="">글쓰기</a></label>
				<li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<%-- 사용자가 로그인 안된 상태  --%>
				<li class="nav-login"><a class="nav-link" href="/user/sign-in">로그인</a></li>
				<li class="nav-login"><a class="nav-link" href="/user/sign-up">회원가입</a></li>
					</c:otherwise>
				</c:choose>
				
>>>>>>> 0ff68240bb409579f0bcb01400ab722a49cddab0
			</div>
		</nav>
		
			<!-- 검색 관련 코드  -->
		<div id="cover">
		  	<form method="get" action="" class="search-form">
				    <div class="search-tb">
				      <div class="search-td"><input type="text" class="search-input" placeholder="검색란" ></div>
				      <div class="search-td" id="s-cover">
				        <button type="submit" class="search-button">
				          <div id="s-circle"></div>
				          <span></span>
				        </button>
				      </div>
				    </div>
  			</form>
		</div>
		<!-- 검색 관련 코드 종료  -->
		
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
