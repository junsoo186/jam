<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="/css/staff.css">
</head>
<body>
	<div class="header">
		<h1>고객지원 이벤트</h1>
		<button class="logout-button" id="mainButton">나가기</button>
	</div>

	<div class="sidebar">
		<h2>관리자 페이지</h2>
		<h3>MENU</h3>
		<div class="section">
			<h4>사이트 관리</h4>
			<ul>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/dashboard">대시보드</a></li>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/report">신고 및 작품관리</a></li>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/payment-management">결제 및 금융관리</a></li>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/content-management">컨텐츠 관리</a></li>
			</ul>
		</div>

		<div class="section">
			<h4>고객지원</h4>
			<ul>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/qna">Q&A</a></li>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/notice">공지사항</a></li>
				<li><a href="javascript:void(0);" class="menu-link" data-url="/staff/event">이벤트</a></li>
				<li><a href="javascript:void(0);" class="menu-link"  id="chat-link">채팅</a></li>
			</ul>
		</div>
	</div>

	<!-- 동적으로 콘텐츠가 표시될 영역 -->
	<div id="content"></div>
	<script type="text/javascript">
		const sectionUrl = `${sectionUrl}`;
	</script>
	<script type="text/javascript" src="/js/navigation.js"></script>
</body>
</html>
