<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

  <h1>로그인</h1>

  	<section>
       <form action="/user/sign-in" method="post">

        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required value="${email}">
        </div>

        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required value="${password}">
        </div>

        <button type="submit">로그인</button>

        
        <a href="/user/sign-up">회원가입</a>
        
        <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakao"> <img
		alt="카카오로그인이미지" src="/images/kakaologin.png" style="width: 50px; height: auto;"></a>
		
	<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver"><img
		alt="네이버로그인이미지" src="/images/naverlogin.png" style="width: 50px; height: auto;"></a>
		
	<a href="https://accounts.google.com/o/oauth2/v2/auth
	?client_id=255102770612-bdsf8jq495pk9qi7nm76vprplo1upve7.apps.googleusercontent.com
	&redirect_uri=http://localhost:8080/user/google
	&response_type=code&scope=email profile"><img
	alt="구글로그인이미지" src="/images/googlelogin.png" style="width: 50px; height: auto;"></a>
        
        
		</form>
		
		
       

  
  	</section>
</body>
</html>