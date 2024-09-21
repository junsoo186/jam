<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/workDetail.css">
<link rel="stylesheet" href="/css/banner.css">
<link rel="stylesheet" href="/css/layout/page.css">
<main>
	<div class="top--container">	
			<section class="book--cover--section">
				<div class="book--cover">
					<img src="${bookDetail.bookCoverImage}" >
				</div>
			</section>
			<section class="top--details">
				<div class="book-detail">
					<!-- 수정중 -->
					<div class="title-heart">
						<div style="font-size: 30px; font-weight: bolder;">${bookDetail.title}</div>
						<div class="heart-container" onclick="toggleHeart(${bookDetail.bookId})">
							<svg class="heart" viewBox="0 0 24 24">
								<path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
							</svg>
						</div>
					</div>
					<!-- 수정중 -->
					<div>	 
						<div class="book-author"> 
							<div style="font-weight: bolder;">작가명 <a href="" style="color:#f06292;"> ${bookDetail.author}</a></div> 
							<div class="age-box">
							<c:choose>
								<c:when test="${bookDetail.age != 19}">
									<div class="age-box" style="background-color: skyblue;">15</div>
								</c:when>
								<c:otherwise>
									<div class="age-box" style="background-color: red;">19</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="book-score">
						<div><strong>조회</strong>${bookDetail.views}</div>
						<div style="margin-left: 10px;"><strong>찜</strong>${bookDetail.views}</div>
						<div style="margin-left: 10px;"><strong>별점</strong>${bookDetail.bookTotalScore}</div>
					</div>	
				</div>
				<ul class="tags"> 
					<c:forEach var="tag" items="${bookDetail.tagNames}">
						<li class="tag-box"><a href="#">#${tag}</a></li>
					</c:forEach>
				</ul>

				<div class="book-text">
					${bookDetail.authorComment}
				</div>
			</section>	
			
	</div>
	<section class="top--banner--area">
		<c:forEach items="${banner}" var="bannerItem" varStatus="status">
			<div class="banner--content" style="display: ${status.index == 0 ? 'block' : 'none'};">
				<img src="${bannerItem.imagePath}" alt="배너 이미지" class="banner-img" />
			</div>
		</c:forEach>
	</section>
	<section class="main--content">
		<div class="story--list">
			<div class="story--header">
				<div class="story-nav">
					<div style="font-size: 25px; font-weight: bold; color: #333333;">회차 리스트</div>
					<div style="display: flex;">
						<div>첫화부터</div>
						<div class="buy--all">전체소장</div>
					</div>
				</div>
				</div>
				<div class="story--part">
					<c:forEach var="story" items="${storyList}">
						<a href="/write/storyContents?storyId=${story.storyId}">
						<div class="story-with-button">
							<c:choose>
								<c:when test="${story.cost == 0}">
									<p class="free">무료</p>
								</c:when>
								<c:otherwise>
									<p class="pay">${story.cost}JAM</p>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${story.number == 0}">
									<div class="story">
									<p class="story--part">프롤로그</p>
									<div class="story-actions">
										<c:if test="${principalId == story.userId}">
											<form action="storyUpdate" method="get">
												<input type="hidden" name="storyId" value="${story.storyId}">
												<button type="submit" class="btn">수정</button>
											</form>
										</div>
										</c:if>
									</div>
								</c:when>
								<c:otherwise>
								<div class="story">
									<div style="display: flex; justify-content: space-between;">
									<p class="story--part">${story.number}화 ${story.title}</p>
									<p class="story--part" style="color:#c9c7c7;">${story.createdAt} </p>
									</div>
									<div class="story-actions">
										<c:if test="${principalId == story.userId}">
											<form action="storyUpdate" method="get">
												<input type="hidden" name="storyId" value="${story.storyId}">
												<button type="submit" class="re-btn">수정</button>
											</form>
										</c:if>
									</div>
								</div>
								</c:otherwise>
							</c:choose>
							
						</div>
						</a>
					</c:forEach>
					<!-- 페이징 -->
					<div class="flex--page">
						<div class="pagination">
							<!-- 이전 페이지 버튼 -->
							<c:if test="${currentPage > 1}">
								<a href="?bookId=${bookDetail.bookId}&page=${currentPage - 1}&size=${size}">&laquo; 이전</a>
							</c:if>
					
							<!-- 페이지 번호 링크 -->
							<c:forEach var="i" begin="1" end="${totalPages}">
								<a href="?bookId=${bookDetail.bookId}&page=${i}&size=${size}" class="${i == currentPage ? 'active' : ''}">${i}</a>
							</c:forEach>
					
							<!-- 다음 페이지 버튼 -->
							<c:if test="${currentPage < totalPages}">
								<a href="?bookId=${bookDetail.bookId}&page=${currentPage + 1}&size=${size}">다음 &raquo;</a>
							</c:if>
						</div>
					</div>
						<!-- 페이징 -->
				</div>
			</div>
			<!-- 스토리 구간 -->
		</div>
		<!-- 책 리스트 끝 -->



		<div class="funding--content">
			<div style="font-size: 25px; font-weight: bold; color: #333333;">펀딩</div>
			<div class="funding-box">
			</div>
			<div style="font-size: 25px; font-weight: bold; color: #333333;">후원</div>
			<div class="funding-box"></div>
		</div>
	</section>
	<section class="comments--content">
		<div>
		<div style="font-size: 25px; font-weight: bold; color: #333333;">
			댓글 전체 
		</div>
		
		</div>
		<div class="comments--option">
			<ul style="display: flex; flex-direction: row;">
				<li class="option"><a href="#" onclick="loadComments('newest', event)">▼최신순</a></li> 
				<li class="option"><a href="#" onclick="loadComments('oldest', event)">▼등록순</a></li> 
				<li class="option"><a href="#" onclick="loadComments('likes', event)">▼	추천수</a></li> 
			</ul>
		</div>
		<form id="commentForm" method="POST">
			<input type="hidden" name="bookId" value="${bookId}">
			<input type="hidden" name="userId" value="${principalId}">
			
			<div class="write--box">        
				<textarea id="comment" name="comment" rows="4" cols="50"  placeholder="댓글을 입력하세요"></textarea>
				<button type="submit">댓글입력</button>
			</div>
		</form>
		
		<div id="commentSection">
			<!-- 댓글 목록이 여기에 동적으로 표시됩니다 -->
		</div>
		
	</section>
	

	
</main>


<!-- JavaScript 파일은 body 끝부분에 포함 -->
<script type="text/javascript" src="/js/sort.js"></script>
<script type="text/javascript" src="/js/likes.js"></script>
<script type="text/javascript" src="/js/banner.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/comment.js"></script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>