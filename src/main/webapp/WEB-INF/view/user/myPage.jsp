
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/signIn.css">
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<main>
<%-- <div class="mb-3">제목: ${qna.title}</div> --%>
<div>
	<div>회원관리</div>
	<div>결제내역</div>
	<div>차단관리</div>
	<div>이벤트내역</div>
</div>

<div>닉네임 : ${principal.nickname}</div>
<div>이메일 : ${principal.email}</div>
	

</main>
</body>
</html>