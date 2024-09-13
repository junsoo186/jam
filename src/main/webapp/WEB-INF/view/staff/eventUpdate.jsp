<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/eventDetail.css">
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
<div class="container p-5">
	<div class="card">
		<div class="card-header">
			<b>이벤트 수정</b>
		</div>
		<div class="card-body">
			<h3>이벤트 수정하기</h3>
			<!-- 폼 액션 URL은 이벤트 수정 처리 경로로 설정 -->
			<form action="/staffEvent/update/${event.eventId}" method="post">
			 <input type="hidden" name="eventId" value="${event.eventId}">
				<div class="mb-3">
					<label for="eventTitle">이벤트 제목</label> <input type="text"
						id="eventTitle" class="form-control" name="eventTitle"
						value="${event.eventTitle}" required>
				</div>
				<div class="mb-3">
					<label for="eventContent">이벤트 내용</label>
					<textarea id="eventContent" class="form-control" rows="5"
						name="eventContent" required>${event.eventContent}</textarea>
				</div>
				<div class="mb-3">
					<label for="startDay">이벤트 시작일</label> <input type="date"
						id="startDay" class="form-control" name="startDay"
						value="${event.startDay}" required>
				</div>
				<div class="mb-3">
					<label for="endDay">이벤트 종료일</label> <input type="date" id="endDay"
						class="form-control" name="endDay" value="${event.endDay}"
						required>
				</div>
				
				<button type="submit" class="btn btn-primary">이벤트 수정</button>
			</form>
			<a href="/staffEvent/list">돌아가기</a>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/navigation.js"></script>
<!-- CKEditor 초기화 스크립트 -->
<script>
    ClassicEditor
        .create( document.querySelector( 'eventContent' ) ) // CKEditor를 textarea에 적용
        .catch( error => {
            console.error( error );
        } );
</script>
