<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/signIn.css">
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<main>
	
	<form action="/user/userModify1212" method="post" enctype="multipart/form-data">
	
	<input type="hidden" name="userId" value="${principal.userId}">
	<input type="hidden" name="createdAt" value="${principal.createdAt}">
	<input type="hidden" name="profileImg" value="${principal.profileImg}">
	
	<!-- 프로필 원형 이미지 -->
	 <div class="profile-image" id="">${principal.profileImg}</div> 
	 <div>
		<label for="mFile">프로필 이미지:</label>
		<input type="file" id="mFile" name="mFile" accept="image/*" required>
		<!-- 이미지 미리보기 -->
		<img id="previewImage" src="#" alt="이미지 미리보기" style="display: none; width: 100px; height: 100px;">
	</div>
	
		<label>닉네임</label>
		<input type="text" name="nickName" value="${principal.nickName}" id ="nickName" >
		
		<label>이름</label>
		<input type="text" name="name" value="${principal.nickName}" id ="nickName">
		
		<label>이메일</label>
		<input type="text" name="email" value="${principal.email}" id = "email" required="required" readonly >
		
		<label>전화번호</label>
		<input type="text" name = "phoneNumber" value="${principal.phoneNumber}" id = "phoneNumber">
		
		<label>주 소</label>
		<input type="text" name="address" value="${principal.address}" id = "address" required>
		
		<label>생 일</label>
		<input type="date" name="birthDate" value="${principal.birthDate}" id ="birthDate" required>
		
		<button type="submit">수정하기</button>

	</form>
	
	<script type="text/javascript">
	
	// 현재 날짜를 가져와 max 속성으로 설정
	const birthDateInput = document.getElementById('birthDate');
	const today = new Date().toISOString().split('T')[0]; // 현재 날짜 형식화
	birthDateInput.setAttribute('max', today); // max 속성에 현재 날짜 설정
	
	<!-- 프로필 이미지 업로드 섹션 -->
	// 이미지 미리보기
	document.getElementById('mFile').addEventListener('change', function(event) {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				const previewImage = document.getElementById('previewImage');
				previewImage.src = e.target.result;
				previewImage.style.display = 'block';
			};
			reader.readAsDataURL(file);
		}
	});
		
	</script>


</main>
</body>
</html>