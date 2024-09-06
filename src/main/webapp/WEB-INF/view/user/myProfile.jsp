<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <link rel="stylesheet" href="/css/signIn.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        main {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
            padding-right: 10px;
            text-align: right;
        }
        input {
            padding: 8px;
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-actions {
            display: flex;
            justify-content: space-around;
            padding-top: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-actions button:hover {
            background-color: #0056b3;
        }
        #previewImage {
            display: block;
            margin-top: 10px;
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }
    </style>
</head>
<body>

<main>
    <form action="/user/userModify1212" method="post" enctype="multipart/form-data">
        <input type="hidden" name="userId" value="${principal.userId}">
        <input type="hidden" name="createdAt" value="${principal.createdAt}">
        <input type="hidden" name="profileImg" value="${principal.profileImg}">
        
        <div class="form-group">
            <label for="mFile">프로필 이미지</label>
            <img id="previewImage" src="${principal.profileImg}" alt="Profile Image">
            <input type="file" id="mFile" name="mFile" accept="image/*">
        </div>
        
        <div class="form-group">
            <label for="nickName">닉네임</label>
            <input type="text" name="nickName" id="nickName" value="${principal.nickName}">
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
            <input type="text" name="phoneNumber" id="phoneNumber" value="${principal.phoneNumber}">
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
            <button type="submit">수정하기</button>
        </div>
    </form>
</main>

<script>

	//현재 날짜를 가져와 max 속성으로 설정
	const birthDateInput = document.getElementById('birthDate');
	const today = new Date().toISOString().split('T')[0]; // 현재 날짜 형식화
	birthDateInput.setAttribute('max', today); // max 속성에 현재 날짜 설정

    document.getElementById('mFile').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewImage = document.getElementById('previewImage');
                previewImage.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>
