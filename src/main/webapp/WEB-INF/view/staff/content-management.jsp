<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>콘텐츠 관리</title>
<link rel="stylesheet" href="/css/staff.css">
</head>
<body>
	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1>콘텐츠 관리</h1>

		<!-- 프로젝트 검토 테이블 -->
		<section class="section-content">
			<h2>프로젝트 검토</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>프로젝트명</th>
						<th>제작자</th>
						<th>기간</th>
						<th>달성목표(%)</th>
						<th>최소 제작 비용</th>
						<th>상세</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>업무자동화 프로젝트</td>
						<td>박민수</td>
						<td>2023-06-28 ~ 2023-08-10</td>
						<td>80%</td>
						<td>₩1,500,000</td>
						<td><button class="openProjectModalBtn" data-id="1">[상세]</button></td>
						<td>승인</td>
					</tr>
					<tr>
						<td>디자인 리뉴얼</td>
						<td>이혜진</td>
						<td>2023-07-01 ~ 2023-07-30</td>
						<td>55%</td>
						<td>₩800,000</td>
						<td><button class="openProjectModalBtn" data-id="2">[상세]</button></td>
						<td>대기</td>
					</tr>
				</tbody>
			</table>
		</section>

		<!-- 모달 구조 -->
		<div id="projectModal" class="modal" style="display: none;">
			<div class="modal-content">
				<span class="close">&times;</span>
				<h2>프로젝트 검토 상세 페이지</h2>
				<div class="modal-body">
					<div class="modal-left">
						<h3>리워드 구성 및 목록</h3>
						<div class="image-large">[이미지]</div>
						<div class="image-small-container">
							<div class="image-small">[이미지]</div>
							<div class="image-small">[이미지]</div>
						</div>
						<div class="message-box">
							<textarea placeholder="전달 메시지"></textarea>
							<button class="send-button">전송</button>
						</div>
					</div>
					<div class="modal-right">
						<h3>작품 정보</h3>
						<table class="info-table">
							<tr>
								<th>항목</th>
								<th>세부 사항</th>
							</tr>
							<tr>
								<td>프로젝트명</td>
								<td id="modal-project-name">[프로젝트명]</td>
							</tr>
							<tr>
								<td>제작자</td>
								<td id="modal-creator">[제작자]</td>
							</tr>
							<tr>
								<td>기간</td>
								<td id="modal-period">[기간]</td>
							</tr>
							<tr>
								<td>달성 목표</td>
								<td id="modal-goal">[목표]</td>
							</tr>
							<tr>
								<td>최소 제작 비용</td>
								<td id="modal-budget">[제작 비용]</td>
							</tr>
							<tr>
								<td>업체명</td>
								<td id="modal-company">[업체명]</td>
							</tr>
							<tr>
								<td>연락 담당자</td>
								<td id="modal-contact">[연락처]</td>
							</tr>
							<tr>
								<td>전달 사항</td>
								<td id="modal-note">[전달 사항]</td>
							</tr>
						</table>
						<div class="modal-actions">
							<button class="modal-btn approve">승인</button>
							<button class="modal-btn hold">대기</button>
							<button class="modal-btn reject">거부</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div id="contentModal" class="modal" style="display: none;">
			<div class="modal-content">
				<span class="close">&times;</span>
				<h2>작품 검토 상세 페이지</h2>
				<div class="modal-body">
					<!-- Left Section -->
					<div class="modal-left">
						<h3>메인 이미지</h3>
						<div class="image-large">[image]</div>
						<div class="image-small-container">
							<div class="image-small">[image]</div>
							<div class="image-small">[image]</div>
						</div>
						<div class="message-box">
							<textarea placeholder="전달 메시지"></textarea>
							<button class="send-button">전송</button>
						</div>
					</div>
					<!-- Right Section -->
					<div class="modal-right">
						<h3>작품 정보</h3>
						<table class="info-table">
							<tr>
								<th>항목</th>
								<th>세부 사항</th>
							</tr>
							<tr>
								<td>작품명</td>
								<td id="modal-project-name">[작품명]</td>
							</tr>
							<tr>
								<td>연령등급</td>
								<td id="modal-age">[연령등급]</td>
							</tr>
							<tr>
								<td>작가</td>
								<td id="modal-creator">[작가]</td>
							</tr>
							<tr>
								<td>활동명</td>
								<td id="modal-period">[활동명]</td>
							</tr>
							<tr>
								<td>일정 기간</td>
								<td id="modal-schedule">[일정 기간]</td>
							</tr>
							<tr>
								<td>목적</td>
								<td id="modal-goal">[목적]</td>
							</tr>
							<tr>
								<td>한줄 요약</td>
								<td id="modal-note">[한줄 요약]</td>
							</tr>
						</table>
						<div class="modal-actions">
							<button class="modal-btn approve">승인</button>
							<button class="modal-btn hold">대기</button>
							<button class="modal-btn reject">거부</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 진행 중인 작업 섹션 -->
		<section class="section-content">
			<h2>작업 진행</h2>
			<table class="content-table">
				<thead>
					<tr>
						<th>작업명</th>
						<th>직원명</th>
						<th>프로젝트</th>
						<th>기간</th>
						<th>예산</th>
						<th>상세</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>배너 디자인 작업</td>
						<td>이수민</td>
						<td>업무자동화 프로젝트</td>
						<td>2023-06-30 ~ 2023-07-15</td>
						<td>₩500,000</td>
						<td><button class="openContentModalBtn" data-id="1">[상세]</button></td>
						<td>승인</td>
					</tr>
					<tr>
						<td>UI 리뉴얼</td>
						<td>홍길동</td>
						<td>디자인 리뉴얼</td>
						<td>2023-07-10 ~ 2023-08-10</td>
						<td>₩1,000,000</td>
						<td><button class="openContentModalBtn" data-id="2">[상세]</button></td>
						<td>대기</td>
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
