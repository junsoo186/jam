<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
   <!--  <link rel="stylesheet" href="/css/signIn.css"> -->
    <link rel="stylesheet" href="/css/toggleSwitch.css">    
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
                <div class="info-item">
                전화번호:
                <c:if test="${principal.phoneNumber eq null}">
                	정보없음
                </c:if>
                
                <c:if test="${principal.phoneNumber ne null}">
                	${principal.phoneNumber}
                </c:if>
                
                
                </div>
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
    
    <div>
    	 <div class="toggle-container">
	        <div class="toggle-button" id="supporterButton" onclick="toggleButton('supporter')">
	            <span>유저</span>
	        </div>
	        <div class="toggle-button" id="makerButton" onclick="toggleButton('maker')">
	            <span>작가</span>
       	   </div>
    	</div>
    </div>

    <!-- 펀딩 구분 섹션 -->
    <div class="info-section">
        <div class="info-item">
            <a href="#">펀딩 사업자 등록</a>
            
           </div>
           </div>
    </main>
<script type="text/javascript">
		

            var principalEmail = "<c:out value='${principal != null ? principal.email : ""}' />";
            
            function toggleButton(selected) {
                const supporterButton = document.getElementById('supporterButton');
                const makerButton = document.getElementById('makerButton');

                if (selected === 'supporter') {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                    
	                 // 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
	                 window.location.href = '/user/myPage'; // 컨트롤러 경로로 리다이렉트
                                        
                    // 선택된 상태를 로컬 스토리지에 저장
                    localStorage.setItem('selectedButton', 'supporter');
                    
                } else {
                    makerButton.classList.add('active');
                    supporterButton.classList.remove('active');
                    
                 	// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
                    window.location.href = '/write/workList'; // 컨트롤러 경로로 리다이렉트
                    
                    // 선택된 상태를 로컬 스토리지에 저장
                    localStorage.setItem('selectedButton', 'maker');
                    
                    
                }
            }
            
          // 페이지 로드 시 로컬 스토리지에서 선택된 버튼 상태를 불러와 유지
            window.onload = function() {
                const selectedButton = localStorage.getItem('selectedButton');
                const supporterButton = document.getElementById('supporterButton');
                const makerButton = document.getElementById('makerButton');
                
                // 로그인된 사용자의 email이 있을 경우 "유저" 버튼을 활성화
                if (!selectedButton && principalEmail !== "") {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                    sessionStorage.setItem('selectedButton', 'supporter'); // 기본값으로 저장
                } else if (selectedButton === 'supporter') {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                } else if (selectedButton === 'maker') {
                    makerButton.classList.add('active');
                    supporterButton.classList.remove('active');
                }
            }    
            
</script>