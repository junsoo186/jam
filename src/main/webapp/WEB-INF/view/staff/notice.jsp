<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 관리</title>
<link rel="stylesheet" href="/css/staff.css">
<!-- 외부 스타일시트 연결 -->
</head>
<body>

	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1 class="content-title">공지사항</h1>

		<!-- 공지사항 테이블 -->
		<section class="section-content">
			<div class="header-row">
				<h2>공지사항 목록</h2>
				<button id="openNoticeModal" class="left--modal--btn">공지 등록</button>
			</div>
			
			<!-- 공지 사항 등록 -->
			<div id="noticeModal" class="modal" style="display: none;">
				<div class="modal-content">
					<span class="close">&times;</span>
					<h3>공지사항 등록</h3>
					<form id="noticeForm">
						<label for="notice-title">공지 제목:</label> 
						<input type="text" id="notice-title" name="notice-title" placeholder="공지 제목을 입력하세요">
						
						<label for="notice-category">공지 구분:</label>
						<select id="notice-category" name="notice-category">
							<option value="일반">일반</option>
							<option value="이벤트">이벤트</option>
						</select>
						<br>
						<label for="notice-description">공지 내용:</label>
						<textarea id="notice-description" name="notice-description" rows="5" placeholder="공지 내용을 입력하세요"></textarea>

						<button type="submit">공지 등록</button>
					</form>
				</div>
			</div>

			<table class="content-table">
				<thead>
					<tr>
						<th>등록일</th>
						<th>구분</th>
						<th>내용</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>2023-08-23</td>
						<td>이벤트</td>
						<td>&lt;공지내용&gt;</td>
						<td>
							<button class="btn btn-edit">수정</button>
						</td>
					</tr>
					<tr>
						<td>2023-08-30</td>
						<td>일반</td>
						<td>&lt;공지내용&gt;</td>
						<td>
							<button class="btn btn-edit">수정</button>
						</td>
					</tr>
				</tbody>
			</table>
		</section>
	</div>

</body>
</html>
