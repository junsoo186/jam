<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">
    <%@ include file="/WEB-INF/view/staff/main.jsp" %>
        <link rel="stylesheet" href="/css/staff/report.css">

        <body>
            <div class="main-content">
                <h1>신고 관리</h1>
                <button id="toggleProcessed" class="filter-btn">처리된 내역 숨기기</button>

                <!-- 책 신고 현황 -->
                <section class="section-content">
                    <h2>책 신고 현황</h2>
                    <button id="sortBookReportsByDate" class="sort-btn">신고된 순서대로 정렬 (책)</button>
                    <table class="content-table" id="book-report-table">
                        <thead>
                            <tr>
                                <th>책 제목</th>
                                <th>작가</th>
                                <th>신고자</th>
                                <th>신고일</th>
                                <th>처리 상태</th>
                                <th>처리한 관리자</th>
                                <th>누적 신고수 (책)</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody id="book-report-body">
                            <!-- AJAX로 데이터를 받아온 후 여기에 삽입합니다. -->
                        </tbody>
                    </table>
                </section>

                <!-- 프로젝트 신고 현황 -->
                <section class="section-content">
                    <h2>프로젝트(펀딩) 신고 현황</h2>
                    <button id="sortProjectReportsByDate" class="sort-btn">신고된 순서대로 정렬 (프로젝트)</button>
                    <table class="content-table" id="project-report-table">
                        <thead>
                            <tr>
                                <th>프로젝트 제목</th>
                                <th>신고자</th>
                                <th>신고 내용</th>
                                <th>신고일</th>
                                <th>처리 상태</th>
                                <th>처리한 관리자</th>
                                <th>누적 신고수 (프로젝트)</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody id="project-report-body">
                            <!-- AJAX로 데이터를 받아온 후 여기에 삽입합니다. -->
                        </tbody>
                    </table>
                </section>

                <!-- 사용자 신고 현황 -->
                <section class="section-content">
                    <h2>사용자 신고 현황</h2>
                    <button id="sortUserReportsByDate" class="sort-btn">신고된 순서대로 정렬 (사용자)</button>
                    <table class="content-table" id="user-report-table">
                        <thead>
                            <tr>
                                <th>신고된 사용자</th>
                                <th>신고자</th>
                                <th>신고 내용</th>
                                <th>신고일</th>
                                <th>처리 상태</th>
                                <th>처리한 관리자</th>
                                <th>누적 신고수 (사용자)</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody id="user-report-body">
                            <!-- AJAX로 데이터를 받아온 후 여기에 삽입합니다. -->
                        </tbody>
                    </table>
                </section>
            </div>

            <!-- 모달 -->
            <div id="reportContentModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <div id="reportContentModalBody">
                        <!-- 외부 JSP 내용이 여기에 동적으로 삽입됩니다. -->
                    </div>
                </div>
            </div>

            <!-- JS 추가 -->
            <script src="/js/staff/report.js"></script>
        </body>

    </html>