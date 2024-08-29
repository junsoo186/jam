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
		<section class="center-category">
			<ul>
				<li><a href="">베스트 10</a><li>
				<li><a href="">나의 찜목록</a><li>
				<li><a href="">오늘의 펀딩</a><li>
			</ul>
		</section>
		
	</div>

</header>
