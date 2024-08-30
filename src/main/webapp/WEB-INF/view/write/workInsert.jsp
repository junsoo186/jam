<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/insertTag.css">
<style>
       /* 간단한 스타일 정의 */
        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-section {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .left-section, .right-section {
            flex: 1;
        }

        .left-section {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .right-section {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .book-cover {
            width: 100%;
            height: 300px;
            border: 2px dashed #ddd;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .book-cover label {
            cursor: pointer;
            color: #007bff;
        }

        .genre-buttons, .age-buttons {
            display: flex;
            gap: 10px;
        }

        .genre-buttons button, .age-buttons button {
            padding: 10px 20px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            cursor: pointer;
            border-radius: 5px;
        }

        .genre-buttons button.active, .age-buttons button.active {
            background-color: #007bff;
            color: white;
        }

        .tag-input {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .tag-input input, .tag-input select {
            flex: 1;
            padding: 8px;
        }

        .submit-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .submit-buttons button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .submit-buttons .cancel {
            background-color: #ff6666;
            color: white;
        }

        .submit-buttons .submit {
            background-color: #4CAF50;
            color: white;
        }
        
        .category-buttons {
    display: flex;
    gap: 10px; /* 버튼 간 간격을 줌 */
}

.category-button {
    padding: 10px 20px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    cursor: pointer;
    border-radius: 5px;
}

.category-button.active {
    background-color: #007bff;
    color: white;
}
</style>
<main>

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
					    <button type="button" class="genre-button active" data-genre="추리" onclick="selectGenre(this)">추리</button>
					    <button type="button" class="genre-button" data-genre="스릴러" onclick="selectGenre(this)">스릴러</button>
					    <button type="button" class="genre-button" data-genre="공포" onclick="selectGenre(this)">공포</button>
					    <button type="button" class="genre-button" data-genre="과학" onclick="selectGenre(this)">과학</button>
					    <button type="button" class="genre-button" data-genre="판타지" onclick="selectGenre(this)">판타지</button>
					    <button type="button" class="genre-button" data-genre="무협" onclick="selectGenre(this)">무협</button>
					</div>
					<input type="hidden" id="selectedGenre" name="genre" value="추리">
					<!-- 카테고리 선택 버튼 -->
    <div class="category-buttons">
        <button type="button" class="category-button active" data-category="문학" onclick="selectCategory(this)">문학</button>
        <button type="button" class="category-button" data-category="시/에세이" onclick="selectCategory(this)">시/에세이</button>
        <button type="button" class="category-button" data-category="소설" onclick="selectCategory(this)">소설</button>
    </div>
    <input type="hidden" id="selectedCategory" name="category" value="문학"> <!-- 기본값을 "문학"으로 설정 -->
					
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
	<%-- header.jsp 부분의 body가 열려있어서 외부 js를 순서대로 작동시키지못함 ->방법 필요 --%>
    <script> 
    // 장르
    function selectGenre(button) {
        // 모든 버튼의 'active' 클래스 제거
        const buttons = document.querySelectorAll('.genre-button');
        buttons.forEach(btn => btn.classList.remove('active'));

        // 클릭된 버튼에 'active' 클래스 추가
        button.classList.add('active');

        // 선택된 장르를 숨겨진 입력 필드에 저장
        const selectedGenre = button.getAttribute('data-genre');
        document.getElementById('selectedGenre').value = selectedGenre;
    }
    
    // 태그 추가
 // 태그 중복 확인을 위한 Set 생성
    let tagSet = new Set();

    function addTagOnEnter(event) {
        if (event.key === "Enter") {
            event.preventDefault(); // 엔터키의 기본 동작을 막음
            appendCustomTag();
        }
    }

    function appendCustomTag(value = null) {
        var customTagInput = document.getElementById("customTag");
        var customTag = value || customTagInput.value.trim();

        if (customTag === "") {
            alert("태그를 입력해주세요.");
            return;
        }

        if (tagSet.has(customTag)) {
            alert("이미 추가된 태그입니다.");
            customTagInput.value = '';
            return;
        }

        // 태그 세트에 추가
        tagSet.add(customTag);

        var tagList = document.getElementById("tagList");

        // 새로운 태그 요소 생성
        var tagItem = document.createElement("div");
        tagItem.className = "tag-item";

        var tagNameSpan = document.createElement("span");
        tagNameSpan.className = "tag-name";
        tagNameSpan.textContent = customTag;

        // 삭제 버튼 생성
        var removeButton = document.createElement("span");
        removeButton.className = "remove-tag";
        removeButton.textContent = "x";
        removeButton.onclick = function() {
            tagList.removeChild(tagItem);
            tagSet.delete(customTag);
        };

        // 태그 요소 구성
        tagItem.appendChild(tagNameSpan);
        tagItem.appendChild(removeButton);
        tagList.appendChild(tagItem);

        // 숨겨진 input 필드에 태그 값 추가
        var hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "customTag"; // BookDTO와 매핑되는 필드 이름
        hiddenInput.value = customTag;
        tagItem.appendChild(hiddenInput);

        // 입력 필드 초기화
        customTagInput.value = '';
    }

    function addSelectedOption() {
        var select = document.getElementById("presetTags");
        var selectedOption = select.value.trim();
        if (selectedOption !== "") {
            appendCustomTag(selectedOption);
        }
        select.selectedIndex = 0; // Reset the select box
    }

    function prepareFormForSubmit() {
        if (tagSet.size < 3) {
            alert("태그는 최소 3개 이상이어야 합니다.");
            return false;
        }
        return true;
    }
    //카테고리
    function selectCategory(button) {
        // 모든 버튼의 'active' 클래스 제거
        const buttons = document.querySelectorAll('.category-button');
        buttons.forEach(btn => btn.classList.remove('active'));

        // 클릭된 버튼에 'active' 클래스 추가
        button.classList.add('active');

        // 선택된 카테고리를 숨겨진 입력 필드에 저장
        const selectedCategory = button.getAttribute('data-category');
        document.getElementById('selectedCategory').value = selectedCategory;
    }

    </script>
    
</main>
   <!--  <script type="text/javascript" src="js/insertTag.js"></script> -->
</body>

