
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/signIn.css">
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<main>
	<%-- <div class="mb-3">제목: ${qna.title}</div> --%>
	<div>

		<li><a href="">회원관리</a></li>
		<li><a href="">결제내역</a></li>
		<li><a href="">차단관리</a></li>
		<li><a href="">이벤트내역</a></li>

	</div>
	<div>닉네임 : ${principal.nickName}</div>
	<div>이메일 : ${principal.email}</div>
	<div>전화번호 : ${principal.phoneNumber}</div>
	<div>주 소 :
		<c:if test="${principal.address eq null}">
    		정보없음
		</c:if>
		<c:if test="${principal.address ne null}">
    		${principal.address}
		</c:if>
	</div>
	
	<div>생 일 :
		<c:if test="${principal.birthDate eq null}">
    		정보없음
		</c:if>
		<c:if test="${principal.birthDate ne null}">
    		${principal.birthDate}
		</c:if>
	</div>
	
	<div>포인트 :
		<c:if test="${principal.point eq null}">
    		정보없음
		</c:if>
		<c:if test="${principal.point ne null}">
    		${principal.point}
		</c:if>
	</div>

	<div>
		<a href="/user/myProfileModify">수정하기</a>
	</div>


</main>
</body>
</html>