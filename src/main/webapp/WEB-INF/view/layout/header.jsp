<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<div class="top-area">
			<section class="center-category">
				<ul>
					<li><img class="img-rank" src="/images/layout/rank.png"><a
						href="">랭킹</a>
						<li>
					
					<li><a href="">이벤트</a>
					
					<li>
					
					<li><a href="/funding/fundingList">펀딩</a>
					
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
									<a class="profile-area" href="/#"> <img class="nav-profile"
										src="/images/profile/profile.png">
								</a>
								</c:otherwise>
							</c:choose>
							</c:when>
							<c:otherwise>
								<li class="nav-login"><a class="nav-link"
								href="/user/sign-in">로그인</a></li>
								<li class="nav-login"><a class="nav-link"
								href="/user/sign-up">회원가입</a></li>
							</c:otherwise>
						</c:choose>

					</div>
				
		</nav> <!-- 검색 관련 코드  -->
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
		        <li><a href="#">보유 JAM: <fmt:formatNumber
							value="${principal.point}" pattern="#,###" /></a></li>
		        <li><a href="/pay/toss">JAM 충전하기</a></li>		  
		        <li><a href="#">설정</a></li>
		        <li><a href="#" id="chat-link">채팅</a></li>
		        <li><a href="/qna/list"> Q&A</a></li>
		        <li><a href="/user/logout">로그아웃</a></li>
		        <br>
		        <c:if test="${principal.role eq 'admin'}">
		        <li><a href="/staff">관리자 페이지</a></li>
		        <button type="button" id="toggle-event-button">이벤트 활성화 버튼</button>
		        <button type="button" id="check-event-status-button">이벤트 상태 확인</button>
		        

		        </c:if>
		    </ul>
	</div>
		
<script>
//"이벤트 활성화 버튼"이 클릭되었을 때 이벤트 상태를 토글하는 함수
document.getElementById("toggle-event-button").addEventListener("click", function() {
    // fetch를 사용해 "/pay/toggleEvent"로 POST 요청을 보냄
    fetch("/pay/toggleEvent", { method: 'POST' })
        .then(response => {
            // 서버 응답이 성공적이면
            if (response.ok) {
                alert("이벤트 상태가 변경되었습니다.");  // 알림 메시지 출력
            } else {
                alert("이벤트 상태 변경 실패");  // 실패 시 알림 메시지 출력
            }
        });
});

//"이벤트 상태 확인" 버튼을 클릭했을 때 이벤트 상태를 확인하는 함수
document.getElementById("check-event-status-button").addEventListener("click", function() {
    // fetch를 사용해 "/pay/eventStatus"로 GET 요청을 보냄 (현재 이벤트 상태 확인)
    fetch("/pay/eventStatus")
        .then(response => response.json())  // 응답을 JSON 형식으로 받음
        .then(isEventActive => {
            // 이벤트가 활성화된 상태이면
            if (isEventActive) {
                alert("현재 이벤트 상태: 활성화");  // 이벤트 활성화 상태를 알림
            } else {
                alert("현재 이벤트 상태: 비활성화");  // 이벤트 비활성화 상태를 알림
            }
        })
        .catch(error => {
            // 오류가 발생한 경우 콘솔에 로그 출력
            console.error("이벤트 상태를 가져오는 중 오류 발생:", error);
        });
});
   
    
</script>
		
	
	<script type="text/javascript" src="/js/header.js"></script>
	
</header>

