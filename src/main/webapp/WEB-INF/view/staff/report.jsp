<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고 페이지</title>
<!-- 외부 CSS -->
</head>
<body>
	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1>신고 및 작품 관리</h1>

		<!-- 작품 신고 현황 -->
		<section class="section-content">
			<h2>작품 신고 현황</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>작품명</th>
						<th>작가</th>
						<th>등록 일자</th>
						<th>누적</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>양기 진정됐더니 신고되어있습니다</td>
						<td>어쩌구</td>
						<td>2024-08-25 14:30</td>
						<td>30건</td>
						<td>
							<button class="status-btn">일시정지</button>
							<button class="status-btn">기간정지</button>
							<button class="status-btn">경고메시지</button>
							<button class="status-btn">임시이미지변경</button>
						</td>
					</tr>
				</tbody>
			</table>
		</section>


		<!-- 작품 신고 내역 -->
		<section class="section-content">
			<h2>작품 신고 내역</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>작품명</th>
						<th>신고자</th>
						<th>신고 유형</th>
						<th>신고 사유</th>
						<th>신고일시</th>
						<th>상태</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>작품 신고된 항목 1</td>
						<td>사용자 A</td>
						<td>부적절한 콘텐츠</td>
						<td>표절 의혹</td>
						<td>2024-09-01 14:30</td>
						<td>처리중</td>
						<td><button class="detail-content-btn" data-url="/staff/reportContentDetail">[상세보기]</button></td>
					</tr>
				</tbody>
			</table>
		</section>

		<!-- 사용자 신고 내역 -->
		<section class="section-content">
			<h2>사용자 신고 내역</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>신고된 사용자</th>
						<th>신고자</th>
						<th>신고 유형</th>
						<th>신고 사유</th>
						<th>신고일시</th>
						<th>상태</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>사용자 신고 항목 1</td>
						<td>사용자 B</td>
						<td>부적절한 행동</td>
						<td>욕설</td>
						<td>2024-09-01 14:30</td>
						<td>처리중</td>
						<td><button class="detail-user-btn" data-url="/staff/reportUserDetail">[상세보기]</button></td>
					</tr>
				</tbody>
			</table>
		</section>

		<!-- 작품 관리 -->
		<section class="section-content">
			<h2>작품 관리</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>작품명</th>
						<th>작가</th>
						<th>등록일</th>
						<th>누적코인</th>
						<th>관리</th>
						<th>펀딩상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>작품 관리 항목 1</td>
						<td>작가명</td>
						<td>2024-08-26</td>
						<td>1200코인</td>
						<td>
							<button>작품페이지</button>
                            <button>이미지 변경</button>
                            <button>펀딩</button>
						</td>
						<td>판매중</td>
					</tr>
				</tbody>
			</table>
		</section>
	</div>

	<div id="reportContentModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close">&times;</span>
			<div id="reportContentModalBody">
				<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
			</div>
		</div>
	</div>
	
	<div id="reportUserModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close">&times;</span>
			<div id="reportUserModalBody">
				<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
			</div>
		</div>
	</div>
	
</body>
</html>
