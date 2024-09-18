/**
 * bookId와 선택적인 userId에 따라 상세 페이지로 이동합니다.
 * @param {number} bookId - 이동할 책의 ID.
 * @param {number} [userId] - 선택적으로 전달될 사용자 ID.
 */
function navigateToDetail(bookId, userId) {
    const userParam = userId ? `&userId=${userId}` : '';
    location.href = `/write/workDetail?bookId=${bookId}${userParam}`;
}

let isHovering = false;

/**
 * area--item--container에 마우스가 진입하면 extra-content를 표시합니다.
 * @param {HTMLElement} element - 이벤트가 발생한 요소.
 */
function showDetails(element) {
	const extraContent = element.querySelector('.extra-content');
	if (extraContent) {
		extraContent.style.display = 'flex';
		extraContent.style.opacity = '1';
	}
}

/**
 * area--item--container에서 마우스가 벗어나면 extra-content를 숨깁니다.
 * @param {HTMLElement} element - 이벤트가 발생한 요소.
 */
function hideDetails(element) {
	const extraContent = element.querySelector('.extra-content');
	if (extraContent) {
		extraContent.style.display = 'none';
		extraContent.style.opacity = '0';
	}
}


/**
 * 추가 콘텐츠 영역에 마우스가 진입했을 때 숨김을 방지합니다.
 */
function keepExtraContentVisible() {
	isHovering = true;
}

/**
 * 추가 콘텐츠 영역에서 마우스가 벗어났을 때 숨김이 가능하게 설정합니다.
 */
function allowHidingExtraContent() {
	isHovering = false;
	const extraContent = document.querySelector('.extra-content');
	if (extraContent) {
		extraContent.style.display = 'none';
		extraContent.style.opacity = '0';
	}
}








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