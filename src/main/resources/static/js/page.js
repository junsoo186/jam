/**
 * 
 */
function animateMergeEffect(event) {
    event.preventDefault(); // 기본 링크 동작 방지

    const pageItems = document.querySelectorAll('.page-item');
    const currentItem = document.querySelector('.page-item.active'); // 현재 활성화된 페이지 아이템
    const clickedItem = event.currentTarget.parentElement; // 클릭된 페이지 아이템

    // 현재 활성화된 페이지 아이템과 클릭된 아이템에 애니메이션 클래스 추가
    if (currentItem) {
        currentItem.classList.add('merge-animation');
    }
    clickedItem.classList.add('merge-animation');

    // 애니메이션이 끝난 후 상태 초기화 및 페이지 이동
    setTimeout(() => {
        // 이전 활성화된 페이지 아이템의 애니메이션 클래스 제거
        if (currentItem) {
            currentItem.classList.remove('merge-animation', 'active');
        }
        // 클릭된 페이지 아이템을 활성화 상태로 변경
        clickedItem.classList.add('active');
        clickedItem.classList.remove('merge-animation');

        // 페이지 이동
        window.location.href = event.currentTarget.href;
    }, 800); // 애니메이션 시간과 일치하도록 설정 (0.8초)
}