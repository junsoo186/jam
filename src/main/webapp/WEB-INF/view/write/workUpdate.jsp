<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>
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
                var select = document.getElementById("genreNames");
                var selectedOption = select.options[select.selectedIndex].value;
                appendCustomTag(selectedOption);
                select.selectedIndex = 0; // Reset the select box
            }
        </script>
    </head>

    <body>
        <h2>도서 정보 입력 폼</h2>
        <form action="workUpdate" method="post" onsubmit="appendCustomTag()">
            <label for="title">제목:</label> <input type="text" id="title" name="title" value="${bookDetail.title}"
                required /><br>
            <br> <label for="authorComment">저자 코멘트:</label>
            <textarea id="authorComment" name="authorComment" required>${bookDetail.authorComment}</textarea>
            <br>
            <br> <label for="introduction">소개:</label>
            <textarea id="introduction" name="introduction" required>${bookDetail.introduction}</textarea>
            <br>
            <br>
            <label for="serialDay">연재 요일:</label><br>
            <input type="radio" id="monday" name="serialDay" value="월요일" ${bookDetail.serialDay=='월요일' ? 'checked' : ''
                }>
            <label for="monday">월요일</label><br>

            <input type="radio" id="tuesday" name="serialDay" value="화요일" ${bookDetail.serialDay=='화요일' ? 'checked' : ''
                }>
            <label for="tuesday">화요일</label><br>

            <input type="radio" id="wednesday" name="serialDay" value="수요일" ${bookDetail.serialDay=='수요일' ? 'checked'
                : '' }>
            <label for="wednesday">수요일</label><br>

            <input type="radio" id="thursday" name="serialDay" value="목요일" ${bookDetail.serialDay=='목요일' ? 'checked'
                : '' }>
            <label for="thursday">목요일</label><br>

            <input type="radio" id="friday" name="serialDay" value="금요일" ${bookDetail.serialDay=='금요일' ? 'checked' : ''
                }>
            <label for="friday">금요일</label><br>

            <input type="radio" id="saturday" name="serialDay" value="토요일" ${bookDetail.serialDay=='토요일' ? 'checked'
                : '' }>
            <label for="saturday">토요일</label><br>

            <input type="radio" id="sunday" name="serialDay" value="일요일" ${bookDetail.serialDay=='일요일' ? 'checked' : ''
                }>
            <label for="sunday">일요일</label><br>

            <input type="radio" id="irregular" name="serialDay" value="비 정기 연재" ${bookDetail.serialDay=='비 정기 연재' ? 'checked'
                : '' }>
            <label for="irregular">비 정기 연재</label><br>

            <br> <label for="categoryNames">카테고리 이름:</label> <select id="categoryNames" name="categoryNames" required>
                <option value="소설">소설</option>
                <option value="비소설">비소설</option>
                <option value="역사">역사</option>
                <option value="과학">과학</option>
            </select><br>
            <br> <label for="genreNames">장르 이름:</label> <select id="genreNames" name="genreNames">
                <option value=""></option>
                <option value="판타지">판타지</option>
                <option value="추리">추리</option>
                <option value="로맨스">로맨스</option>
                <option value="공포">공포</option>
            </select><br> <label for="tagList">태그 목록:</label>
            <div id="tagList" class="tag-input">
                <!-- 태그가 여기에 추가됩니다 -->
            </div>
            <br>

            <!-- 인풋 필드 안에 셀렉트 박스 추가 -->
            <div class="tag-input">
                <input type="text" id="customTag" name="customTag" onkeydown="addTagOnEnter(event)"
                    placeholder="태그를 입력하세요"> <select id="genreNames" name="genreNames" onchange="addSelectedOption()">
                    <option value=""></option>
                    <option value="판타지">판타지</option>
                    <option value="추리">추리</option>
                    <option value="로맨스">로맨스</option>
                    <option value="공포">공포</option>
                </select>
            </div>
            <br>
            <br> <label for="age">연령:</label> <select id="age" name="age" required>
                <option value="전체" ${bookDetail.age=='전체' ? 'selected' : '' }>전체</option>
                <option value="7" ${bookDetail.age==7 ? 'selected' : '' }>7</option>
                <option value="12" ${bookDetail.age==12 ? 'selected' : '' }>12</option>
                <option value="15" ${bookDetail.age==15 ? 'selected' : '' }>15</option>
                <option value="19" ${bookDetail.age==19 ? 'selected' : '' }>19</option>
            </select><br>
            <br> <input type="hidden" name="bookId" value="${bookId}">
            <button type="submit">제출</button>
        </form>
        
        <form action="workDelete" method="post">
        	<input type="hidden" name="bookId" value="${bookId}">
        	<button>작품 삭제</button>
        </form>
    </body>

    </html>