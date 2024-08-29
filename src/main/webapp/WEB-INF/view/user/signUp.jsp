<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <h1>회원가입</h1>
    <form action="/user/sign-up" method="post">
        <div>
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" required value="${name}">
        </div>
        
        <div>

            <label for="birthDate">생년월일:</label>
            <input type="text" id="birthDate" name="birthDate" required value="${birthDate}">
            
        </div>
        
        <div>
            <label for="gender">성별:</label>
            <input type="radio" id="남" name="gender" value="M">
                 <label for="male">남</label>
            <input type="radio" id="여" name="gender" value="F">
                 <label for="female">여</label>
        </div>
        
        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required value="${email}">
        </div>
        
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required value="${password}">
        </div>
        
        <div>
            <label for="password"></label>
            <input type="hidden" id="text" name="adminCheck" required value="user">
        </div>
        
        <div>
            <label>통신사:</label>
            <input type="radio" id="skt" name="carrier" value="SKT" required>
            <label for="skt">SKT</label>
            <input type="radio" id="kt" name="carrier" value="KT">
            <label for="kt">KT</label>
            <input type="radio" id="lgup" name="carrier" value="LGU+">
            <label for="lgup">LGU+</label>
        </div>
        
        <div>
            <label for="phoneNumber">휴대폰 번호:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" required value="${phoneNumber}">
            <button type="button" onclick="sendSMS()">발송</button>
        </div>
        
        <div>
            <label for="verificationCode">인증번호:</label>
            <input type="text" id="verificationCode" name="verificationCode" required>
            <button type="button" onclick="verifyCode()">인증</button>
        </div>
        
        <div>
            <label for="nickName">닉네임:</label>
            <input type="text" id="nickName" name="nickName" required value="${nickName}">
        </div>
        
        <div>
            <button type="submit">가입하기</button>
        </div>
    </form>
    
<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=da70bb7a1f4babcdcd8957d9785e99c4&redirect_uri=http://localhost:8080/user/kakao"><img alt="카카오로그인이미지" src="/images/kakaologin.png"></a>    
<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=VV02L4roYlvMO2qxf3n7&state=STATE_STRING&redirect_uri=http://localhost:8080/user/naver">네이버?</a>

</body>
</html>