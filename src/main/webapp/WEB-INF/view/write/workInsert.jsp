<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                width: calc(100% - 80px);
                /* Adjusting width considering select width */
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
        <form action="workInsert" method="post" onsubmit="return prepareFormForSubmit()">
            <label for="title">제목:</label> <input type="text" id="title" name="title" value="테스트 제목" required /><br>
            <br> <label for="authorComment">저자 코멘트:</label>
            <textarea id="authorComment" name="authorComment" required>테스트 저자 코멘트</textarea>
            <br> <br> <label for="author">저자:</label> <input type="text" id="author" name="author" value="테스트 저자"
                required /><br> <br> <label for="serialDay">연재
                요일:</label><br> <input type="radio" id="monday" name="serialDay" value="월요일"> <label
                for="monday">월요일</label><br> <input type="radio" id="tuesday" name="serialDay" value="화요일"> <label
                for="tuesday">화요일</label><br> <input type="radio" id="wednesday" name="serialDay" value="수요일"> <label
                for="wednesday">수요일</label><br>
            <input type="radio" id="thursday" name="serialDay" value="목요일"> <label for="thursday">목요일</label><br> <input
                type="radio" id="friday" name="serialDay" value="금요일">
            <label for="friday">금요일</label><br> <input type="radio" id="saturday" name="serialDay" value="토요일"> <label
                for="saturday">토요일</label><br> <input type="radio" id="sunday" name="serialDay" value="일요일"> <label
                for="sunday">일요일</label><br> <input type="radio" id="irregular" name="serialDay" value="비 정기 연재"> <label
                for="irregular">비 정기 연재</label><br>
                
            <!-- Introduction 필드 추가 -->
            <label for="introduction">소개글:</label><br>
            <textarea id="introduction" name="introduction" rows="4" cols="50" placeholder="도서의 소개글을 입력하세요"
                required>테스트용 소개글</textarea>
                
            <br> <br> <label for="categoryId">카테고리 이름:</label> <select id="categoryId" name="categoryId"
                required>
                <option value="1">소설</option>
                <option value="2">비소설</option>
                <option value="3">역사</option>
                <option value="4">과학</option>
            </select><br> <br> <label for="genreId">장르 이름:</label> <select id="genreId" name="genreId">
                <option value="1">판타지</option>
                <option value="2">추리</option>
                <option value="3">로맨스</option>
                <option value="4">공포</option>
            </select><br> <br> <label for="tagList">태그 목록:</label>
            <div id="tagList" class="tag-input">
                <!-- 태그가 여기에 추가됩니다 -->
            </div>
            <br>

            <!-- 태그 추가를 위한 인풋 필드와 셀렉트 박스 -->
            <div class="tag-input">
                <input type="text" id="customTag" onkeydown="addTagOnEnter(event)" placeholder="태그를 입력하세요"> <select
                    id="presetTags" onchange="addSelectedOption()">
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
                    removeButton.onclick = function () {
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
                var select = document.getElementById("presetTags");
                var selectedOption = select.options[select.selectedIndex].value;
                appendCustomTag(selectedOption);
                select.selectedIndex = 0; // Reset the select box
            }

            function prepareFormForSubmit() {
                // 태그 추가 버튼으로 생성된 숨겨진 태그들이 포함된 상태로 폼을 제출하게 함
                return true;
            }
        </script>
    </body>

    </html>