<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${nickname}님 채팅</title>
</head>
<body>
<<<<<<< HEAD
<th:block th:replace="~{/layout/basic :: setContent(~{this :: content})}">
    <th:block th:fragment="content">
    
        <div class="container">
            <div class="col-6">
                <label><b>채팅방</b></label>
            </div>
            <div>
                <div id="msgArea" class="col"></div>
                <div class="col-6">
                    <div class="input-group mb-3">
                        <input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </th:block>
</th:block>

</body>
</html>
<script type="text/javascript" src="/js/chat.js"></script>
=======
	<section>
		<textarea class="text" rows="10" ></textarea>
	<form class = "bottom--send--area" action="">
	<input class = "text">
	<div class = "btn--area ">
		<button type="button">전송</button>
	</div>
	</form>

</body>
</html>
>>>>>>> d807565 (create - chat)
