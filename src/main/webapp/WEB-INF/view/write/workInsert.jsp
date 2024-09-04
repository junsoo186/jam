<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/insertTag.css">
<link rel="stylesheet" href="/css/workInsert.css">

<main>
	<div class="container">
		<form id="bookForm" action="workInsert" method="post" onsubmit="return prepareFormForSubmit()" enctype="multipart/form-data">
			<h2>도서 정보 입력 폼</h2>
			<!-- 폼 섹션 -->
			<div class="content">
				<!-- 왼쪽 섹션: 도서 정보 입력 및 이미지 선택 -->
				<div class="left--section">
					<div class="left--secition--top"></div>
					<!-- 책 커버 선택 -->
					<div class="cover">
						<img id="bookCoverPreview" src="#" alt="미리보기" style="display: none; margin-top: 10px; max-width: 100%; height: auto;">
					</div>

					<input type="file" id="bookCover" name="bookCover" class="bookCover" accept="image/*">
					<!-- 이미지 선택 섹션 -->
					<div class="left--secition--center">
						<h3>이미지 선택</h3>
						<div class="images">
							<div class="image">
								<img src="path/to/image1.jpg" alt="제공 이미지 1" class="selectable-image">
							</div>
							<div class="image">
								<img src="path/to/image2.jpg" alt="제공 이미지 2" class="selectable-image">
							</div>
							<div class="image">
								<img src="path/to/image3.jpg" alt="제공 이미지 3" class="selectable-image">
							</div>
							<div class="image">
								<img src="path/to/image4.jpg" alt="제공 이미지 4" class="selectable-image">
							</div>
						</div>
					</div>
					<br>
				</div>

				<!-- 오른쪽 섹션: 입력 필드 -->
				<div class="right--section">
					<label for="title">작품명:</label> <input type="text" id="title" name="title" value="테스트 제목" required /> <label for="authorComment">코멘트:</label>
					<textarea id="authorComment" name="authorComment" required>테스트 저자 코멘트</textarea>


					<label for="introduction">소개글:</label>
					<textarea id="introduction" name="introduction" rows="4" required>테스트용 소개글</textarea>

					<!-- 연령 선택 셀렉트 박스 -->
					<label for="ageSelect">연령 선택:</label> <select id="ageSelect" name="age">
						<option value="전체">전체</option>
						<option value="7">7</option>
						<option value="12">12</option>
						<option value="15">15</option>
						<option value="19">19</option>
					</select>




					<!-- 카테고리 선택 셀렉트 박스 -->
					<label for="categorySelect">카테고리 선택:</label> <select id="categorySelect" name="categoryId" onchange="updateHiddenInput('categorySelect', 'categoryId')">
						<c:forEach items="${category}" var="categroy">
							<option value="${categroy.categoryId}">${categroy.categoryName}</option>
						</c:forEach>
					</select>

					<!-- 장르 선택 셀렉트 박스 -->
					<label for="genreSelect">장르 선택:</label> <select id="genreSelect" name="genreId" onchange="updateHiddenInput('genreSelect', 'genreId')">
						<c:forEach items="${genre}" var="genre">
							<option value="${genre.genreId}">${genre.genreName}</option>
						</c:forEach>
					</select>
					<!-- 기본값을 "추리"로 설정 -->

					<!-- 연재 요일 선택 -->
					<label for="serialDay">연재 요일:</label>
					<div class="radio-buttons">
						<label><input type="checkbox" name="serialDay" value="월요일"> 월요일</label> <label><input type="checkbox" name="serialDay" value="화요일"> 화요일</label> <label><input
							type="checkbox" name="serialDay" value="수요일"> 수요일</label> <label><input type="checkbox" name="serialDay" value="목요일"> 목요일</label> <label><input
							type="checkbox" name="serialDay" value="금요일"> 금요일</label> <label><input type="checkbox" name="serialDay" value="토요일"> 토요일</label> <label><input
							type="checkbox" name="serialDay" value="일요일"> 일요일</label> <label><input type="checkbox" name="serialDay" value="비 정기 연재"> 비 정기 연재</label>
					</div>

					<!-- 태그 목록과 추가 필드 -->
					<label for="tagList">태그 목록:</label>
					<div id="tagList" class="tag-input">
						<!-- 태그가 여기에 추가됩니다 -->
					</div>

					<!-- 태그 추가를 위한 인풋 필드와 셀렉트 박스 -->
					<div class="tag-input">
						<input type="text" id="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요"> <select id="presetTags" name="presetTags" onchange="addSelectedOption()">
							<option value=""></option>
							<option value="판타지">판타지</option>
							<option value="추리">추리</option>
							<option value="로맨스">로맨스</option>
							<option value="공포">공포</option>
						</select>
					</div>

					<!-- 경고문 섹션 -->
					<div class="warning-section">
						<p>경고문 텍스트를 여기에 추가합니다.</p>
						<label><input type="checkbox" required> 동의합니다</label>
					</div>
				</div>

			</div>
			<!-- 제출 및 취소 버튼 -->
			<div class="submit-buttons">
				<button type="button" class="cancel" onclick="location.href='workList'">취소</button>
				<button type="submit" class="submit">작품 등록</button>
			</div>
		</form>
	</div>

</main>
<script type="text/javascript" src="/js/workInsert.js"></script>
<script type="text/javascript" src="/js/insertTag.js"></script>
