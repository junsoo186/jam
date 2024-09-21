<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="/css/signIn.css">
<link rel="stylesheet" href="/css/user/myProfile.css">

</head>
<body>
	<%@ include file="/WEB-INF/view/layout/header.jsp"%>

	<main>
		<form action="/user/userModify1212" method="post" enctype="multipart/form-data" class="form-group">
			<input type="hidden" name="userId" value="${principal.userId}"> <input type="hidden" name="createdAt" value="${principal.createdAt}"> <input type="hidden"
				name="profileImg" value="${principal.profileImg}">

			<div class="form-group">
				<label for="mFile">프로필 이미지</label> <img id="previewImage" src="${principal.profileImg}" alt="Profile Image"> <input type="file" id="mFile" name="mFile" accept="image/*">
			</div>

			<div class="form-group">
	            <label for="nickName">닉네임</label>
	            <input type="text" name="nickName" id="nickName" value="${principal.nickName}" required="required">
	            <span id="nickNameCheckMessage"></span>
	            <button type="button" onclick="checkNickName()">중복확인</button>
        	</div>

			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" name="name" id="name" value="${principal.name}">
			</div>

			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" name="email" id="email" value="${principal.email}" readonly>
			</div>

			<div class="form-group">
				<label for="phoneNumber">전화번호</label>
				<input type="text" name="phoneNumber" id="phoneNumber" oninput="validatePhoneNumber(this)" placeholder="010123456789" value="${principal.phoneNumber}">
			</div>

			<div class="form-group">
				<label for="address">주소</label>
				<input type="text" name="address" id="address" value="${principal.address}" required>
			</div>

			<div class="form-group">
				<label for="birthDate">생일</label>
				<input type="date" name="birthDate" id="birthDate" value="${principal.birthDate}" required>
			</div>

			<div class="form-actions">
				<button type="submit" id="modify">수정하기</button>
			</div>

		</form>
		<div class="form-actions">
			<button type="submit">
				<a href="/user/myPage">마이페이지로 돌아가기</a>
			</button>
		</div>
	</main>

<script src="/js/ProfileModifyNickname.js"></script>

</body>
</html>
