<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>로그인</h1>

  	<section>
       <form action="/user/login" method="post">

        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required value="${email}">
        </div>

        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required value="${password}">
        </div>

        <button type="submit">로그인</button>

        <a href="/user/sign-up">회원가입</a>
         <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=nOAefk8qDJZC5X5ZLiOi&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver">네이버?</a>
        </form>
        </form>
      
  
  
  	</section>
</body>
</html>