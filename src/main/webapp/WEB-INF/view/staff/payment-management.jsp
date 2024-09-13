<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>결제 및 금융관리</title>
			</head>

			<body>
				<div class="container">
					<h1>결제 및 금융관리</h1>

					<!-- 환불 요청 -->
					<div class="section">
						<h2>환불 요청</h2>
						<c:choose>
							<c:when test="${payList ne null and not empty payList}">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th>트랜잭션ID</th>
											<th>사용자</th>
											<th>결제유형</th>
											<th>금액</th>
											<th>상태</th>
											<th>상세</th>
										</tr>
									</thead>
									<tbody id="paymentTableBody">
										<!-- 데이터가 여기에 로드됨 -->
									</tbody>
								</table>
								<div id="pagination">
									<!-- 페이지네이션은 JavaScript에서 동적으로 처리 -->
								</div>
							</c:when>
							<c:otherwise>
								<p>환불 신청 내역 없음</p>
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 후원금 관리 -->
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
								<c:forEach var="donation" items="${donationList}">
									<tr>
										<td>${donation.createdAt}</td>
										<td>${donation.transactionId}</td>
										<td>${donation.donorName}</td>
										<td>${donation.amount}원</td>
										<td>${donation.projectName}</td>
										<td>${donation.status}</td>
										<td>
											<button class="detail-donation-btn" data-url="/staff/donationDetail"
												data-donation-id="${donation.donationId}">[상세보기]</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<!-- 페이 모달 -->
				<div id="payModal" class="modal">
					<div class="modal-content">
						<span class="close">&times;</span>
						<div id="payModalBody">
							<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
						</div>
					</div>
				</div>

				<!-- 후원 모달 -->
				<div id="donationModal" class="modal">
					<div class="modal-content">
						<span class="close">&times;</span>
						<div id="donationModalBody">
							<!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
						</div>
					</div>
				</div>

			</body>

			</html>