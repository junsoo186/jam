<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>작품 정보 입력</title>
</head>
<body>
    <h1>작품 정보 입력</h1>
    <form action="workInsert" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>유저 ID:</td>
                <td><input type="number" name="userId" value="1" required /></td>
            </tr>
            <tr>
                <td>작품 제목:</td>
                <td><input type="text" name="title" value="테스트 제목" required /></td>
            </tr>
            <tr>
                <td>저자 코멘트:</td>
                <td><textarea name="authorComment" required>테스트 저자 코멘트</textarea></td>
            </tr>
            <tr>
                <td>저자:</td>
                <td><input type="text" name="author" value="테스트 저자" required /></td>
            </tr>
            <tr>
                <td>연령:</td>
                <td>
                    <select name="age" required>
                        <option value="전체">전체</option>
                        <option value="7">7</option>
                        <option value="12">12</option>
                        <option value="15">15</option>
                        <option value="19">19</option>
                    </select>
                </td>
            </tr>
        </table>
        <button type="submit">작품 등록</button>
    </form>
</body>
</html>
