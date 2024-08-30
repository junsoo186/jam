<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp" %>
<body>
    <h1>스토리 수정</h1>

    <div class="btn-area">
        <form action="storyUpdate" method="post">
            <table>
                <tr>
                    <td>유형:</td>
                    <td>
                        <select id="type" name="type">
                            <option value="프롤로그" ${storyContent.type == '프롤로그' ? 'selected' : ''}>프롤로그</option>
                            <option value="무료" ${storyContent.type == '무료' ? 'selected' : ''}>무료</option>
                            <option value="유료" ${storyContent.type == '유료' ? 'selected' : ''}>유료</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="hidden" id="number" name="number" value="1" /></td>
                </tr>
                <tr>
                    <td>제목:</td>
                    <td><input type="text" id="title" name="title" value="${storyContent.title}" /></td>
                </tr>
                <tr>
                    <%-- 업로드 시간이 지나면 수정안됨 -> insert가 안되는 중 --%>
                    <td>업로드 날짜:</td>
                    <td><input type="date" id="uploadDay" value="${storyContent.uploadDay}" readonly="true" /></td>
                </tr>
                <tr>
                    <td>저장 여부:</td>
                    <td><input type="checkbox" id="save" name="save" ${storyContent.save ? 'checked' : ''} /></td>
                </tr>
                <tr>
                    <td>비용:</td>
                    <td><input type="number" id="cost" name="cost" value="${storyContent.cost}" /></td>
                </tr>
                <tr>
                    <td>내용:</td>
                    <td><textarea id="contents" name="contents">${storyContent.contents}</textarea></td>
                </tr>
            </table>
            <input type="hidden" name="storyId" value="1" />
            <button type="submit" id="btnInsert">회차 수정</button>
        </form>
    </div>
</body>
</html>
