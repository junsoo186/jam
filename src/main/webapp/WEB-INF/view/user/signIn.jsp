<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="/user/sign-in" method="post">
		<div class="">
			<label for="username">Id:</label>
			<input type="text" class="" placeholder="Enter username" id="username" name="username" value="사용자">
		</div>
		<div class="">
			<label for="pwd">Password:</label>
			<input type="password" class="" placeholder="Enter password" id="pwd" name="password" value="1234">
		</div>
		<button type="submit" class="btn">로그인</button>
		<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakao">fffffff</a>
	</form>

</body>
</html>