<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="/css/workList.css">
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

<main>
	<div class="area--content--container">
		<c:choose>
			<c:when test="${bookList != null}">
				<!-- bookList가 존재할 때 -->
				<c:forEach var="list" items="${bookList}">
					<div class="area--item--container novel-${list.bookId} s-inv" onmouseenter="showDetails(this)" onmouseleave="hideDetails(this)">
						<div class="left-section" onclick="navigateToDetail(${list.bookId}, ${principal.userId})">
							<img src="${list.bookCoverImage}" class="img--cover--style" alt="${list.title} 커버 이미지">
							<div class="book-info">
								<b class="text--book--title cut_line_one">${list.title}</b>
								<p class="text--author">저자 : ${principal.nickName}</p>
							</div>
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
	
</main>

<script type="text/javascript" src="/js/workList.js"></script>

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


