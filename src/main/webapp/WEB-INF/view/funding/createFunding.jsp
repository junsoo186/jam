<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<html lang="ko">

			<head>
				<meta charset="UTF-8">
				<title>펀딩 프로젝트 생성</title>
				<link rel="stylesheet" href="/css/funding/create.css">
			</head>

			<body>
				<main>
					<div class="container">
						<form id="fundingFormElement" action="/funding/create" method="post"
							enctype="multipart/form-data">
							<h1>새로운 펀딩 프로젝트 생성</h1>

							<!-- 프로젝트 제목 입력 -->
							<div class="form-group">
								<label for="title">프로젝트 제목:</label>
								<c:choose>
									<c:when test="${book.title ne null}">
										<input type="text" id="title" name="title" placeholder="${book.title}" required>
									</c:when>
									<c:otherwise>
										<input type="text" id="title" name="title" placeholder="프로젝트 제목을 입력하세요"
											required>
									</c:otherwise>
								</c:choose>
							</div>

							<!-- 프로젝트 설명 입력 -->
							<div class="form-group">
								<label for="contents">프로젝트 설명:</label>
								<textarea id="contents" name="contents" rows="5" placeholder="프로젝트 설명을 입력하세요"
									required></textarea>
							</div>

							<!-- 목표 금액 입력 -->
							<div class="form-group">
								<label for="goal">목표 금액 (원):</label>
								<input type="number" id="goal" name="goalAmount" min="1" step="1000"
									placeholder="목표 금액을 입력하세요" required>
							</div>

							<!-- 종료 날짜 선택 -->
							<div class="form-group">
								<label for="dateEnd">종료 날짜:</label>
								<input type="date" id="dateEnd" name="endDate" required>
							</div>

							<!-- 프로젝트 이미지 업로드 (여러 이미지 업로드 가능) -->
							<div class="form-group">
								<label for="projectImgs">프로젝트 이미지:</label>
								<!-- 실제 파일 선택 input을 숨김 -->
								<input type="file" id="projectImgs" name="projectImgs" accept="image/*" multiple
									style="display: none;">
								<!-- 파일 선택을 위한 커스텀 버튼 -->
								<button type="button" id="customUploadBtn">이미지 선택</button>
							</div>

							<!-- 이미지 미리보기 영역 -->
							<div id="imagePreview" class="form-group">
								<h3>미리보기</h3>
								<div id="previewContainer"></div>
								<!-- 이미지들이 미리보기로 들어가는 영역 -->
							</div>

							<!-- 한 줄 소개 -->
							<div class="form-group">
								<label for="onelineComment">한 줄 소개:</label>
								<input type="text" id="onelineComment" name="onelineComment" placeholder="한 줄 소개를 입력하세요"
									required>
							</div>

							<!-- 작성자 이름 -->
							<div class="form-group">
								<label for="author">작성자 이름:</label> <input type="text" id="author" name="author"
									placeholder="작성자 이름을 입력하세요" required>
							</div>

							<!-- 폼 제출 버튼 -->
							<div class="form-group">
								<button type="submit">프로젝트 생성</button>
							</div>
						</form>

						<!-- 리워드를 추가할 컨테이너 -->
						<div id="reward-container">
							<!-- 리워드 추가 버튼 -->
							<div class="form-group">
								<h2>펀딩 리워드</h2>
								<button type="button" id="addRewardBtn">리워드 추가</button>
							</div>
							<!-- 초기 리워드 그룹 -->
							<div class="reward-group">
								<div class="form-group">
									<label for="rewardContent-0">리워드 이름:</label> <input type="text" id="rewardContent-0"
										name="rewards[0].content" placeholder="리워드 내용을 입력하세요" required>
								</div>
								<div class="form-group">
									<label for="rewardPoint-0">리워드 금액 (원):</label><input type="number"
										id="rewardPoint-0" name="rewards[0].point" min="1" step="1000"
										placeholder="리워드 금액을 입력하세요" required>
								</div>
							</div>
						</div>
					</div>
				</main>
				<script type="text/javascript" src="/js/funding/create.js"></script>

			</body>

			</html>