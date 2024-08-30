<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
    /* 모바일 환경에서의 스타일 설정 */
.nav,content-container{
    display: flex; /* Flexbox 컨테이너로 설정 */
    flex-wrap: wrap; /* 요소가 한 줄에 들어가지 않을 경우 줄 바꿈 */
    justify-content: flex-start; 
}

.mobile-show {
    display: flex; /* Flexbox 컨테이너로 설정 */
    flex-wrap: wrap; /* 요소가 한 줄에 들어가지 않을 경우 줄 바꿈 */
    justify-content: space-between; /* 요소들 간의 간격을 균등하게 분배 */
    width: 100%; /* 컨테이너의 가로 너비를 100%로 설정 */
    margin-bottom: 20px; /* 하단 여백 */
    border: 1px solid #ddd; /* 테두리 */
    background-color: #f9f9f9; /* 배경색 */
}
.mobile-m-box {
    width: 20%; /* 각 항목의 너비를 20%로 설정하여 한 줄에 다섯 개의 항목을 배치 */
    margin-bottom: 10px; /* 항목 간의 여백 */
}


    .cover_style_m {
        width: 80px; /* 커버 이미지의 가로 크기 설정 */
        height: auto; /* 세로 크기는 자동으로 설정 */
    }

    .info_st {
        padding: 5px 0px 0px 15px; /* 텍스트의 안쪽 여백 */
        width: 100%; /* 정보 셀의 너비 */
        vertical-align: top; /* 텍스트를 상단에 정렬 */
    }

    .hash_tag_off_m {
        display: inline-block; /* 인라인 블록으로 설정하여 각 해시태그를 나란히 표시 */
        background-color: #f0f0f0; /* 해시태그의 배경색 */
        padding: 2px 6px; /* 해시태그 안쪽 여백 */
        margin-right: 5px; /* 해시태그 우측 여백 */
        border-radius: 3px; /* 모서리를 둥글게 설정 */
        font-size: 12px; /* 글자 크기 */
        color: #333; /* 글자 색상 */
    }

    table {
        width: 100%; /* 테이블 너비를 100%로 설정 */
        border-collapse: collapse; /* 테이블 경계를 하나로 합침 */
    }

    td {
        padding: 5px; /* 테이블 셀의 안쪽 여백 */
        vertical-align: top; /* 셀 내 텍스트 상단 정렬 */
    }
</style>
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>

<body>
    <div class="btn-area">
        <form action="workInsert" method="get">
            <button type="submit" id="btnInsert">신규 작품 등록</button>
        </form>
    </div>
    <div class="navbar">
        <a href="#myWorks">작품관리</a>
        <a href="#supportManagement">후원관리</a>
        <a href="#workStatistics">정산</a>
        <a href="#settlement">펀딩관리</a>
    </div>

    <div class="container">
    </div>
        <!-- 콘텐츠 영역 -->

        <!-- 이미지와 추가 콘텐츠들 -->
    <%-- 조건절 1: bookList가 null이 아닐 때 --%>
    <div class="content-container">
    <c:choose>
        <c:when test="${bookList != null}">
            <%-- bookList가 존재할 때 --%>
       
            <c:forEach var="list" items="${bookList}">
                <div class="mobile-show mobile-m-box novel-${list.bookId} s-inv">
                    <table>
                        <tr>
                            <td style="width:80px;">
                                <div style="position:relative;" onclick="location.href='/write/workDetail?bookId=${list.bookId}&userId=${principal.userId }'">
                                    <!-- 작품 리스트 모바일 커버이미지 -->
                                    <img src="//images.novelpia.com/img/new/icon/count_book.png" class="cover_style_m">
                                    ${principal.userId}
                                </div>
                            </td>
                            <td class="info_st">
                                <div style="position:relative;">
                                    <b style="font-size:1.3em; letter-spacing: -1px;" class="cut_line_one" onclick="location.href='/write/workDetail?bookId=${list.bookId}'">${list.title}</b>
                                    <span class="info_font">
                                        <%-- <b style="cursor:pointer; font-weight:500;" onclick="location.href='/user/${list.userId}'>${list.author}</b> --%>
                                    </span><br>
                                    <span style="font-size:12px; font-weight:600; color:#333;">
                                        <img src="//images.novelpia.com/img/new/icon/count_good.png"> ${list.likes}
                                    </span><br>
                                    <span onclick="location.href='/write/workDetail?bookId=${list.bookId}'" style="font-size:12px; font-weight:600; color:#333;">
                                        <%-- 태그 목록 출력 --%>
                                        <c:forEach var="tag" items="${list.tagNames}">
                                            <span class="hash_tag_off_m">#${tag}</span>
                                        </c:forEach>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table style="float:right; margin:0px 0px 10px 0px;">
                                    <tr>
                                        <td><a href="/write/storyInsert?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_episode.png" style="width:100%;"></a></td>
                                        <td><a href="/write/workUpdate?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" style="width:100%;"></a></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
        	book값 없음
        </c:otherwise>
    </c:choose>

    </div>
</body>
</html>
