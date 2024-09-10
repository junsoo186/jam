<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>펀딩 프로젝트 생성</title>
<link rel="stylesheet" href="/css/funding/create.css">
<script src="/js/funding/create.js" defer></script>
</head>
<body>
    <h1>새로운 펀딩 프로젝트 생성</h1>

    <div class="container">
        <!-- 리워드 카드 영역 -->
        <div id="reward-card-container" class="reward-card-container">
            <h2>리워드 목록</h2>
            <div id="reward-list">
                <!-- 리워드 카드가 여기에 동적으로 추가됩니다 -->
            </div>
        </div>

        <div class="form-container">
            <form action="/funding/create" method="post" enctype="multipart/form-data">
                <!-- 프로젝트 제목 입력 -->
                <div class="form-group">
                    <label for="title">프로젝트 제목:</label>
                    <c:choose>
                        <c:when test="${book.title ne null}">
                            <input type="text" id="title" name="title" placeholder="${book.title}" required>
                        </c:when>
                        <c:otherwise>
                            <input type="text" id="title" name="title" placeholder="프로젝트 제목을 입력하세요" required>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 프로젝트 설명 입력 -->
                <div class="form-group">
                    <label for="description">프로젝트 설명:</label>
                    <textarea id="description" name="description" rows="5" placeholder="프로젝트 설명을 입력하세요" required></textarea>
                </div>

                <!-- 목표 금액 입력 -->
                <div class="form-group">
                    <label for="goalAmount">목표 금액 (원):</label> 
                    <input type="number" id="goalAmount" name="goalAmount" min="1" step="1000" placeholder="목표 금액을 입력하세요" required>
                </div>

                <!-- 종료 날짜 선택 -->
                <div class="form-group">
                    <label for="endDate">종료 날짜:</label> 
                    <input type="date" id="endDate" name="endDate" required>
                </div>

                <!-- 프로젝트 이미지 업로드 -->
                <div class="form-group">
                    <label for="projectImg">프로젝트 이미지:</label> 
                    <input type="file" id="projectImg" name="projectImg" accept="image/*" required>
                </div>

                <!-- 한 줄 소개 -->
                <div class="form-group">
                    <label for="onelineComment">한 줄 소개:</label> 
                    <input type="text" id="onelineComment" name="onelineComment" placeholder="한 줄 소개를 입력하세요" required>
                </div>

                <!-- 작성자 이름 -->
                <div class="form-group">
                    <label for="author">작성자 이름:</label> 
                    <input type="text" id="author" name="author" placeholder="작성자 이름을 입력하세요" required>
                </div>

                <!-- 리워드 추가 버튼 -->
                <div class="form-group">
                    <button type="button" id="addRewardBtn">리워드 추가</button>
                </div>

                <!-- 폼 제출 버튼 -->
                <div class="form-group">
                    <button type="submit">프로젝트 생성</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
