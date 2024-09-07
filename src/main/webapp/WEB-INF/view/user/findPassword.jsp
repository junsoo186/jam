<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀 번호 찾기</title>
</head>
<body>
	<form>
		<div id="emailSection">
			<label for="email">이메일:</label> <input type="email" id="email" name="email" required>
			<div id="emailCheckMessage"></div>
			<button type="button" id="emailButton">이메일 인증 요청</button>
		</div>
		<div id="verificationSection" style="display: none;">
			<input type="hidden" id="verificationEmail"> <label for="authCode">인증 코드:</label> <input type="text" id="authCode" name="authCode" required>
			<button type="button" id="verificationButton">인증 확인</button>
		</div>

		<div id="resetPasswordSection" style="display: none;">
			<label for="newPassword">새 비밀번호:</label> <input type="password" id="newPassword" name="newPassword" required> <label for="confirmPassword">비밀번호 확인:</label> <input
				type="password" id="confirmPassword" name="confirmPassword" required>
				<div id="passwordError" style="color:red; display:none;"></div>
			<button type="button" id="resetPasswordButton">비밀번호 재설정</button>
			
		</div>
	</form>


	<script type="text/javascript" src="/js/findPassword.js"></script>
</body>
</html>