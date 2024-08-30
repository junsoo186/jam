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
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" href="/css/common.css">
</head>
<body>
<header>

	<div class= "top-area">
		<nav class="top-nav">
			<div class="top-logo">
				<a href="/"></a>
			</div>
	
			<div class="nav-item">

			
			
				<c:choose>
					<c:when test="${principal != null}">
						<%-- 사용자가 로그인 상태  --%>
								<label><a href="/write/workList" class="nav-link" >글쓰기</a></label>
				<li class="nav-profile"><a class="nav-profile" href="#">프로필</a></li>
					</c:when>
					<c:otherwise>
						<%-- 사용자가 로그인 안된 상태  --%>
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
				<li><a href="">공지사항</a><li>
			</ul>
		</section>
	</div>
		
		
			<!-- 애니메이션 효과를 위한 헤더 선 추가 -->

		
		
		
		<!-- 사이드바 추가 -->
	<div class="sidebar">
		    <ul>
		        <li><a href="#">내 정보</a></li>
		        <li><a href="#">보유 JAM: 0 </a></li>
		        <li><a href="#">JAM 충전하기</a></li>		  
		        <li><a href="#">설정</a></li>
		        <li><a href="#">1:1 채팅</a></li>
		        <li><a href="/qna/list"> Q&A</a></li>
		        <li><a href="/user/logout">로그아웃</a></li>
		    </ul>
	</div>
		
		
	
	<script type="text/javascript" src="/js/header.js"></script>
	
</header>
