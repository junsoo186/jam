<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>콘텐츠 관리 페이지</title>
<link rel="stylesheet" href="/css/staff.css">
</head>
<body>

	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1 class="content-title">콘텐츠 관리</h1>

		<!-- 진행 중인 프로젝트 섹션 -->
		<section class="section-content">
			<h2>진행중인 프로젝트</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>프로젝트명</th>
						<th>직원</th>
						<th>기간</th>
						<th>완료율</th>
						<th>예산</th>
						<th>수수료</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>업무 프로젝트</td>
						<td>김지원</td>
						<td>2023-06-28 ~ 2023-08-10</td>
						<td>80%</td>
						<td>₩1,500,000</td>
						<td>₩30,000</td>
					</tr>
				</tbody>
			</table>
		</section>

		<!-- 진행 중인 작업 섹션 -->
		<section class="section-content">
			<h2>진행중인 작업</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>작업명</th>
						<th>직원</th>
						<th>프로젝트</th>
						<th>상태</th>
						<th>예산</th>
						<th>수수료</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>디자인 작업</td>
						<td>홍길동</td>
						<td>2023-07-01 ~ 2023-07-30</td>
						<td>진행중</td>
						<td>₩500,000</td>
						<td>₩15,000</td>
					</tr>
				</tbody>
			</table>
		</section>

		<!-- 하단 작업 상태와 버튼 -->
		<div class="bottom-content">
			<table class="bottom-table">
				<tr>
					<td>업체 관리</td>
					<td>작업 완료</td>
					<td>프로젝트 찾기</td>
				</tr>
				<tr>
					<td>1</td>
					<td>1</td>
					<td>1</td>
				</tr>
			</table>
			<button class="confirm-button">확인</button>
		</div>
	</div>
</body>
</html>