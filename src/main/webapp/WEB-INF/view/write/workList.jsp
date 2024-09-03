<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/workList.css">

<main>
	<div class="btn--area">
		<form action="workInsert" method="get">
			<button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
		</form>
	</div>
	<div class="navbar">
		<a href="#myWorks">작품관리</a> <a href="#supportManagement">후원관리</a> <a href="#workStatistics">정산</a> <a href="#settlement">펀딩관리</a>
	</div>


	<!-- 이미지와 추가 콘텐츠들 -->
	<%-- 조건절 1: bookList가 null이 아닐 때 --%>
	<div class="content--container">
		<c:choose>
			<c:when test="${bookList != null}">
				<%-- bookList가 존재할 때 --%>

				<c:forEach var="list" items="${bookList}">
					<div class="mobile-show mobile-m-box novel-${list.bookId} s-inv">
						<table>
							<tr>
								<td style="width: 80px;">
									<div style="position: relative;" onclick="location.href='/write/workDetail?bookId=${list.bookId}&userId=${principal.userId }'">
										<!-- 작품 리스트 모바일 커버이미지 -->
										<img src="//images.novelpia.com/img/new/icon/count_book.png" class="cover_style_m"> ${principal.userId}
									</div>
								</td>
								<td class="info_st">
									<div style="position: relative;">
										<b style="font-size: 1.3em; letter-spacing: -1px;" class="cut_line_one" onclick="location.href='/write/workDetail?bookId=${list.bookId}'">${list.title}</b> <span
											class="info_font"> <%-- <b style="cursor:pointer; font-weight:500;" onclick="location.href='/user/${list.userId}'>${list.author}</b> --%>
										</span><br> <span style="font-size: 12px; font-weight: 600; color: #333;"> <img src="//images.novelpia.com/img/new/icon/count_good.png"> ${list.likes}
										</span><br> <span onclick="location.href='/write/workDetail?bookId=${list.bookId}'" style="font-size: 12px; font-weight: 600; color: #333;"> <%-- 태그 목록 출력 --%> <c:forEach
												var="tag" items="${list.tagNames}">
												<span class="hash_tag_off_m">#${tag}</span>
											</c:forEach>

										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table style="float: right; margin: 0px 0px 10px 0px;">
										<tr>
											<td><a href="/write/storyInsert?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_episode.png" style="width: 100%;"></a></td>
											<td><a href="/write/workUpdate?bookId=${list.bookId}"><img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" style="width: 100%;"></a></td>
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
