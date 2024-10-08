<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="/css/user/signIn.css">

<main>

	<section class="center--login--area">
		<h1>로그인</h1>
		     <img src="/images/layout/jam.png" alt="로그인 아이콘" class="login-icon">
		<form action="/user/sign-in" method="post">
			<div>
				<label for="email"></label> <input type="email" id="email" name="email" required value="${email}" class="input--area" placeholder="이메일">
			</div>
			<div>
				<label for="password"></label> <input type="password" id="password" name="password" required value="${password}" class="input--area" placeholder="비밀번호">
			</div>
			<button type="submit" class="btn--login">로그인</button>
		</form>
		<div class="bottom--easyLogin">
			<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakaoLogin"> <img
				alt="카카오로그인이미지" src="/images/login/kakaologin.png" style="width: 50px; height: auto;"></a> <a
				href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user//naverLogin"><img
				alt="네이버로그인이미지" src="/images/login/naverlogin.png" style="width: 50px; height: auto;"></a> <a
				href="https://accounts.google.com/o/oauth2/v2/auth
			?client_id=371075313637-tr9gs2bsjn7u4o5qk79s800e1g9r30u6.apps.googleusercontent.com
			&redirect_uri=http://localhost:8080/user/googleLogin
			&response_type=code&scope=email profile"><img
				alt="구글로그인이미지" src="/images/login/googlelogin.png" style="width: 50px; height: auto;"></a>
		</div>
			<div class="bottom--findsignup">
		<a href="/user/sign-up">회원가입 |</a>
		<a href="#" onclick="openEmailPopup(); return false;">아이디 찾기 |</a>
		<a href="#" onclick="openPasswordPopup(); return false;">비밀번호 찾기</a>
	</div>
		
	</section>



	<script>
		// 팝업을 여는 함수
		// 아이디 찾기 팝업
		function openEmailPopup() {
			window.open('/user/find-email', 'findEmailPopup',
					'width=600,height=400,resizable=no');
		}

		// 비밀번호 찾기 팝업
		function openPasswordPopup() {
			window.open('/user/find-password', 'findPasswordPopup',
					'width=600,height=400,resizable=no');
		}
	</script>
</main>
</body>
</html>