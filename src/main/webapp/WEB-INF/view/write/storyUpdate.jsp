<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp" %>
<link rel="stylesheet" href="/css/storyInsert.css">
<main>
<div class="content--container">
    <h1>스토리 수정</h1>
    <div class="content--area">
        <form action="storyUpdate" method="post">
            <div class="top--section">
                     <div class="content--type">
                    <label for="type">유형:</label>
                        <select id="type" name="type">
                            <option value="프롤로그" ${storyContent.type == '프롤로그' ? 'selected' : ''}>프롤로그</option>
                            <option value="무료" ${storyContent.type == '무료' ? 'selected' : ''}>무료</option>
                            <option value="유료" ${storyContent.type == '유료' ? 'selected' : ''}>유료</option>
                        </select>
                    <input type="hidden" id="number" name="number" value="1" />
                    </div>
                    <div class="content--title">
                    	<label for="title">제목:</label>
                    <input type="text" id="title" name="title" value="${storyContent.title}" />
                    </div>
                </div>
                    <%-- 업로드 시간이 지나면 수정안됨 -> insert가 안되는 중 --%>
                <div class="content--day">
                    <label for="uploadDay">업로드 날짜:</label>
                    <input type="date" id="uploadDay" value="${storyContent.uploadDay}" readonly="true" />
                </div>
                <div class="content--save">
                 	<label for="save">저장 여부:</label>
                    <input type="checkbox" id="save" name="save" ${storyContent.save ? 'checked' : ''} />
                </div>
                <div class="content--cost">
                     <label for="cost">비용:</label>
                    <input type="number" id="cost" name="cost" value="${storyContent.cost}" />
                </div>
                            <!-- 중간에 '내용' 입력 필드 -->
            	<div class="middle-section">
                	<div class="story">
                    <label for="contents">내용:</label>
                   	<textarea id="contents" name="contents">${storyContent.contents}</textarea>
                	</div>
                </div>
                <div class="btn--area">
            <input type="hidden" name="storyId" value="1" />
            <button type="submit" id="btnInsert">회차 수정</button>
            </div>
        </form>
       </div>
      </div>
</main>