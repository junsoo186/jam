<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 성공</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 100%;
        max-width: 500px;
        margin: 0 auto;
        background-color: white;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-top: 50px;
        text-align: center;
    }

    h1 {
        font-size: 24px;
        margin-bottom: 20px;
        color: #333;
    }

    .info-box {
        border: 1px solid #e0e0e0;
        padding: 15px;
        margin-bottom: 20px;
        text-align: left;
    }

    .info-box p {
        margin: 10px 0;
        font-size: 16px;
        color: #333;
    }

    .highlight {
        font-size: 18px;
        color: #007BFF;
        font-weight: bold;
    }

    .button-container {
        text-align: center;
        margin-top: 20px;
    }

    .button-container a {
        display: inline-block;
        padding: 15px 30px;
        background-color: #007BFF;
        color: white;
        text-decoration: none;
        font-size: 16px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .button-container a:hover {
        background-color: #0056b3;
    }

    .button-container a.back-home {
        display: block;
        width: 100%;
        margin-top: 10px;
        padding: 15px;
        background-color: #ff4b4b;
    }

    .button-container a.back-home:hover {
        background-color: #d12d2d;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>주문 완료</h1>
        <p> 결제 완료처리가 완료 되었습니다.</p>

       

        <div class="button-container">
            <a href="/" class="back-home">홈으로</a>
        </div>
    </div>
</body>
</html>
