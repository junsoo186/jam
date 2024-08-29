<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<<<<<<< HEAD:src/main/webapp/WEB-INF/view/user/login.jsp
=======

>>>>>>> 0ff68240bb409579f0bcb01400ab722a49cddab0:src/main/webapp/WEB-INF/view/user/signIn.jsp
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
<<<<<<< HEAD:src/main/webapp/WEB-INF/view/user/login.jsp
=======
        
        <a href="/user/sign-up">회원가입</a>
        
        <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=nOAefk8qDJZC5X5ZLiOi&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver">네이버?</a>
		</form>
       

>>>>>>> 0ff68240bb409579f0bcb01400ab722a49cddab0:src/main/webapp/WEB-INF/view/user/signIn.jsp

        <a href="/user/sign-up">회원가입</a>
         <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=nOAefk8qDJZC5X5ZLiOi&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver">네이버?</a>
        </form>
        </form>
      
  
  
  	</section>
</body>
</html>