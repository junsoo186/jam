<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp" %>

<body>
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
                        <th>달성목표</th>
                        <th>상세</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody id="project-list">
                    <!-- 프로젝트 목록이 여기에 동적으로 추가됨 -->
                </tbody>
            </table>
        </section>

        <!-- 모달 컨테이너 -->
        <div id="modalContainer">
            <!-- 모달 콘텐츠가 외부 JSP에서 로드됨 -->
        </div>

        <!-- 페이지네이션 버튼 영역 -->
        <div class="pagination-container" style="text-align: center; padding: 20px;">
            <!-- 페이지 번호 버튼이 여기에 동적으로 추가됩니다 -->
        </div>
    </div>

    <!-- 페이징 및 모달 처리용 스크립트 -->
    <script src="/js/staff/content.js"></script>
</body>

</html>
