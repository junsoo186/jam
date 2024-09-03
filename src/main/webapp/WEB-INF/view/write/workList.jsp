<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/workList.css">

<main>
	<div class="area--btn--top">
		<form action="workInsert" method="get">
			<button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
		</form>
	</div>
	<div class="area--navbar--top">
		<a href="#myWorks">작품관리</a>
		<a href="#supportManagement">후원관리</a>
		<a href="#workStatistics">정산</a>
		<a href="#settlement">펀딩관리</a>
	</div>

	<!-- 이미지와 추가 콘텐츠들 -->
	<div class="area--content--container">
		<c:choose>
			<c:when test="${bookList != null}">
				<%-- bookList가 존재할 때 --%>
				<c:forEach var="list" items="${bookList}">
					<div class="area--item--container novel-${list.bookId} s-inv">
						<table>
							<tr>
								<td style="width: 80px;">
									<div style="position: relative;" onclick="location.href='/write/workDetail?bookId=${list.bookId}&userId=${principal.userId }'">
										<!-- 작품 리스트 모바일 커버이미지 -->
										<img src="${list.bookCoverImage}" class="img--cover--style" alt="이미지 없음">
										${principal.nickName}
									</div>
								</td>
								<td class="text--book--info">
									<div style="position: relative;">
										<b class="text--book--title cut_line_one" onclick="location.href='/write/workDetail?bookId=${list.bookId}'">${list.title}</b>
										<br>
										<span class="text--likes--count">
											<img src="//images.novelpia.com/img/new/icon/count_good.png">
											${list.likes}
										</span>
										<br>
										<span onclick="location.href='/write/workDetail?bookId=${list.bookId}'" class="text--book--tags">
											<c:forEach var="tag" items="${list.tagNames}">
												<span class="tag--hash--off">#${tag}</span>
											</c:forEach>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table class="area--btn--bottom">
										<tr>
											<td><a href="/write/storyInsert?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_episode.png" class="btn--book--action--img"></a></td>
											<td><a href="/write/workUpdate?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" class="btn--book--action--img"></a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
        		book값 없음
        	</c:otherwise>
		</c:choose>
	</div>
</main>
