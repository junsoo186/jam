<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>도서 정보 입력</title>
<link rel="stylesheet" href="/css/insertTag.css">
</head>

<body>
	<h2>도서 정보 입력 폼</h2>
	<form action="workInsert" method="post" onsubmit="return prepareFormForSubmit()">
		<label for="title">제목:</label> <input type="text" id="title" name="title" value="테스트 제목" required /><br> <br> <label for="authorComment">저자 코멘트:</label>
		<textarea id="authorComment" name="authorComment" required>테스트 저자 코멘트</textarea>
		<br> <br> <label for="author">저자:</label> <input type="text" id="author" name="author" value="테스트 저자" required /><br> <br> <label for="serialDay">연재
			요일:</label><br> <input type="radio" id="monday" name="serialDay" value="월요일"> <label for="monday">월요일</label><br> <input type="radio" id="tuesday" name="serialDay"
			value="화요일"
		> <label for="tuesday">화요일</label><br> <input type="radio" id="wednesday" name="serialDay" value="수요일"> <label for="wednesday">수요일</label><br> <input
			type="radio" id="thursday" name="serialDay" value="목요일"
		> <label for="thursday">목요일</label><br> <input type="radio" id="friday" name="serialDay" value="금요일"> <label for="friday">금요일</label><br> <input type="radio"
			id="saturday" name="serialDay" value="토요일"
		> <label for="saturday">토요일</label><br> <input type="radio" id="sunday" name="serialDay" value="일요일"> <label for="sunday">일요일</label><br> <input type="radio"
			id="irregular" name="serialDay" value="비 정기 연재"
		> <label for="irregular">비 정기 연재</label><br>

		<!-- Introduction 필드 추가 -->
		<label for="introduction">소개글:</label><br>
		<textarea id="introduction" name="introduction" rows="4" cols="50" placeholder="도서의 소개글을 입력하세요" required>테스트용 소개글</textarea>

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

		<!-- 태그가 여기에 추가됩니다 -->
		</div>
		<br>

		<!-- 태그 추가를 위한 인풋 필드와 셀렉트 박스 -->
		<div class="tag-input">
			<input type="text" id="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요"> <select id="presetTags" onchange="addSelectedOption()">
				<option value=""></option>
				<option value="베스트셀러">베스트셀러</option>
				<option value="신간">신간</option>
				<option value="추천">추천</option>
				<option value="인기">인기</option>
			</select>
		</div>
		<br> <br>

		<!-- 연령 선택 필드 -->
		<label for="age">연령:</label> <select id="age" name="age" required>
			<option value="전체">전체</option>
			<option value="7">7</option>
			<option value="12">12</option>
			<option value="15">15</option>
			<option value="19">19</option>
		</select><br> <br>



		<button type="submit">제출</button>
	</form>

	<script type="text/javascript" src="js/insertTag.js"></script>
</body>

</html>