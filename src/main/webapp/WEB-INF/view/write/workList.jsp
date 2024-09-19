<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>



<link rel="stylesheet" href="/css/workList.css">
<<<<<<< HEAD
<link rel="stylesheet" href="/css/toggleSwitch.css">    

<section>
	<div class="area--btn--top">
		<form action="workInsert" method="get">
			<button type="submit" id="btnInsert" class="btn--insert">신규 작품 등록</button>
		</form>
	</div>

	<div class="area--navbar--top">
		<a href="#myWorks">작품관리</a> <a href="#supportManagement">후원관리</a> <a href="#workStatistics">정산</a> <a href="#settlement">펀딩관리</a>
	</div>
	
	<div class="toggle-container">
	        <div class="toggle-button" id="supporterButton" onclick="toggleButton('supporter')">
	            <span>유저</span>
	        </div>
	        
	        <div class="toggle-button" id="makerButton" onclick="toggleButton('maker')">
	            <span>작가</span>
       	   </div>
    	</div>
	
</section>

=======
>>>>>>> 834ff0d546f865f12d767d930f5eaea093c34a41
<main>
    <section class="top--nav--area">
        <div class="navbar">
            <a href="#myWorks">작품관리</a>
            <a href="#supportManagement">후원관리</a>
            <a href="#workStatistics">정산</a>
            <a href="#settlement">펀딩관리</a>
        </div>
    </section>

<<<<<<< HEAD
						<div class="extra-content">
							<div class="center-section text--book--info">
								<span>${list.authorComment}</span> <br> <span class="text--likes--count"> <img src="//images.novelpia.com/img/new/icon/count_good.png" alt="좋아요 아이콘">
									${list.likes}
								</span> <br> <span class="text--book--tags"> <c:forEach var="tag" items="${list.tagNames}">
										<span class="tag--hash--off">#${tag}</span>
									</c:forEach>
								</span>
							</div>
							<div class="right-section area--btn--book--actions">
								<a href="/write/storyInsert?bookId=${list.bookId}"> <img src="//images.novelpia.com/img/new/mybook/btn_episode.png" class="btn--book--action--img" alt="에피소드 추가">
								</a> <a href="/write/workUpdate?bookId=${list.bookId}"> <img src="//images.novelpia.com/img/new/mybook/btn_novel_manage.png" class="btn--book--action--img" alt="작품 관리">
								</a>
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
	
=======
    <section class="top--banner--area">
        <c:forEach items="${banner}" var="bannerItem">
            <div class="banner--content">
                <img src="${bannerItem.imagePath}" alt="banner image" class="banner-img" style="display: none;" />
            </div>    
        </c:forEach>
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
                    <div class="main--content">
                        <c:forEach var="list" items="${bookList}">
                            <div class="nav--story">
                                <a href="/write/storyInsert?bookId=${list.bookId}">
                                    <div class="href--btn">
                                        <label class="story--write">회차쓰기</label>
                                    </div>
                                </a>
                                <a href="/write/workUpdate?bookId=${list.bookId}">
                                    <div class="href--btn" style="margin-left: 6px;">
                                        <label class="book--write">소설관리</label>
                                    </div>
                                </a>
                                <div class="book--title">${list.title}</div>
                            
                              <div>찜</div>
                              <div>별점</div>

                            </div>

                            <!-- 책 영역 시작 -->
                            <div class="book--area novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
                                <div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
                                    <img src="${pageContext.request.contextPath}${list.bookCoverImage}" class="img--cover">
                                    <div class="overlay">
                                        <div class="overlay-content">
                                            <p>저자: ${list.author}</p>
                                            <p>제목: ${list.title}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- 이야기 목록과 페이지네이션 영역 -->
                                <div id="story-list-${list.bookId}" 
                                     class="story-list-container"
                                     data-book-id="${list.bookId}" 
                                     data-current-page="${currentPageMap[list.bookId]}" 
                                     data-total-pages="${totalPagesMap[list.bookId]}">
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>작성한 책 내역이 존재하지 않습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
>>>>>>> 834ff0d546f865f12d767d930f5eaea093c34a41
</main>
    

<script type="text/javascript" src="/js/workList.js"></script>

<<<<<<< HEAD
<script type="text/javascript">
		

            var principalEmail = "<c:out value='${principal != null ? principal.email : ""}' />";
            
            function toggleButton(selected) {
                const supporterButton = document.getElementById('supporterButton');
                const makerButton = document.getElementById('makerButton');

                if (selected === 'supporter') {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                    
               		// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
                    window.location.href = '/user/myPage'; // 컨트롤러 경로로 리다이렉트
                                        
                    // 선택된 상태를 로컬 스토리지에 저장
                    localStorage.setItem('selectedButton', 'supporter');
                    
                } else {
                    makerButton.classList.add('active');
                    supporterButton.classList.remove('active');
                    
                 	// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
                    window.location.href = '/write/workList'; // 컨트롤러 경로로 리다이렉트
                    
                    // 선택된 상태를 로컬 스토리지에 저장
                    localStorage.setItem('selectedButton', 'maker');
                    
                    
                }
            }
            
          // 페이지 로드 시 로컬 스토리지에서 선택된 버튼 상태를 불러와 유지
            window.onload = function() {
                const selectedButton = localStorage.getItem('selectedButton');
                const supporterButton = document.getElementById('supporterButton');
                const makerButton = document.getElementById('makerButton');
                
                // 로그인된 사용자의 email이 있을 경우 "유저" 버튼을 활성화
                if (!selectedButton && principalEmail !== "") {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                    sessionStorage.setItem('selectedButton', 'supporter'); // 기본값으로 저장
                } else if (selectedButton === 'supporter') {
                    supporterButton.classList.add('active');
                    makerButton.classList.remove('active');
                } else if (selectedButton === 'maker') {
                    makerButton.classList.add('active');
                    supporterButton.classList.remove('active');
                }
            }    
            
</script>


=======

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
>>>>>>> 834ff0d546f865f12d767d930f5eaea093c34a41
