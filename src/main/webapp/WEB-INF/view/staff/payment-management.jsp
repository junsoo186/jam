<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
									<tbody>
										<c:forEach var="pay" items="${payList}">
											<tr>
												<td>${pay.createdAt}</td>
												<td>${pay.paymentKey}</td>
												<td>${pay.email}</td>
												<td>신용 카드</td>
												<td>${pay.refundAmount}원</td>
												<td>${pay.status}</td>
												<td><button class="detail-pay-btn" data-url="/pay/payDetail"
														data-refund-id="${pay.refundId}">[상세보기]</button>
												</td>
											</tr>
										</c:forEach>
										<!-- 더 많은 데이터 추가 -->
									</tbody>
								</table>
								<div id="pagination">
									<c:forEach var="i" begin="1" end="${totalPages}">
										<button onclick="loadPaymentManagement(${i}, ${pageSize})">${i}</button>
									</c:forEach>
								</div>
							</c:when>
							<c:otherwise>
								<p>환불 신청 내역 없음</p>
							</c:otherwise>
						</c:choose>
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
									<td><button class="detail-donation-btn"
											data-url="/staff/donationDetail">[상세보기]</button>
									</td>
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
				<script src="/js/pay/payment.js"></script>
			</body>

			</html>