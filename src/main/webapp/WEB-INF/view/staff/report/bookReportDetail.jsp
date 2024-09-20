<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <link rel="stylesheet" href="/css/staff/reportDetail.css">
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <title>책 신고 상세보기</title>
            </head>

            <body>
                <h2 class="modal--h2">책 신고 상세보기</h2>
                <p><b>책 제목:</b> ${report.bookTitle}</p>
                <p><b>작가:</b> ${report.bookAuthor}</p>
                <p><b>신고자:</b> ${report.userName}</p>
                <p><b>신고 내용:</b> ${report.periodContent}</p>
                <p><b>신고일:</b>
                    <fmt:formatDate value="${report.createdAt}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" />
                </p>
                <p><b>처리 상태:</b> ${report.processing}</p>
                <p><b>처리한 관리자:</b>
                    <c:choose>
                        <c:when test="${not empty report.adminName}">
                            ${report.adminName}
                        </c:when>
                        <c:otherwise>
                            미 처리
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><b>책의 누적 신고 횟수:</b> ${report.bookReportCount}</p>

                <!-- 처리 상태가 'Y'인 경우 처리 날짜와 기간 출력 -->
                <c:if test="${report.processing == 'Y'}">
                    <p><b>처리 일자:</b>
                        <fmt:formatDate value="${report.processedAtDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" />
                    </p>
                    <p><b>해제 일자:</b>
                        <c:choose>
                            <c:when test="${report.periodDate == 0}">
                                영구
                            </c:when>
                            <c:otherwise>
                                <fmt:formatDate value="${report.releasedDate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                            </c:otherwise>
                        </c:choose>
                    </p>
                </c:if>

                <!-- 처리 상태가 'N'인 경우에만 승인 및 반려 버튼 표시 -->
                <c:if test="${report.processing == 'N'}">
                    <form id="reportProcessForm" method="POST" action="/staff/processReport">
                        <label for="reportId">책 제목 :</label>
                        <input type="text" value="${report.bookTitle}" readonly>
                        <input type="hidden" id="reportId" name="reportId" value="${report.reportId}" readonly>

                        <label for="period">처리 기간:</label>
                        <select id="period" name="period">
                            <option value="1">1일</option>
                            <option value="7">7일</option>
                            <option value="30">30일</option>
                            <option value="100">100일</option>
                            <option value="365">1년</option>
                            <option value="0">영구</option>
                        </select>

                        <label for="alerts">경고 내용:</label>
                        <select id="alerts" name="alertId">
                            <c:forEach var="alert" items="${alerts}">
                                <option value="${alert.alertId}">${alert.alertContent}</option>
                            </c:forEach>
                        </select>

                        <button type="submit">승인</button>
                    </form>

                    <!-- 반려 버튼을 위한 새로운 폼 -->
                    <form id="reportRejectForm" method="POST" action="/staff/rejectReport" style="margin-top: 20px;">
                        <input type="hidden" id="reportId" name="reportId" value="${report.reportId}">
                        <button type="submit" class="reject-btn">반려</button>
                    </form>

                    <form>
                        <input type="hidden" id="reportId" name="bookId" value="${report.bookId}">
                        <button type="submit" class="reject-btn">임시 이미지 변경</button>
                    </form>
                </c:if>

            </body>

            </html>