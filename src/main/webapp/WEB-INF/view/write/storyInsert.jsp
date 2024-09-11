<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/storyInsert.css">

<main>
<div class="content--container">
    <h1>회차 생성</h1>
    <div class="content--area">
        <form action="/write/storyInsert" method="post">
            
            <!-- 상단에 '내용 전' 섹션 -->
            <div class="top--section">
                <div class="content--number">
                    <label for="number">회차 번호:</label>
                    <input type="number" id="number" name="number" value="123" />
                </div>
                <div class="content--type">
                    <label for="type">유형:</label>
                    <select id="type" name="type">
                        <option value="프롤로그" selected>프롤로그</option>
                        <option value="무료">무료</option>
                        <option value="유료">유료</option>
                    </select>
                </div>
                <div class="content--title">
                    <label for="title">제목:</label>
                    <input type="text" id="title" name="title" value="testTitle" />
                </div>
                <div class="content--day">
                    <label for="uploadDay">업로드 날짜:</label>
                    <input type="date" id="uploadDay" name="uploadDay" value="2024-01-01" />
                </div>
                <div class="content--save">
                    <label for="save">저장 여부:</label>
                    <input type="checkbox" id="save" name="save" checked />
                </div>
                <div class="content--cost">
                    <label for="cost">비용:</label>
                    <input type="number" id="cost" name="cost" value="1000" />
                </div>
            </div>

            <!-- 중간에 '내용' 입력 필드 -->
            <div class="middle-section">
                <div class="story">
                    <label for="contents">내용:</label>
                    <textarea id="contents" name="contents" placeholder="소설 작성전 안내사항"></textarea>
                </div>
            </div>

            <!-- 하단 버튼 영역 -->
            <div class="btn--area">
                <input type="hidden" name="bookId" value="${bookId}">
                <button type="submit" id="btnInsert">회차 등록</button>
            </div>
        </form>
    </div>
   </div>
</main>
