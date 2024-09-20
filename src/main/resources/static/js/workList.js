
/*페이징 처리 스크립트 */



document.addEventListener("DOMContentLoaded", function () {
    loadAllPages(); // 모든 책의 페이지 초기 로드

    function loadAllPages() {
        // 각 책의 이야기 목록 컨테이너에 대해 AJAX 로드
        document.querySelectorAll(".story-list-container").forEach(function (container) {
            const bookId = container.getAttribute("data-book-id");
            const currentPage = container.getAttribute("data-current-page");
            loadPage(bookId, currentPage); // 각 책의 초기 페이지 로드
        });
    }

    function initializePageLinks() {
        // 새로 로드된 콘텐츠에 대해 페이지 링크 이벤트 리스너 설정
        document.querySelectorAll(".page-link").forEach(function (link) {
            link.addEventListener("click", function (event) {
                event.preventDefault();

                const bookId = this.getAttribute("data-book-id");
                const currentPage = parseInt(this.getAttribute("data-current-page"));
                const totalPages = parseInt(this.getAttribute("data-total-pages"));
                const isPrev = this.classList.contains("prev");

                if (isPrev && currentPage > 1) {
                    loadPage(bookId, currentPage - 1);
                } else if (!isPrev && currentPage < totalPages) {
                    loadPage(bookId, currentPage + 1);
                }
            });
        });
    }

    function loadPage(bookId, page) {
        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

        fetch(`${contextPath}/workList?bookId=${bookId}&page=${page}&size=4`, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => response.text())
        .then(html => {
            // 해당 책의 이야기 목록 업데이트
            const storyListContainer = document.querySelector(`#story-list-${bookId}`);
            if (storyListContainer) {
                storyListContainer.innerHTML = html;
            }

            // 새로 로드된 콘텐츠에 대해 이벤트 리스너 다시 등록
            initializePageLinks();
        })
        .catch(error => console.error('Error loading page:', error));
    }
});


/*페이징 처리 스크립트 */



document.addEventListener("DOMContentLoaded", function () {
    const banners = document.querySelectorAll('.banner-img'); // 모든 배너 이미지 요소 가져오기
    let currentBannerIndex = 0;
    const slideInterval = 3000; // 3초 간격으로 슬라이드

    // 첫 번째 배너만 처음에 표시
    if (banners.length > 0) {
        banners[currentBannerIndex].style.display = 'block';
    }

    function showNextBanner() {
        // 현재 배너 숨기기
        banners[currentBannerIndex].style.display = 'none';

        // 다음 배너로 이동, 마지막 배너 이후에는 첫 번째 배너로 돌아가게 설정
        currentBannerIndex = (currentBannerIndex + 1) % banners.length;

        // 다음 배너 표시
        banners[currentBannerIndex].style.display = 'block';
    }

    // 3초마다 배너 자동 전환
    setInterval(showNextBanner, slideInterval);
});