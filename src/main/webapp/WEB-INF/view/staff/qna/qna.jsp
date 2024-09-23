<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp"%>
<body>

    <!-- 메인 콘텐츠 영역 -->
    <div class="main-content">
        <h1 class="content-title">고객지원 Q&A 문의</h1>

        <!-- Q&A 문의 테이블 -->
        <section class="section-content">
            <h2>Q&A 문의</h2>
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="검색어를 입력하세요" class="search-input">
                <button class="search-btn" id="searchBtn">검색</button>
            </div>
            <table class="content-table">
                <thead>
                    <tr>
                        <th>작성일</th>
                        <th>사유</th>
                        <th>상담자</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody id="qnaTableBody">
                    <!-- 동적으로 Q&A 데이터가 추가됩니다 -->
                </tbody>
            </table>
        </section>

        <!-- 페이징 처리 영역 -->
        <div id="pagination" class="pagination-container">
            <!-- 페이지 번호가 동적으로 추가됩니다 -->
        </div>
    </div>

    <!-- QnA 상세 모달 -->
    <div id="qnaModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <div id="modalBody">
                <!-- qnaDetail.jsp가 여기 로드됩니다 -->
            </div>
        </div>
    </div>

    <script src="/js/staff/qna.js"></script>
</body>
</html>
