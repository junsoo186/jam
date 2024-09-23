<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
					<li><a href="/staff/dashboard">대시보드</a></li>
					<li><a href="/staff/report-page">신고 관리</a></li>
					<li><a href="/pay/payment-page">결제 및 금융관리</a></li>
					<li><a href="/staff/content-page">컨텐츠 관리</a></li>
				</ul>
			</div>

			<div class="section">
				<h4>고객지원</h4>
				<ul>
					<li><a href="/staff/qnaPage">Q&A</a></li>
					<li><a href="/staff/notice">공지사항</a></li>
					<li><a href="/staffEvent/list">이벤트</a></li>
					<li><a href="chat-link">채팅</a></li>
				</ul>
			</div>
		</div>
		<script>
			document.getElementById('mainButton').addEventListener('click', function () {
				window.location.href = '/';
			});
		</script>
	</body>

<<<<<<< HEAD
	<!-- 동적으로 콘텐츠가 표시될 영역 -->
	<div id="content"></div>

	<script type="text/javascript" src="/js/staff/app.js"></script>
	<script type="text/javascript" src="/js/staff/menu.js"></script>
	<script type="text/javascript" src="/js/staff/modal.js"></script>
	<script type="text/javascript" src="/js/staff/chat.js"></script>
	<script type="text/javascript" src="/js/staff/data.js"></script>
	
	
	<script type="text/javascript">
		const sectionUrl = `${sectionUrl}`;
	</script>
	<script type="text/javascript" src="/js/navigation.js"></script>
</body>
</html>
=======
	</html>
>>>>>>> sub-dev
