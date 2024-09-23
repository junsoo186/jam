<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/eventWrite.css">
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
<div class="container p-5">
	<div class="card">
		<div class="card-header">
			<b>이벤트 등록</b>
		</div>
		<div class="card-body">
			<!-- 폼 액션 URL은 이벤트 등록 처리 경로로 설정 -->
			<form action="/staffEvent/write" method="post">
				<div class="mb-3">
					<div class="field--name">
					<label for="eventTitle">제목</label>
					</div>
					<input type="text" id="eventTitle" class="form-control"
						name="eventTitle" placeholder="이벤트 제목을 입력하세요" required>
				</div>
				<div class="mb-3">
					<div class="field--name">
					<label for="eventContent">내용</label>
					</div>
					<textarea id="eventContent" class="form-control" rows="5"
						name="eventContent" placeholder="이벤트 내용을 입력하세요" required></textarea>
				</div>
				<div class="date--field">
				<div class="mb-3">
					<div class="field--name">
					<label for="startDay">이벤트 시작일</label>
					</div>
					<input type="date" id="startDay" class="form-control"
						name="startDay" required>
				</div>
				</div>
					
				<div class="date--field">				
				<div class="mb-3">
					<div class="field--name">
					<label for="endDay">이벤트 종료일</label>
					</div>
					<input type="date" id="endDay" class="form-control"
						name="endDay" required>
				</div>
				</div>
				
				<button type="submit" class="btn btn-primary">이벤트 등록</button>
			</form>
			<a href="/staffEvent/list">돌아가기</a>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/navigation.js"></script>
<!-- CKEditor 초기화 스크립트 -->
<script>
    ClassicEditor
        .create( document.querySelector( '#eventContent' ) ) // CKEditor를 textarea에 적용
        .catch( error => {
            console.error( error );
        } );
    
</script>