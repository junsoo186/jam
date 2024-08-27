<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <main class="content-wrapper">
        <section class="form-title">
            <h1>작품 추가</h1>
        </section>

        <section>
            <form action="workInsert" method="post">

                <table>
                    <tr>
                        <th>작품명</th>
                        <td>
                            <input type="text" class="inputs title" id="title">
                        </td>
                    </tr>
                    
                    <!-- <tr>
                        <th>분류</th>
                        <td>
                            <input type="text" class="inputs username" readonly>
                        </td>
                    </tr> -->
                   
                   
                    <tr>
                        <th>내용</th>
                        <td>
                            <div class="img-box">이미지 미리보기</div>
                            <textarea name="" id="content" class="contents"></textarea>
                        </td>
                    </tr>
                    
                </table>
                    <button type="submit" class="btn">작성완료</button>
                
            </form>
            </section>

     </main>
    
</body>
</html>