<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp"%>
<body>

    <!-- 메인 콘텐츠 영역 -->
    <div class="main-content">
        <h1 class="content-title">고객지원 Q&A문의</h1>

        <!-- Q&A 문의 테이블 -->
        <section class="section-content">
            <h2>Q&A문의</h2>
            <div class="search-bar">
                <input type="text" placeholder="검색어를 입력하세요" class="search-input">
                <button class="search-btn">검색</button>
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
                <tbody>
                    <tr>
                        <td>2023-08-23</td>
                        <td>계정 비활성화 문제</td>
                        <td>관리자1</td>
                        <td><span class="status-label blue">답변 완료</span></td>
                        <td>
                            <button class="btn btn-view">보기</button>
                            <button class="btn btn-edit">수정</button>
                            <button class="btn btn-delete">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2023-08-24</td>
                        <td>비밀번호 변경 문의</td>
                        <td>관리자2</td>
                        <td><span class="status-label green">진행 중</span></td>
                        <td>
                            <button class="btn btn-view">보기</button>
                            <button class="btn btn-edit">수정</button>
                            <button class="btn btn-delete">삭제</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>
    </div>

</body>
</html>
