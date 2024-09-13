document.addEventListener('DOMContentLoaded', function () {
    initializeApp();
});

// 애플리케이션 초기화
function initializeApp() {
    console.log("App initialized");

    // 프로젝트 및 콘텐츠 데이터 로드
    const projectData = getProjectData();
    const contentData = getContentData();

    // 메뉴 링크 클릭 이벤트 바인딩
    bindMenuLinks();

    // 페이지 로드 시 기본 콘텐츠 로드
    loadContent('/staff/dashboard');

    // 이벤트 바인딩
    bindEventModalEvents(projectData);
    bindPayModalEvents();
}