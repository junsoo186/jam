<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<link rel="stylesheet" href="/css/workList.css">
<main>
    <section class="top--nav--area">
        <div class="navbar">
            <a href="#myWorks">작품관리</a>
            <a href="#supportManagement">후원관리</a>
            <a href="#workStatistics">정산</a>
            <a href="#settlement">펀딩관리</a>
        </div>
    </section>

    <section class="top--benner--area">
        <div class="benner--content">
            <img src="../images/benner/benner.jpg">
        </div>
    </section>

    <div class="top--btn--area">
        <form action="workInsert" method="get">
            <button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
        </form>
    </div>

    <!-- 동적으로 콘텐츠를 로드할 영역 -->
    <section class="center--content--container" id="content-container">
        <!-- 여기에 workListPartial.jsp가 로드될 것입니다. -->
    </section>
</main>

<script type="text/javascript" src="/js/workList.js"></script>