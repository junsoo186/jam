<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/workList.css">
<main>
	
	
	<section class="top--nav--area">
		<div class="navbar">
			<a href="#myWorks">작품관리</a>
			<a href="#supportManagement">후원관리</a>
			<a href="#workStatistics">정산</a> 
			<a href="#settlement">펀딩관리</a>
		</div>
		
	</section>
	<div class="top--btn--area">
		<form action="workInsert" method="get" >
			<button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
		</form>
	</div>
	


	<section class="center--content--container">
		<div class="btn--area">
			<div class="right-section area--btn--book--actions">
		
				
		
			</div>
		</div>


		<div class="book--area">
			<c:choose>
				<c:when test="${bookList != null}">
					<!-- bookList가 존재할 때 -->
					<c:forEach var="list" items="${bookList}">
						<div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
							<div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
								<img src="${list.bookCoverImage}" class="img--cover--style" alt="${list.title} 커버 이미지">
								<div class="book-info">
									<b class="text--book--title cut_line_one">${list.title}</b>
									<p class="text--author">저자 : ${principal.nickName}</p>
								</div>
							
								<a href="/write/storyInsert?bookId=${list.bookId}"> <img src="//images.novelpia.com/img/new/mybook/btn_episode.png" class="btn--book--action--img" alt="에피소드 추가">
								</a> 
								<a href="/write/workUpdate?bookId=${list.bookId}"> <img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" class="btn--book--action--img" alt="작품 관리">
								</a>
							</div>

							<div class="extra-content">
								<div class="center-section text--book--info">
									<span>${list.authorComment}</span> <br> <span class="text--likes--count"> <img src="//images.novelpia.com/img/new/icon/count_good.png" alt="좋아요 아이콘">
										${list.likes}
									</span> <br> <span class="text--book--tags"> <c:forEach var="tag" items="${list.tagNames}">
											<span class="tag--hash--off">#${tag}</span>
										</c:forEach>
									</span>
								</div>
							</div>
						</div>
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
