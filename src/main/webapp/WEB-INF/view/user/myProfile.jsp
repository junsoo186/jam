<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/signIn.css">
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<main>
	
	<form action="/user/userModify1212" method="post">
	
	<input type="hidden" name="userId" value="${principal.userId}">
	<input type="hidden" name="createdAt" value="${principal.createdAt}">
	<input type="hidden" name="profileImg" value="${principal.profileImg}">
	
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
	
	
		
	</script>


</main>
</body>
</html>