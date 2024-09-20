<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/user/signUp.css">
<body>

	<main>

		<section class="center--login--area">
		     <img src="/images/layout/jam.png" alt="로그인 아이콘" class="login-icon">
			<!-- 회원가입 폼 -->
			<form action="/user/sign-up" method="post" enctype="multipart/form-data">
				<div>
					<label for="nickName">닉네임</label>
					<input type="text" id="nickName" name="nickName" class="input--area" required>
					<span id="nickNameCheckMessage"></span>
					<button type="button" onclick="checkNickName()" class="side--btn--check">중복확인</button>
				</div><br>

				<!-- 이메일 입력 섹션 -->
				<div id="emailSection">
					<label for="email">이메일</label>
					<input type="email" id="email" name="email" class="input--area"  required placeholder="이메일을 입력하세요">
					<button type="button" id="emailButton" class="side--btn--check">인증 요청</button>

					<!-- 이메일 중복 여부를 표시할 텍스트 -->
					<div id="emailCheckMessage" style="color: red; font-size: 12px;"></div>
					<!-- 여기에 메시지가 표시됩니다. -->
				</div>

				<!-- 인증 코드 입력 섹션 -->
				<div id="verificationSection" style="display: none;">
					<!-- 숨겨진 이메일 필드 (input type="hidden"으로 설정) -->
					<input type="hidden" id="verificationEmail"> <label for="authCode">인증 번호</label> <input type="text" id="authCode" class="input--area"  name="code" required placeholder="인증 코드를 입력하세요">
					<button type="button" id="verificationButton" >인증 확인</button>
				</div><br>

				<!-- 비밀번호 입력 섹션 -->
				<div>
					<label for="password">비밀번호</label> <input type="password" id="password" name="password" class="input--area"  required value="${password}">
				</div>

				<!-- 프로필 이미지 업로드 섹션 -->
				<div>
					<label for="mFile">프로필 이미지:</label> <input type="file" id="mFile" name="mFile" accept="image/*">
					<!-- 이미지 미리보기 -->
					<img id="previewImage" src="#" alt="이미지 미리보기" style="display: none; width: 100px; height: 100px;">
				</div>

				<div>
					<button type="submit">가입하기</button>
				</div>
			</form>


			<!-- 로그인 페이지 이동 -->
			<a href="/user/sign-in">로그인 페이지 이동</a>
		</section>
	</main>
	<script src="/js/signUp.js"></script>
</body>
</html>
