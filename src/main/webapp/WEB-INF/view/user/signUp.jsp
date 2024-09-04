<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>회원가입</h1>
	<!-- 회원가입 폼 -->
	<form action="/user/sign-up" method="post">
		<div>
			<label for="nickName">닉네임:</label> 
			<input type="text" id="nickName" name="nickName" required value="${nickName}">
			<button type="button" onclick="checkNickName()">중복확인</button>
		</div>

		<!-- 이메일 입력 섹션 -->
		<div id="emailSection">
			<label for="email">이메일 :</label> <input type="email" id="email" name="email" required placeholder="이메일을 입력하세요">
			<button type="button" id="emailButton">인증 요청</button>

			<!-- 이메일 중복 여부를 표시할 텍스트 -->
			<div id="emailCheckMessage" style="color: red; font-size: 12px;"></div>
			<!-- 여기에 메시지가 표시됩니다. -->
		</div>

		<!-- 인증 코드 입력 섹션 -->
		<div id="verificationSection" style="display: none;">
			<!-- 숨겨진 이메일 필드 (input type="hidden"으로 설정) -->
			<input type="hidden" id="verificationEmail"> <label for="authCode">인증 번호 :</label> <input type="text" id="authCode" name="code" required placeholder="인증 코드를 입력하세요">
			<button type="button" id="verificationButton">인증 확인</button>
		</div>

		<div>
			<label for="password">비밀번호:</label> <input type="password" id="password" name="password" required value="${password}">
		</div>

		<div>
			<button type="submit">가입하기</button>
		</div>
	</form>

	<!-- 소셜 로그인 버튼 -->
	<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=6d77c46fd0cf14b69558985620414300
&redirect_uri=http://localhost:8080/user/kakao"> <img
		alt="카카오로그인이미지" src="/images/kakaologin.png" style="width: 50px; height: auto;">
	</a>
	<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver"> <img
		alt="네이버로그인이미지" src="/images/naverlogin.png" style="width: 50px; height: auto;">
	</a>
	<a
		href="https://accounts.google.com/o/oauth2/v2/auth
	?client_id=371075313637-tr9gs2bsjn7u4o5qk79s800e1g9r30u6.apps.googleusercontent.com
	&redirect_uri=http://localhost:8080/user/google
	&response_type=code&scope=email profile">
		<img alt="구글로그인이미지" src="/images/googlelogin.png" style="width: 50px; height: auto;">
	</a>

	<!-- 로그인 페이지 이동 -->
	<a href="/user/sign-in">로그인 페이지 이동</a>
	<script src="/js/nickName.js"></script>
	<script src="/js/signUp.js"></script>
</body>
</html>
