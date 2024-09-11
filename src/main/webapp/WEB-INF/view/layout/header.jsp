<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JAM</title>
<link rel="stylesheet" href="/css/layout/header.css">
<link rel="stylesheet" href="/css/layout/headerIcon.css">
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" href="/css/common.css">
</head>
<body>
	<header>
		<section class="top-all-inside">
		<div class="top-area">
			<section class="center-category">
				<ul>
					<li><img class="img-rank" src="/images/layout/rank.png"><a href="">랭킹</a>
					<li>
					<li><a href="">이벤트</a>
					<li>
					<li><a href="">펀딩</a>
					<li>
					<li><a href="/">공지</a>
					<li>
				</ul>
			</section>
				<nav class="top-nav">
					<div class="top-logo">
						<a href="/"></a>
					</div>

					<div class="nav-item">
						<c:choose>
							<c:when test="${principal != null}">
							<c:choose>
								<c:when test="${principal.profileImg != null}">
								 <img class="nav-profile" src="${principal.profileImg}">
								</c:when>
								<c:otherwise>
									<a class="profile-area" href="#"> <img class="nav-profile" src="/images/profile/profile.png">
								</a>
								</c:otherwise>
							</c:choose>
							</c:when>
							<c:otherwise>
								<li class="nav-login"><a class="nav-link" href="/user/sign-in">로그인</a></li>
								<li class="nav-login"><a class="nav-link" href="/user/sign-up">회원가입</a></li>
							</c:otherwise>
						</c:choose>

					</div>
				</nav>


			<!-- 검색 관련 코드  -->
			<div id="cover">
				<form method="get" action="" class="search-form">
					<div class="search-tb">
						<div class="search-td">
							<input type="text" class="search-input" placeholder="작가 또는 작품 검색">
						</div>
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

		</div>


		<!-- 애니메이션 효과를 위한 헤더 선 추가 -->
		
	<div class="sidebar">
		    <ul>
		    
		    <a href="/write/workList" class="nav-link"> 
				<img class="pencil-icon" src="/images/layout/write.png">
				</a>
		        <li><a href="/user/myPage">내 정보</a></li>
		        <li><a href="#">보유 JAM: 0 </a></li>
		        <li><a href="#">JAM 충전하기</a></li>		  
		        <li><a href="#">설정</a></li>
		        <li><a href="#" id="chat-link">채팅</a></li>
		        <li><a href="/qna/list"> Q&A</a></li>
		        <li><a href="/user/logout">로그아웃</a></li>
		        <br>
		        <c:if test="${principal.role eq 'admin'}">
		        <li><a href="/staff">관리자 페이지</a></li>
		        </c:if>
		    </ul>
	</div>
	</section>	
		
	
	<script type="text/javascript" src="/js/header.js"></script>
	
</header>

