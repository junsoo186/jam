<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>도서 정보 입력</title>
<link rel="stylesheet" href="/css/insertTag.css">
</head>

<body>
   <div class="container">
        <h2>도서 정보 입력 폼</h2>
        <form action="workInsert" method="post" onsubmit="return prepareFormForSubmit()">
            <!-- 폼 섹션 -->
            <div class="form-section">
                <!-- 왼쪽 섹션: 책 커버 및 이미지 선택 -->
                <div class="left-section">
                    <div class="book-cover">
                        <label for="bookCover">책 커버 선택</label>
                        <input type="file" id="bookCover" name="bookCover" style="display:none">
                    </div>
                    <div class="genre-buttons">
                        <button type="button" class="active">SF/판타지</button>
                        <button type="button">판타지</button>
                        <button type="button">로맨스</button>
                    </div>
                </div>

                <!-- 오른쪽 섹션: 입력 필드 -->
                <div class="right-section">
                    <label for="title">작품명:</label>
                    <input type="text" id="title" name="title" value="테스트 제목" required />


                    <label for="introduction">소개글:</label>
                    <textarea id="introduction" name="introduction" rows="4" required>테스트용 소개글</textarea>

                    <label for="age">연령:</label>
                    <div class="age-buttons">
                        <button type="button" class="active">전체</button>
                        <button type="button">15세</button>
                        <button type="button">19세</button>
                    </div>

                    <label for="serialDay">연재 요일:</label>
                    <div class="radio-buttons">
                        <label><input type="checkbox" name="serialDay" value="월요일"> 월요일</label>
                        <label><input type="checkbox" name="serialDay" value="화요일"> 화요일</label>
                        <label><input type="checkbox" name="serialDay" value="수요일"> 수요일</label>
                        <label><input type="checkbox" name="serialDay" value="목요일"> 목요일</label>
                        <label><input type="checkbox" name="serialDay" value="금요일"> 금요일</label>
                        <label><input type="checkbox" name="serialDay" value="토요일"> 토요일</label>
                        <label><input type="checkbox" name="serialDay" value="일요일"> 일요일</label>
                        <label><input type="checkbox" name="serialDay" value="비 정기 연재"> 비 정기 연재</label>
                    </div>
		<br> <br> <label for="categoryId">카테고리 이름:</label> <select id="categoryId" name="categoryId" required>
			<option value="1">문학</option>
			<option value="2">시/에세이</option>
			<option value="3">소설</option>
		</select> <br>
		<br> <label for="genreId">장르 이름:</label> <select id="genreId" name="genreId" required>
			<option value="1">추리</option>
			<option value="2">스릴러</option>
			<option value="3">공포</option>
			<option value="4">과학</option>
			<option value="5">판타지</option>
			<option value="6">무협</option>
		</select>
		<br>
		<label for="tagList">태그 목록:</label>
		<div id="tagList" class="tag-input">
			<!-- 태그가 여기에 추가됩니다 -->
		</div>
		<br>

		<!-- 태그 추가를 위한 인풋 필드와 셀렉트 박스 -->
		<div class="tag-input">
			<input type="text" id="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요">
			<select id="presetTags" name="presetTags" onchange="addSelectedOption()">
				<option value=""></option>
				<option value="판타지">판타지</option>
				<option value="추리">추리</option>
				<option value="로맨스">로맨스</option>
				<option value="공포">공포</option>
			</select>
		</div>
		<br> <br>


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
        </form>
    </div>

    <script type="text/javascript" src="js/insertTag.js"></script>
</body>

</html>