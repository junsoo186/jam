<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고 상세 페이지</title>
    <link rel="stylesheet" href="/css/reportDetail.css">
</head>
<body>
    <!-- 메인 콘텐츠 영역 -->
    <div class="main-content">
        <h1>작품 신고 상세 페이지</h1>

        <!-- 신고 내용 -->
        <section class="section-content">
            <h2>신고 내용</h2>
            <table class="content-table">
                <thead>
                    <tr>
                        <th>항목</th>
                        <th>세부 사항</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>날짜</td>
                        <td>2024-08-25 14:30</td>
                    </tr>
                    <tr>
                        <td>신고자</td>
                        <td>망이</td>
                    </tr>
                    <tr>
                        <td>신고 사유</td>
                        <td>기타</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>작품에 유해 요소가 있습니다. 19금으로 변경 요청합니다.</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <!-- 신고 작품 -->
        <section class="section-content">
            <h2>신고 작품</h2>
            <table class="content-table">
                <thead>
                    <tr>
                        <th>항목</th>
                        <th>세부 사항</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>날짜</td>
                        <td>2024-08-25 14:30</td>
                    </tr>
                    <tr>
                        <td>신고 작품</td>
                        <td>망기 진짜멋지다 네고싶어졌습니다</td>
                    </tr>
                    <tr>
                        <td>회차</td>
                        <td>1화 - 내가 네고싶어?</td>
                    </tr>
                    <tr>
                        <td>상태</td>
                        <td>활동중</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <!-- 추가 메시지 -->
        <section class="section-content">
            <h2>전달 메시지</h2>
            <table class="content-table">
                <thead>
                    <tr>
                        <th>정지기간</th>
                        <th>전달 메시지</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2024-08-25 14:30 ~ 2024-08-25 14:30</td>
                        <td><textarea rows="" cols="">작품의 이미지가 심의에 일치하지 않습니다. 임시 이미지로 교체하겠습니다.</textarea></td>
                    </tr>
                </tbody>
            </table>
        </section>

        <!-- 버튼들 -->
        <div class="action-buttons">
            <button class="action-btn danger">영구정지</button>
            <button class="action-btn">기간정지</button>
            <button class="action-btn">메시지 전달</button>
            <button class="action-btn">임시이미지로 변경</button>
        </div>
    </div>

</body>
</html>
