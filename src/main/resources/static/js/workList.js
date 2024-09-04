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
