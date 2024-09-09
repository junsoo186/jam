<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <link rel="stylesheet" href="/css/signIn.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        main {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .nav-menu {
            display: flex;
            justify-content: space-around;
            background-color: #f26230;
            padding: 10px 0;
            margin-bottom: 20px;
        }
        .nav-menu li {
            list-style: none;
        }
        .nav-menu a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .nav-menu a:hover {
            color: #ffdab9;
        }
        .profile-section {
            background-color: #ffe6e6;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .profile-info, .profile-image {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
       .profile-image {
	        width: 150px;  /* 부모 요소의 너비 */
	        height: 150px; /* 부모 요소의 높이 */
	        border-radius: 50%; /* 둥근 모양을 유지 */
	        overflow: hidden; /* 이미지가 둥근 영역 안에 맞춰지도록 */
	        border: 2px solid #007bff; /* 선택적으로 테두리 추가 */
	        display: flex;
	        align-items: center; /* 이미지가 중앙에 위치하도록 수직 정렬 */
	        justify-content: center; /* 이미지가 중앙에 위치하도록 수평 정렬 */
        }

        .form-label {
            font-weight: bold;
            width: 150px;
        }
        .info-section {
            background-color: #ffe6e6;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .info-item {
            margin-bottom: 10px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
            padding-top: 10px;
        }
        .action-buttons a {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .action-buttons a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<main>
    <!-- 네비게이션 메뉴 -->
    <ul class="nav-menu">
        <li><a href="#">회원 관리</a></li>
        <li><a href="/pay/paylist">결제 내역</a></li>
        <li><a href="#">차단 관리</a></li>
        <li><a href="#">이벤트 내역</a></li>
    </ul>

    <!-- 프로필 정보 섹션 -->
    <div class="profile-section">
        <div class="profile-info">
        
        <div class="profile-image">
                <img alt="Profile Image" src="${principal.profileImg}">
            </div>
            <div>
                <div class="info-item">닉네임: ${principal.nickName}</div>
                <div class="info-item">이메일: ${principal.email}</div>
                <div class="info-item">전화번호: ${principal.phoneNumber}</div>
                <div class="info-item">
                    주소: 
                    <c:if test="${principal.address eq null}">
                        정보없음
                    </c:if>
                    <c:if test="${principal.address ne null}">
                        ${principal.address}
                    </c:if>
                </div>
                <div class="info-item">
                    생일: 
                    <c:if test="${principal.birthDate eq null}">
                        정보없음
                    </c:if>
                    <c:if test="${principal.birthDate ne null}">
                        ${principal.birthDate}
                    </c:if>
                </div>
                <div class="info-item">
                    포인트: 
                    <c:if test="${principal.point eq null}">
                        정보없음
                    </c:if>
                    <c:if test="${principal.point ne null}">
                        ${principal.point}
                    </c:if>
                </div>
            </div>
        </div>
        <div class="action-buttons">
            <a href="/user/myProfileModify">수정하기</a>
        </div>
    </div>

    <!-- 펀딩 구분 섹션 -->
    <div class="info-section">
        <div class="info-item">
            <a href="#">펀딩 사업자 등록
