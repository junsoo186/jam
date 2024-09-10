<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/workList.css">
<main>


	<section class="top--nav--area">
		<div class="navbar">
			<a href="#myWorks">작품관리</a> <a href="#supportManagement">후원관리</a> <a href="#workStatistics">정산</a> <a href="#settlement">펀딩관리</a>
		</div>

	</section>
	<div class="top--btn--area">
		<form action="workInsert" method="get">
			<button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
		</form>
	</div>



	<section class="center--content--container">
		

		<div class="book--area">
			<c:choose>
				<c:when test="${bookList != null}">
					<c:forEach var="list" items="${bookList}">
						<div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
								<div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
								<img src="${list.bookCoverImage}" class="img--cover">

							</div>





							<!-- 여기는 상세   -->





						
						
								<!-- 여기가 스토리 파트  -->

							
									<c:forEach var="story" items="${storyMap[list.bookId]}">
										<div class="story--part">
										<a href src="/write/storyContents/${story.storyId}"><img class="img--story" src="/images/book/book.png"></a>
										<div class="text-overlay">${story.title}</div>
										</div>
									</c:forEach>
									<a href="/write/storyInsert?bookId=${list.bookId}"> 
										<img src="//images.novelpia.com/img/new/mybook/btn_episode.png" class="btn--book--action--img">
									</a> 
									<a href="/write/workUpdate?bookId=${list.bookId}"> 
										<img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" class="btn--book--action--img">
									</a>
	
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>작성한 책 내역이 존재하지 않습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
	</section>
</main>

<script type="text/javascript" src="/js/workList.js"></script>
