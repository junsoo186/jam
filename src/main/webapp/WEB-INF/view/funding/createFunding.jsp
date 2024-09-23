<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <link rel="stylesheet" href="/css/funding/create.css">

                <body>
                    <main>
                        <div class="container--main--area">

                            <!-- 메인 콘텐츠 영역 -->
                            <div class="main--content--area">
                                <form id="fundingFormElement" action="/funding/createFunding" method="post"
                                    enctype="multipart/form-data">
                                    <h1>새로운 프로젝트 생성</h1>

                                    <!-- 프로젝트 제목 입력 -->
                                    <div class="form--group--area">
                                        <label for="title" class="form--label--area">프로젝트 제목:</label>
                                        <input type="text" id="title" name="title" class="form--input--text"
                                            placeholder="${bookId.title}" required>
                                    </div>

                                    <!-- 프로젝트 설명 입력 -->
                                    <div class="form--group--area">
                                        <label for="contents" class="form--label--area">프로젝트 설명:</label>
                                        <textarea id="editor" name="contents" class="form--textarea" rows="10" cols="80"
                                            placeholder="프로젝트의 설명을 입력하세요"></textarea>
                                    </div>

                                    <!-- 목표 금액 입력 -->
                                    <div class="form--group--area">
                                        <label for="goal" class="form--label--area">목표 금액 (원):</label>
                                        <input type="number" id="goal" name="goal" class="form--input--number" min="1"
                                            placeholder="목표 금액을 입력하세요!" required>
                                    </div>

                                    <!-- 종료 날짜 선택 -->
                                    <div class="form--group--area">
                                        <label for="dateEnd" class="form--label--area">종료 날짜:</label>
                                        <input type="date" id="dateEnd" name="dateEnd" class="form--input--date"
                                            required>
                                    </div>


                                    <!-- 프로젝트 샘플 이미지 업로드 -->
                                    <div class="form--group--area">
                                        <label for="mFile" class="form--label--area">프로젝트 샘플 이미지:</label>
                                        <input type="file" id="mFile" name="mFile" class="form--input--file"
                                            accept="image/*" multiple style="display: none;">
                                        <button type="button" id="customUploadBtn" class="btn--upload">샘플 이미지
                                            선택</button>
                                    </div>

                                    <!-- 이미지 미리보기 -->
                                    <div id="imagePreview" class="form--group--area">
                                        <h3>샘플 이미지 미리보기</h3>
                                        <div id="previewContainer"></div>
                                    </div>

                                    <!-- 한 줄 소개 -->
                                    <div class="form--group--area">
                                        <label for="onelineComment" class="form--label--area">한 줄 소개:</label>
                                        <input type="text" id="onelineComment" name="onelineComment"
                                            class="form--input--text" placeholder="이 프로젝트의 한줄 소개!" required>
                                    </div>

                                    <!-- 작성자 이름 -->
                                    <div class="form--group--area">
                                        <label for="author" class="form--label--area">작성자 이름:</label>
                                        <input type="text" id="author" name="author" class="form--input--text"
                                            value="${principal.nickName}" required>
                                    </div>

                                    <!-- 폼 제출 버튼 -->
                                    <div class="form--group--area">
                                        <button type="submit" class="btn--submit">프로젝트 생성</button>
                                    </div>
                                </form>
                            </div>

                            <!-- 리워드 추가 버튼 및 리워드 그룹 -->
                            <div id="reward-container" class="reward--container--area">
                                <div class="form--group--area">
                                    <h2>펀딩 리워드</h2>
                                    <button type="button" id="addRewardBtn" class="btn--upload">리워드 추가</button>
                                </div>
                                <div class="reward--group--area" id="reward-${status.index}">
                                    <div class="form--group--area">
                                        <label for="rewardContent-${status.index}" class="form--label--area">리워드
                                            이름:</label>
                                        <input type="text" id="rewardContent-${status.index}"
                                            name="rewards[${status.index}].content" class="form--input--text"
                                            value="${reward.rewardContent}" placeholder="리워드 내용을 입력하세요" required>
                                    </div>

                                    <div class="form--group--area">
                                        <label for="rewardPoint-${status.index}" class="form--label--area">리워드 금액
                                            (원):</label>
                                        <input type="number" id="rewardPoint-${status.index}"
                                            name="rewards[${status.index}].point" class="form--input--number" min="1"
                                            step="1000" value="${reward.rewardPoint}" placeholder="리워드 금액을 입력하세요"
                                            required>
                                    </div>

                                    <div class="form--group--area">
                                        <label for="rewardQuantity-${status.index}" class="form--label--area">리워드
                                            수량:</label>
                                        <input type="number" id="rewardQuantity-${status.index}"
                                            name="rewards[${status.index}].quantity" class="form--input--number" min="1"
                                            value="${reward.rewardQuantity}" placeholder="리워드 수량을 입력하세요" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <!-- CKEditor를 먼저 로드 -->
                    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>

                    <!-- CKEditor 로드 후 createFunding.js 로드 -->
                    <script type="text/javascript" src="/js/funding/createFunding.js"></script>
                </body>

                </html>