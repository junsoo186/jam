<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고 상세 페이지</title>
<link rel="stylesheet" href="/css/reportDetail.css">
</head>
<body>

	<!-- 메인 콘텐츠 -->
	<div class="main-content">
		<h1>신고 상세 페이지</h1>

		<!-- 신고 내용 -->
		<section class="report-section">
			<h2>신고 내용</h2>
			<table class="report-table">
				<tr>
					<th>항목</th>
					<th>세부 사항</th>
				</tr>
				<tr>
					<td>날짜</td>
					<td>2024-08-25 14:30</td>
				</tr>
				<tr>
					<td>신고자</td>
					<td>맹이</td>
				</tr>
				<tr>
					<td>신고 사유</td>
					<td>기타</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>작가의 비방과 스포일러가 너무 심합니다. 정지 부탁드립니다.</td>
				</tr>
			</table>
		</section>

		<!-- 신고 대상 -->
		<section class="report-section">
			<h2>신고 대상</h2>
			<table class="report-table">
				<tr>
					<th>항목</th>
					<th>세부 사항</th>
				</tr>
				<tr>
					<td>날짜</td>
					<td>2024-08-25 14:30</td>
				</tr>
				<tr>
					<td>신고대상</td>
					<td>소프리</td>
				</tr>
				<tr>
					<td>신고 내용</td>
					<td>이거 다른 플랫폼에서 보던데 똑같이 있네요. 진짜 표절 의심됩니다.</td>
				</tr>
				<tr>
					<td>상태</td>
					<td>활동중</td>
				</tr>
			</table>
		</section>

		<!-- 전달 메시지 및 조치 -->
		<section class="action-section">
			<table class="action-table">
				<tr>
					<th>정지 기간</th>
					<th>전달 메시지</th>
				</tr>
				<tr>
					<td>2024-08-25 14:30 ~ 2024-08-25 14:30</td>
					<td>재발 방지를 위해 7일간 댓글 및 활동 금지 처분합니다.</td>
				</tr>
			</table>
			<div class="action-buttons">
				<button class="action-btn">영구정지</button>
				<button class="action-btn">기간정지</button>
				<button class="action-btn">댓글 금지</button>
			</div>
		</section>
	</div>

</body>
</html>
