<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/insertTag.css">
<link rel="stylesheet" href="/css/workInsert.css">
<main>

	<div class="container">
		<h2>도서 정보 입력 폼</h2>
		<form action="workInsert" method="post" onsubmit="return prepareFormForSubmit()">
			<!-- 폼 섹션 -->
			<div class="form-section">
				<!-- 왼쪽 섹션: 책 커버 및 이미지 선택 -->
				<div class="left-section">
					<div class="book-cover">
						<label for="bookCover">책 커버 선택</label> <input type="file" id="bookCover" name="bookCover" style="display: none">
					</div>
					<!-- 장르 선택 셀렉트 박스 -->

					<!-- 이미지 선택 섹션 -->
					<div class="image-selection">
						<h3>이미지 선택</h3>
						<div class="image-options">
							<div class="image-option">제공 이미지 1</div>
							<div class="image-option">제공 이미지 2</div>
							<div class="image-option">제공 이미지 3</div>
							<div class="image-option">제공 이미지 4</div>
						</div>
					</div>
				</div>

				<!-- 오른쪽 섹션: 입력 필드 -->
				<div class="right-section">
					<label for="title">작품명:</label> <input type="text" id="title" name="title" value="테스트 제목" required /> <label for="authorComment">코멘트:</label>
					<textarea id="authorComment" name="authorComment" required>테스트 저자 코멘트</textarea>

					<label for="introduction">소개글:</label>
					<textarea id="introduction" name=introduction rows="4" required>테스트용 소개글</textarea>

					<!-- 연령 선택 셀렉트 박스 -->
					<label for="ageSelect">연령 선택:</label> <select id="ageSelect" name="age" onchange="updateHiddenInput('ageSelect', 'age')">
						<option value="전체">전체</option>
						<option value="7">7</option>
						<option value="12">12</option>
						<option value="15">15</option>
						<option value="19">19</option>
					</select> <br> <br>
					<!-- 선택된 연령을 저장할 숨겨진 input 필드 -->

					<!-- 카테고리 선택 셀렉트 박스 -->
					<label for="categorySelect">카테고리 선택:</label> <select id="categorySelect" name="categoryId" onchange="updateHiddenInput('categorySelect', 'categoryId')">
						<c:forEach items="${category}" var="categroy">
							<option value="${categroy.categoryId}">${categroy.categoryName}</option>
						</c:forEach>
					</select> <input type="hidden" id="categoryId" name="categoryId" value="1">
					<!-- 기본값을 "문학"으로 설정 -->

					<label for="genreSelect">장르 선택:</label> <select id="genreSelect" name="genreId" onchange="updateHiddenInput('genreSelect', 'genreId')">
						<c:forEach items="${genre}" var="genre">
							<option value="${genre.genreId}">${genre.genreName}</option>
						</c:forEach>
					</select> <input type="hidden" id="genreId" name="genreId" value="1">
					<!-- 기본값을 "추리"로 설정 -->




					<label for="serialDay">연재 요일:</label>
					<div class="radio-buttons">
						<label><input type="checkbox" name="serialDay" value="월요일"> 월요일</label> <label><input type="checkbox" name="serialDay" value="화요일"> 화요일</label> <label><input
							type="checkbox" name="serialDay" value="수요일"> 수요일</label> <label><input type="checkbox" name="serialDay" value="목요일"> 목요일</label> <label><input
							type="checkbox" name="serialDay" value="금요일"> 금요일</label> <label><input type="checkbox" name="serialDay" value="토요일"> 토요일</label> <label><input
							type="checkbox" name="serialDay" value="일요일"> 일요일</label> <label><input type="checkbox" name="serialDay" value="비 정기 연재"> 비 정기 연재</label>
					</div>

					<br> <label for="tagList">태그 목록:</label>
					<div id="tagList" class="tag-input">
						<!-- 태그가 여기에 추가됩니다 -->
					</div>
					<br>

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
					<br> <br>




					<!-- 경고문 섹션 -->
					<div class="warning-section">
						<p>경고문 텍스트를 여기에 추가합니다.</p>
						<label><input type="checkbox" required> 동의합니다</label>
					</div>

					<!-- 제출 및 취소 버튼 -->
					<div class="submit-buttons">
						<button type="button" class="cancel">취소</button>
						<button type="submit" class="submit">작품 등록</button>
					</div>
				</div>
			</div>
		</form>
	</div>




	<%-- header.jsp 부분의 body가 열려있어서 외부 js를 순서대로 작동시키지못함 ->방법 필요 --%>



	<script type="text/javascript" src="/js/insertTag.js"></script>
	<script type="text/javascript" src="/js/workInsert.js"></script>
</main>