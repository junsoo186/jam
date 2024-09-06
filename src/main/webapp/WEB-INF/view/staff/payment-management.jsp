<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>결제 및 금융관리</title>
</head>
<body>

	<div class="container">
		<h1>결제 및 금융관리</h1>

		<!-- 금융별 결제 상태 -->
		<div class="section">
			<h2>금융 및 결제 상태</h2>
			<table>
				<thead>
					<tr>
						<th>날짜</th>
						<th>트랜잭션ID</th>
						<th>사용자</th>
						<th>코인 수</th>
						<th>결제유형</th>
						<th>금액</th>
						<th>상태</th>
						<th>상세</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>2024-09-01</td>
						<td>T002894762</td>
						<td>사용자1</td>
						<td>100코인</td>
						<td>신용 카드</td>
						<td>10,000원</td>
						<td>완료</td>
						<td><button class="detail-pay-btn" data-url="/staff/payDetail">[상세보기]</button></td>
					</tr>
					<!-- 더 많은 데이터 추가 -->
				</tbody>
			</table>
		</div>

		<!-- 환불금 관리 -->
		<div class="section">
			<h2>후원금 관리</h2>
			<table>
				<thead>
					<tr>
						<th>날짜</th>
						<th>트랜잭션ID</th>
						<th>후원자</th>
						<th>후원금액</th>
						<th>펀딩프로젝트</th>
						<th>상태</th>
						<th>상세</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>2024-08-26</td>
						<td>T002894763</td>
						<td>70,230</td>
						<td>자동환불</td>
						<td>완료</td>
						<td>일반</td>
						<td><button class="detail-donation-btn" data-url="/staff/donationDetail">[상세보기]</button></td>
					</tr>
					<!-- 더 많은 데이터 추가 -->
				</tbody>
			</table>
		</div>
	</div>

	<div id="payModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close">&times;</span>
			<div id="payModalBody">
				<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
			</div>
		</div>
	</div>

	<div id="donationModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close">&times;</span>
			<div id="donationModalBody">
				<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
			</div>
		</div>
	</div>
	
</body>
</html>
