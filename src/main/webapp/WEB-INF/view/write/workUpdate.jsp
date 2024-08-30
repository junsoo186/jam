<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/insertTag.css">

<body>
	<h2>도서 정보 입력 폼</h2>
	<form action="workUpdate" method="post" onsubmit="appendCustomTag()">
		<label for="title">제목:</label> 
		<input type="text" id="title" name="title" value="${bookDetail.title}" required /><br> 
		<br> 
		<label for="authorComment">저자 코멘트:</label>
		<textarea id="authorComment" name="authorComment" required>${bookDetail.authorComment}</textarea>
		<br> 
		<br> 
		<label for="introduction">소개:</label>
		<textarea id="introduction" name="introduction" required>${bookDetail.introduction}</textarea>
		<br> 
		<br> 
		<label for="serialDay">연재 요일:</label><br> 
		<input type="radio" id="monday" name="serialDay" value="월요일" ${bookDetail.serialDay=='월요일' ? 'checked' : ''}> 
		<label for="monday">월요일</label><br> 
		<input type="radio" id="tuesday" name="serialDay" value="화요일" ${bookDetail.serialDay=='화요일' ? 'checked' : ''}> 
		<label for="tuesday">화요일</label><br> 
		<input type="radio" id="wednesday" name="serialDay" value="수요일" ${bookDetail.serialDay=='수요일' ? 'checked' : ''}> 
		<label for="wednesday">수요일</label><br> 
		<input type="radio" id="thursday" name="serialDay" value="목요일" ${bookDetail.serialDay=='목요일' ? 'checked' : ''}> 
		<label for="thursday">목요일</label><br> 
		<input type="radio" id="friday" name="serialDay" value="금요일" ${bookDetail.serialDay=='금요일' ? 'checked' : ''}> 
		<label for="friday">금요일</label><br> 
		<input type="radio" id="saturday" name="serialDay" value="토요일" ${bookDetail.serialDay=='토요일' ? 'checked' : ''}> 
		<label for="saturday">토요일</label><br> 
		<input type="radio" id="sunday" name="serialDay" value="일요일" ${bookDetail.serialDay=='일요일' ? 'checked' : ''}> 
		<label for="sunday">일요일</label><br> 
		<input type="radio" id="irregular" name="serialDay" value="비 정기 연재" ${bookDetail.serialDay=='비 정기 연재' ? 'checked' : ''}> 
		<label for="irregular">비 정기 연재</label><br> 
		<br> 
		<label for="categoryName">카테고리 이름:</label>
		<select id="categoryName" name="categoryName" required>
		    <option value="문학" ${bookDetail.categoryName == '문학' ? 'selected' : ''}>문학</option>
		    <option value="시/에세이" ${bookDetail.categoryName == '시/에세이' ? 'selected' : ''}>시/에세이</option>
		    <option value="소설" ${bookDetail.categoryName == '소설' ? 'selected' : ''}>소설</option>
		</select>
		<br><br>
		
		<label for="genreName">장르 이름:</label>
		<select id="genreName" name="genreName">
		    <option value="추리" ${bookDetail.genreName == '추리' ? 'selected' : ''}>추리</option>
		    <option value="스릴러" ${bookDetail.genreName == '스릴러' ? 'selected' : ''}>스릴러</option>
		    <option value="공포" ${bookDetail.genreName == '공포' ? 'selected' : ''}>공포</option>
		    <option value="과학" ${bookDetail.genreName == '과학' ? 'selected' : ''}>과학</option>
		    <option value="판타지" ${bookDetail.genreName == '판타지' ? 'selected' : ''}>판타지</option>
		    <option value="무협" ${bookDetail.genreName == '무협' ? 'selected' : ''}>무협</option>
		</select>
		<br> 
		<label for="tagList">태그 목록:</label>
		<div id="tagList" class="tag-input">
			<!-- 태그가 여기에 추가됩니다 -->
		</div>
		<br>

		<!-- 인풋 필드 안에 셀렉트 박스 추가 -->
		<div class="tag-input">
			<input type="text" id="customTag" name="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요"> 
			<select id="genreNames" name="genreNames" onchange="addSelectedOption()">
				<option value=""></option>
				<option value="판타지">판타지</option>
				<option value="추리">추리</option>
				<option value="로맨스">로맨스</option>
				<option value="공포">공포</option>
			</select>
		</div>
		<br> 
		<br> 
		<label for="age">연령:</label> 
		<select id="age" name="age" required>
			<option value="전체" ${bookDetail.age=='전체' ? 'selected' : '' }>전체</option>
			<option value="7" ${bookDetail.age=='7' ? 'selected' : '' }>7</option>
			<option value="12" ${bookDetail.age=='12' ? 'selected' : '' }>12</option>
			<option value="15" ${bookDetail.age=='15' ? 'selected' : '' }>15</option>
			<option value="19" ${bookDetail.age=='19' ? 'selected' : '' }>19</option>
		</select>
		<br> 
		<br> 
		<input type="hidden" name="bookId" value="${bookId}">
		<button type="submit">제출</button>
	</form>
	<form action="workDelete" method="post">
        	<input type="hidden" name="bookId" value="${bookId}">
        	<button>작품 삭제</button>
        </form>

	<script type="text/javascript" src="js/insertTag.js"></script>
</body>
