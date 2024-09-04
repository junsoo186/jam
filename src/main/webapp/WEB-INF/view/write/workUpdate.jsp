<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/insertTag.css">
<link rel="stylesheet" href="/css/workInsert.css">

<main>
    <div class="container--area">
        <form id="bookForm" action="workUpdate" method="post" onsubmit="return prepareFormForSubmit()">
            <h2>도서 정보 수정 폼</h2>
            <!-- 폼 섹션 -->
            <div class="content--area">
            
                <div class="left--area">
                <!-- 왼쪽 섹션: 도서 정보 입력 및 이미지 선택 -->
                <div class="left--area--top">
                    <!-- 책 커버 선택 -->
                    <div class="img--cover">

                        <!-- 기존 이미지 표시 -->
                        <img id="bookCoverPreview" src="${bookDetail.bookCoverImage}" alt="현재 책 커버 이미지" style="max-width: 100%; height: auto;">

                        <!-- 새 이미지 미리 보기 -->
                        <div id="newCoverPreview" style="margin-top: 10px; display: none;">
                            <p>새 이미지 미리 보기:</p>
                            <img id="newCoverImage" src="#" alt="새 책 커버 이미지" style="max-width: 100%; height: auto;">
                        </div>
                    </div>

                        <input type="file" id="bookCover" name="bookCover" class="bookCover" accept="image/*"> 
                    <!-- 이미지 선택 섹션 -->
                    <div class="left--area--center">
                        <h3>이미지 선택</h3>
                        <div class="img--area--images">
                            <div class="images">
                                <img src="path/to/image1.jpg" alt="제공 이미지 1" class="selectable-image">
                            </div>
                            <div class="images">
                                <img src="path/to/image2.jpg" alt="제공 이미지 2" class="selectable-image">
                            </div>
                            <div class="images">
                                <img src="path/to/image3.jpg" alt="제공 이미지 3" class="selectable-image">
                            </div>
                            <div class="images">
                                <img src="path/to/image4.jpg" alt="제공 이미지 4" class="selectable-image">
                            </div>
                        </div>
                    </div>
                    <br>
                    
                </div>
              </div>

                <!-- 오른쪽 섹션: 연재 요일 및 기타 설정 -->
                <!--  위 : 제목,코멘트,소개 -->
                <div class="right--area">
                    <div class="right-area--top">
                        <label for="title">작품명:</label> 
                        <input type="text" id="title" name="title" value="${bookDetail.title}" required />

                    <label for="authorComment">저자 코멘트:</label>
                    <textarea id="authorComment" name="authorComment" required>${bookDetail.authorComment}</textarea>


                        <label for="introduction">소개글:</label>
                        <textarea id="introduction" name="introduction" required>${bookDetail.introduction}</textarea>

					</div>
					
					<div class="right-area--center">
                        <!-- 카테고리 선택 셀렉트 박스 -->
                        <label for="categorySelect">카테고리 선택:</label>
                        <select id="categorySelect" name="categoryId" onchange="updateHiddenInput('categorySelect', 'categoryId')">
                            <c:forEach items="${category}" var="categroy">
                                <option value="${categroy.categoryId}">${categroy.categoryName}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="categoryId" name="categoryId" value="1">

                        <!-- 장르 선택 셀렉트 박스 -->
                        <label for="genreSelect">장르 선택:</label>
                        <select id="genreSelect" name="genreId" onchange="updateHiddenInput('genreSelect', 'genreId')">
                            <c:forEach items="${genre}" var="genre">
                                <option value="${genre.genreId}">${genre.genreName}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="genreId" name="genreId" value="1">

                        <label for="serialDay">연재 요일:</label>
                        <div class="btn--day">
                            <label><input type="checkbox" name="serialDay" value="월요일"> 월요일</label>
                            <label><input type="checkbox" name="serialDay" value="화요일"> 화요일</label>
                            <label><input type="checkbox" name="serialDay" value="수요일"> 수요일</label>
                            <label><input type="checkbox" name="serialDay" value="목요일"> 목요일</label>
                            <label><input type="checkbox" name="serialDay" value="금요일"> 금요일</label>
                            <label><input type="checkbox" name="serialDay" value="토요일"> 토요일</label>
                            <label><input type="checkbox" name="serialDay" value="일요일"> 일요일</label>
                            <label><input type="checkbox" name="serialDay" value="비 정기 연재"> 비 정기 연재</label>
                        </div>
                    </div>

                    <!--  연령 ,태그 -->
                    <div class="right-area--bottom">
                        <!-- 연령 선택 -->
                        <label for="ageSelect">연령 선택:</label> 
                        <select id="ageSelect" name="age" onchange="updateHiddenInput('ageSelect', 'age')">
                            <option value="전체">전체</option>
                            <option value="7">7</option>
                            <option value="12">12</option>
                            <option value="15">15</option>
                            <option value="19">19</option>
                        </select>

                        <!-- 태그 목록 -->
                        <label for="tagList">태그 목록:</label>
                        <div id="tagList" class="tag--input">
                            <c:forEach items="${selectTags}" var="tag">
                                <div class="tag-item">
                                    <span class="tag-name">${tag.tagName}</span> 
                                    <span class="remove-tag" onclick="removeTag('${tag.tagName}', this)">x</span>
                                    <input type="hidden" name="customTag" value="${tag.tagName}">
                                </div>
                            </c:forEach>
                        </div>
                        <br>

                        <!-- 태그 추가를 위한 인풋 필드와 셀렉트 박스 -->
                        <div class="tag--input">
                            <input type="text" id="customTag" name="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요">
                            <select id="presetTags" name="presetTags" onchange="addSelectedOption()">
                                <option value=""></option>
                                <option value="판타지">판타지</option>
                                <option value="추리">추리</option>
                                <option value="로맨스">로맨스</option>
                                <option value="공포">공포</option>
                            </select>
                        </div>
                    </div>
                </div>

                <br> <br>
            </div>
            <!-- 숨겨진 책 ID 필드 -->
            <input type="hidden" name="bookId" value="${bookId}">
            <!-- 제출 및 취소 버튼 -->
            <div class="bottom--btn--area">
            	<div class="cancel--btn--area">
                <button type="button" class="btn--cancel" onclick="location.href='workList'">취소</button>
            	</div>
            	<div class="submit--btn--area">
                <button type="submit" class="btn--submit">제출</button>
                <button type="button" class="btn--submit" onclick="submitFormToDifferentAction('workDelete')">작품 삭제</button>
           		</div>
            </div>
        </form>
    </div>

    <script type="text/javascript" src="/js/insertTag.js"></script>
    <script type="text/javascript" src="/js/workUpdate.js"></script>
</main>
