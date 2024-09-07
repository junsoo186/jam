<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>대시보드</title>
<!-- 외부 CSS 파일 -->
</head>
<body>
	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1>대시보드</h1>

		<!-- 오늘의 현황 박스 -->
		<div class="status-box">
			<h3>오늘의 현황</h3>
			<ul>
				<li>신규 제안: <span>0</span></li>
				<li>환불이슈: <span>0</span></li>
				<li>환불 대기: <span>0</span></li>
				<li>업데이트: <span>0</span></li>
			</ul>
		</div>

		<!-- 프로젝트 현황 테이블 -->
		<div class="project-status">
			<h3>프로젝트 현황</h3>
			<table>
				<thead>
					<tr>
						<th>프로젝트명</th>
						<th>제작자</th>
						<th>기간</th>
						<th>완료율</th>
						<th>예산</th>
						<th>수수료</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>애니메이션 제작 프로젝트</td>
						<td>홍길동</td>
						<td>2023-06-01 ~ 2023-09-01</td>
						<td>100%</td>
						<td>₩5,000,000</td>
						<td>₩500,000</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<script src="/js/dashboard.js"></script>
	<!-- 외부 JS 파일 -->
</body>
</html>