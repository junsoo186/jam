<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>






	<h1>로그인</h1>

	<form action="" method="post">

		<div>
			<label for="email">이메일:</label> <input type="email" id="email" name="email" required value="${email}">
		</div>

		<div>
			<label for="password">비밀번호:</label> <input type="password" id="password" name="password" required>
		</div>

		<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver">네이버?</a>
	</form>



</body>
</html>