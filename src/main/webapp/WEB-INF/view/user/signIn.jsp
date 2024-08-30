<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/signIn.css">
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<main>

  	<section class="center--login--area">
  		<h1>로그인</h1>
       <form action="/user/sign-in" method="post">

        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required value="${email}" class="input--area">
        </div>

        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required value="${password}"class="input--area">
        </div>
        
        
        <button type="submit" class="btn--login">로그인</button>
	</form>


        <div class="bottom--easyLogin">
     			
        
        		<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakao"> <img
						alt="카카오로그인이미지" src="/images/kakaologin.png" style="width: 50px; height: auto;">
						</a>
				<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver"><img
						alt="네이버로그인이미지" src="/images/naverlogin.png" style="width: 50px; height: auto;"></a>
		
				<a href="https://accounts.google.com/o/oauth2/v2/auth
						?client_id=255102770612-bdsf8jq495pk9qi7nm76vprplo1upve7.apps.googleusercontent.com
						&redirect_uri=http://localhost:8080/user/google
						&response_type=code&scope=email profile">구글</a>	
		</div>
  	</section>
		<div class="bottom--findsignup">
		<a href="/user/sign-up">회원가입 |</a>
		<a href="/user/sign-up">아이디 찾기 |</a>
		<a href="/user/sign-up">비밀번호 찾기</a>
		</div>
  	
</main>
</body>
</html>