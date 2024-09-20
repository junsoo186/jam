<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/user/findPassword.css">
<meta charset="UTF-8">
<title>비밀 번호 찾기</title>
</head>
<body>
<h2>비밀 번호 찾기</h2>
	<div class="findPassword">
	<form>
		<div id="emailSection">
		<div class="inputpass">
			<label for="email"></label> <input type="email"  id="email" name="email" required placeholder="이메일">
			</div>
			<div id="emailCheckMessage"></div>
			<button type="button" id="emailButton">이메일 인증 요청</button>
		</div>
		<div id="verificationSection" style="display: none;">
			<input type="hidden" id="verificationEmail">
			<div class="inputpass">
			<label for="authCode"><h4>인증 코드:</h4></label> <input type="text" class="input--class" id="authCode" name="authCode" required>
			</div>
			<button type="button" id="verificationButton">인증 확인</button>
		</div>

		<div id="resetPasswordSection" style="display: none;">
			<label for="newPassword">새 비밀번호:<br></label> <input type="password" id="newPassword" name="newPassword" required> <label for="confirmPassword">비밀번호 확인:</label> <input
				type="password" id="confirmPassword" name="confirmPassword" required>
				<div id="passwordError" style="color:red; display:none;"></div>
			<button type="button" id="resetPasswordButton">비밀번호 재설정</button>
			
		</div>
	</form>
</div>

	<script type="text/javascript" src="/js/findPassword.js"></script>
</body>
</html>