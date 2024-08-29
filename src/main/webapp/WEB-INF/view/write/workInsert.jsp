<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 정보 입력</title>
    <style>
        .tag {
            display: inline-block;
            padding: 5px;
            background-color: #f1f1f1;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 5px;
            margin-bottom: 5px;
        }
	
        .tag .remove-tag {
            margin-left: 5px;
            cursor: pointer;
            color: red;
        }

        .tag-input {
            display: inline-block;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 5px;
            margin-bottom: 5px;
            min-width: 120px;
        }

        .tag-input input {
            border: none;
            outline: none;
            width: calc(100% - 80px); /* Adjusting width considering select width */
            display: inline-block;
            vertical-align: middle;
        }

        .tag-input select {
            border: none;
            outline: none;
            width: 80px;
            display: inline-block;
            vertical-align: middle;
            height: 100%;
        }
    </style>
    
</head>
<body>
    <h2>도서 정보 입력 폼</h2>
    <form action="workInsert" method="post" onsubmit="appendCustomTag()">
        <label for="title">제목:</label> 
        <input type="text" id="title" name="title" value="테스트 제목" required/><br><br> 
        
        <label for="authorComment">저자 코멘트:</label>
        <textarea id="authorComment" name="authorComment" required>테스트 저자 코멘트</textarea><br><br> 
        
        <label for="author">저자:</label> 
        <input type="text" id="author" name="author" value="테스트 저자" required/><br><br> 
        
        <!-- <label for="bookCoverImage">책 표지 이미지 URL:</label> 
        <input type="text" id="bookCoverImage" name="bookCoverImage"/><br><br>  -->
        
        <label for="categoryNames">카테고리 이름:</label> 
        <select id="categoryNames" name="categoryNames" required>
            <option value="소설">소설</option>
            <option value="비소설">비소설</option>
            <option value="역사">역사</option>
            <option value="과학">과학</option>
        </select><br><br>
        
        <label for="genreNames">장르 이름:</label>
        <select id="genreNames" name="genreNames">
        	     <option value=""></option>
                <option value="판타지">판타지</option>
                <option value="추리">추리</option>
                <option value="로맨스">로맨스</option>
                <option value="공포">공포</option>
        </select><br> 
        
        <label for="tagList">태그 목록:</label>
        <div id="tagList" class="tag-input">
            <!-- 태그가 여기에 추가됩니다 -->
        </div><br> 
        
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
        </div><br><br>
        
        <label for="age">연령:</label> 
        <select id="age" name="age" required>
            <option value="전체">전체</option>
            <option value="7">7</option>
            <option value="12">12</option>g
            <option value="15">15</option>
            <option value="19">19</option>
        </select><br><br>

        <button type="submit">제출</button>
    </form>
    
    <script>
        function addTagOnEnter(event) {
            if (event.key === "Enter") {
                event.preventDefault(); // 엔터키의 기본 동작을 막음
                appendCustomTag();
            }
        }

        function appendCustomTag(value = null) {
            var customTag = value || document.getElementById("customTag").value.trim();
            if (customTag) {
                var tagList = document.getElementById("tagList");

                // 새로운 태그 요소 생성
                var tagItem = document.createElement("div");
                tagItem.className = "tag";
                tagItem.textContent = customTag;

                // 삭제 버튼 생성
                var removeButton = document.createElement("span");
                removeButton.className = "remove-tag";
                removeButton.textContent = "x";
                removeButton.onclick = function() {
                    tagList.removeChild(tagItem);
                };

                // 태그 요소에 삭제 버튼 추가
                tagItem.appendChild(removeButton);
                tagList.appendChild(tagItem);

                // 숨겨진 input 필드에 태그 값 추가
                var hiddenInput = document.createElement("input");
                hiddenInput.type = "hidden";
                hiddenInput.name = "tagNames";
                hiddenInput.value = customTag;
                tagItem.appendChild(hiddenInput);

                // 입력 필드 초기화
                document.getElementById("customTag").value = '';
            }
        }

        function addSelectedOption() {
            var select = document.getElementById("genreNames");
            var selectedOption = select.options[select.selectedIndex].value;
            appendCustomTag(selectedOption);
            select.selectedIndex = 0; // Reset the select box
        }
    </script>
</body>
</html>
