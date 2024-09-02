<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "/WEB-INF/view/layout/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<main>

<meta charset="UTF-8">
<title>메인화면</title>
</head>
<body>
	${principal.userId}
	${principal.email}
	<h1>메인화면입니다</h1>
</main>


