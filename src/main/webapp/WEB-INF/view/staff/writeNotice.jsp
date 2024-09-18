
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/noticeUpdate.css">
<!-- CKEditor 스크립트 추가 -->
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>


<div class="container p-5">
	<div class="card">
		<div class="card-header">
			<h2>게시글 글쓰기</h2>
		</div>
		<div class="card-body">
			<h3>공지사항 글쓰기</h3>
			<form action="/staff/insert" method="post">
				<div class="mb-3">
					<input type="text" class="form-control" value="${noticeList.noticeTitle}" name="noticeTitle" required>
				</div>
				<div class="mb-3">
					<!-- ID를 추가하여 CKEditor가 적용될 대상을 명확하게 지정 -->
					<textarea id="noticeContent" class="form-control" rows="5" name="noticeContent" >${noticeList.noticeContent}</textarea>
				</div>
				<button type="submit" class="btn btn-primary form-control">작성</button>
			</form>
		</div>
	</div>
</div>

<!-- CKEditor 초기화 스크립트 -->
<script>
    ClassicEditor
        .create(document.querySelector('#noticeContent'), {
            toolbar: ['bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', 'imageUpload'],
            ckfinder: {
                uploadUrl: '/staff/image-upload' // 서버 이미지 업로드 엔드포인트
            }
        })
        .catch(error => {
            console.error(error);
        });
</script>
'
<script type="text/javascript" src="/js/navigation.js"></script>

