<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${storyContent.title}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
        integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script type="text/javascript" src="/js/turn.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/storyContent.css">
    <script type="text/javascript">
        // 서버 측 변수를 클라이언트 측에서 사용할 수 있도록 JavaScript 변수에 할당
        var storyContentContents = `${storyContent.contents}`;
        var storyComment = `${storyContent.comment}`;
    </script>
    <script type="text/javascript" src="/js/storyContent.js"></script>
</head>
<body>
    <div class="title-area">
        <h1>${storyContent.title}-회차 ${storyContent.number}</h1>
    </div>

    <div class="container">
        <div id="flipbook" class="flipbook"></div>

        <div class="btn-area">
            <div class="top-buttons">
                <div class="left">
                    <form action="workDetail" method="get" style="margin: 0;">
                        <input type="hidden" name="bookId" value="${storyContent.bookId}">
                        <button type="submit" id="btnInsert" class="setting-btn">홈</button>
                    </form>
                </div>
                <div class="right">
                    <button type="button" class="like-btn" onclick="likeStory()">좋아요</button>
                    <button type="button" class="setting-btn" id="settingsButton">설정</button>
                </div>
            </div>
            <div class="bottom-buttons">
                <button type="button" class="comment-btn" onclick="toggleComments()">댓글 보기</button>
            </div>
        </div>

        <div id="settingsMenu" class="settings-menu">
            <h3>설정 메뉴</h3>
            <!-- 설정 옵션들 추가 -->
            <button type="button" onclick="alert('옵션 1')">옵션 1</button>
            <button type="button" onclick="alert('옵션 2')">옵션 2</button>
            <!-- 추가 옵션들 -->
        </div>

        <div id="commentBox" class="comment-box">
            <h3>댓글</h3>
            <p>여기에 댓글이 표시됩니다.</p>
            <button type="button" onclick="closeComments()" class="close-comment-btn">닫기</button>
        </div>
    </div>
</body>
</html>
