<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <link rel="stylesheet" href="/css/funding/create.css">

                <body>
                    <main>
                        <div class="container--main--area">
                            <!-- 메인 이미지 미리보기 -->
                            <div class="img--preview--side">
                                <h3>메인 이미지 미리보기</h3>
                                <div id="mainImagePreview" class="img--preview--box">
                                </div>
                                <input type="file" id="mainMFile" name="mainMFile" accept="image/*"
                                    style="display: none;">
                            </div>

                            <!-- 메인 콘텐츠 영역 -->
                            <div class="main--content--area">
                                <form id="fundingFormElement" action="/funding/updateFunding" method="post"
                                    enctype="multipart/form-data">
                                    <h1>${project.title} 수정</h1>

                                    <!-- 프로젝트 제목 입력 -->
                                    <div class="form--group--area">
                                        <label for="title" class="form--label--area">프로젝트 제목:</label>
                                        <input type="text" id="title" name="title" class="form--input--text"
                                            value="${project.title}" required>
                                    </div>

                                    <!-- 프로젝트 설명 입력 -->
                                    <div class="form--group--area">
                                        <label for="contents" class="form--label--area">프로젝트 설명:</label>
                                        <textarea id="editor" name="contents" class="form--textarea" rows="10" cols="80"
                                            required><c:out value="${project.contents}" escapeXml="false"/></textarea>
                                    </div>

                                    <!-- 목표 금액 입력 -->
                                    <div class="form--group--area">
                                        <label for="goal" class="form--label--area">목표 금액 (원):</label>
                                        <input type="number" id="goal" name="goal" class="form--input--number" min="1"
                                            value="${project.goal}" required>
                                    </div>

                                    <!-- 종료 날짜 선택 -->
                                    <div class="form--group--area">
                                        <label for="dateEnd" class="form--label--area">종료 날짜:</label>
                                        <input type="date" id="dateEnd" name="dateEnd" class="form--input--date"
                                            value="${project.dateEnd}" required>
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
                                            class="form--input--text" value="${project.onelineComment}" required>
                                    </div>

                                    <!-- 작성자 이름 -->
                                    <div class="form--group--area">
                                        <label for="author" class="form--label--area">작성자 이름:</label>
                                        <input type="text" id="author" name="author" class="form--input--text"
                                            value="${principal.nickName}" required>
                                    </div>

                                    <!-- 폼 제출 버튼 -->
                                    <div class="form--group--area">
                                        <input type="hidden" id="projectId" name="projectId"
                                            value="${project.projectId}">
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
                                <c:forEach var="reward" items="${rewards}" varStatus="status">
                                    <div class="reward--group--area" id="reward-${status.index}">
                                        <div class="form--group--area">
                                            <label for="rewardContent-${status.index}" class="form--label--area">리워드
                                                이름:</label>
                                            <input type="text" id="rewardContent-${status.index}"
                                                name="rewards[${status.index}].content" class="form--input--text"
                                                value="${reward.rewardContent}" required>
                                        </div>
                                        <div class="form--group--area">
                                            <label for="rewardPoint-${status.index}" class="form--label--area">리워드 금액
                                                (원):</label>
                                            <input type="number" id="rewardPoint-${status.index}"
                                                name="rewards[${status.index}].point" class="form--input--number"
                                                min="1" step="1000" value="${reward.rewardPoint}" required>
                                        </div>
                                        <!-- 리워드 삭제 버튼 추가 -->
                                        <button type="button" class="btn--remove-reward"
                                            data-reward-id="${status.index}">X</button>

                                        <!-- 리워드 ID 숨김 필드 추가 -->
                                        <input type="hidden" name="rewards[${status.index}].rewardId"
                                            value="${reward.rewardId}">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </main>

                    <!-- CKEditor를 먼저 로드 -->
                    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>

                    <!-- CKEditor 로드 후 createFunding.js 로드 -->
                    <script type="text/javascript" src="/js/funding/updateFunding.js"></script>
                </body>

                </html>