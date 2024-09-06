<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 가입 여부</title>
</head>
<body>
	<h2>이메일 가입 여부 확인</h2>

	<form onsubmit="checkEmail(event)">
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">확인</button>
    </form>

    <div id="result"></div> <!-- 이메일 체크 결과를 출력할 영역 -->
	<!-- 외부 JS 파일 연결 -->
	<script src="/js/findEmail.js"></script>
</body>
</html>
