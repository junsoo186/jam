<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>회원가입</h1>
	<form action="/user/sign-up" method="post">

		<div>
			<label for="nickName">닉네임:</label> <input type="text" id="nickName" name="nickName" required value="${nickName}">
		</div>

		<input type="hidden" id="phoneNumber" name="phoneNumber" required value="01012345678">

		<%--
         <div>
            <label>통신사:</label>
            <input type="radio" id="skt" name="carrier" value="SKT" required>
            <label for="skt">SKT</label>
            <input type="radio" id="kt" name="carrier" value="KT">
            <label for="kt">KT</label>
            <input type="radio" id="lgup" name="carrier" value="LGU+">
            <label for="lgup">LGU+</label>
        </div>
 --%>

		<%-- 
        <div>
            <label for="phoneNumber">휴대폰 번호:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" required value="${phoneNumber}">
            <button type="button" onclick="sendSMS()">발송</button>
        </div>
  --%>

		<%--
        <div>
            <label for="verificationCode">인증번호:</label>
            <input type="text" id="verificationCode" name="verificationCode" required>
            <button type="button" onclick="verifyCode()">인증</button>
        </div>
 --%>
		<div>
			<label for="email">이메일:</label> <input type="email" id="email" name="email" required value="${email}">
		</div>

		<div>
			<label for="password">비밀번호:</label> <input type="password" id="password" name="password" required value="${password}">
		</div>

		<div>
			<button type="submit">가입하기</button>
		</div>
	</form>
	<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakao"> <img
		alt="카카오로그인이미지" src="/images/kakaologin.png" style="width: 50px; height: auto;">
	</a>
	<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver"><img
		alt="네이버로그인이미지" src="/images/naverlogin.png" style="width: 50px; height: auto;"></a>

	<a href="https://accounts.google.com/o/oauth2/v2/auth
	?client_id=255102770612-bdsf8jq495pk9qi7nm76vprplo1upve7.apps.googleusercontent.com
	&redirect_uri=http://localhost:8080/user/google
	&response_type=code&scope=email profile">구글</a>	

	<a href="/user/sign-in">로그인 페이지 이동</a>

</body>
</html>