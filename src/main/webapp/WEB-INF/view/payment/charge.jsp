<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/charge.css">
<link rel="stylesheet" href="/css/common.css">
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h2>충전 페이지</h2>

<head>
    <script>
       
        function handleClick(id) {
            var element = document.getElementById(id);
            element.style.backgroundColor = 'pink'; // 클릭 시 핑크로 변경
        }
    </script>
</head>
<body>
    <button id="button1" onclick="handleClick('button1')">22</button>
    <button id="button2" onclick="handleClick('button2')">50 + 5</button>
    <button id="button3" onclick="handleClick('button3')">60 + 7</button>
    <button id="button4" onclick="handleClick('button4')">100 + 20</button>
    <button id="button5" onclick="handleClick('button5')">200 + 45</button>
    <button id="button6" onclick="handleClick('button6')">350 + 105</button>
    <button id="button7" onclick="handleClick('button7')">500 + 175</button>

</body>
</html>