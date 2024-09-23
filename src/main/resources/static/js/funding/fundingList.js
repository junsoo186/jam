document.addEventListener('DOMContentLoaded', function () {
    let currentPage = 1;
    const pageSize = 16;  // 한번에 불러올 프로젝트 개수
    const projectContainer = document.querySelector('.project-container');
    const loadingIndicator = document.querySelector('.loading-indicator');

    const currentDate = new Date(); // 현재 날짜
    let isLoading = false;
    let hasMoreData = true;

    // 데이터를 서버에서 불러오는 함수
    function fetchProjects(page) {
        if (isLoading || !hasMoreData) return;
        isLoading = true;

        fetch(`/funding/fundingList?page=${page}&size=${pageSize}`)
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    hasMoreData = false;
                    loadingIndicator.style.display = 'none';
                    return;
                }

                // staffAgree가 'N'인 프로젝트 필터링
                const filteredProjects = data.filter(project => project.staffAgree !== 'N');

                filteredProjects.forEach((project, index) => {
                    // projectId가 유효한지 확인
                    if (!project.projectId) {
                        console.error('Invalid projectId for project:', project);
                        return;
                    }

                    // 중복 방지를 위한 조건: 이미 추가된 프로젝트인지 확인
                    const existingProject = document.querySelector(`.project-card[data-project-id="${project.projectId}"]`);
                    if (existingProject) {
                        return;
                    }

                    const projectCard = document.createElement('div');
                    projectCard.classList.add('project-card');
                    projectCard.setAttribute('data-project-id', project.projectId);
                    projectCard.setAttribute('data-goal', project.goal);
                    projectCard.setAttribute('data-current', project.totalAmount);
                    projectCard.setAttribute('data-end-date', project.dateEnd);

                    projectCard.innerHTML = `
                        <div class="project-image">
                            <img alt="프로젝트 이미지" src="${project.mainImg}" class="project-img">
                        </div>
                        <div class="project-info">
                            <div class="project-title">${project.title}</div>
                            <div class="project-author">${project.author}</div>
                            <div class="project-comment">${project.onelineComment}</div>
                            <div class="progress-info">
                                <span class="progress-percentage" id="progress-percentage-${index}"></span>
                                <span class="progress-funding" id="progress-funding-${index}"></span>
                            </div>
                            <div class="progress-bar-container">
                                <div class="progress-bar" id="progress-bar-${index}"></div>
                            </div>
                            <div class="progress-days" id="progress-days-${index}"></div>
                        </div>
                    `;
                    projectContainer.appendChild(projectCard);

                    // 진행 상황 계산 함수 호출
                    calculateProgress(index, project.totalAmount, project.goal, project.dateEnd, currentDate);

                    // 프로젝트 카드 클릭 시 페이지 이동
                    projectCard.addEventListener('click', function () {
                        if (project.projectId) {
                            window.location.href = `/funding/fundingDetail?projectId=${project.projectId}`; // projectId로 이동
                        } else {
                            console.error('Invalid projectId for navigation');
                        }
                    });
                });

                currentPage++;
                isLoading = false;
            })
            .catch(err => {
                console.error('Error fetching projects:', err);
                isLoading = false;
            });
    }

    // IntersectionObserver 설정
    const observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting && !isLoading && hasMoreData) {
            fetchProjects(currentPage);
        }
    });

    // 무한 스크롤을 감지할 요소
    observer.observe(loadingIndicator);

    // 초기 데이터 로드
    fetchProjects(currentPage);
});


// 프로젝트 진행 상황을 계산하는 함수
function calculateProgress(index, currentAmount, goalAmount, endDate, currentDate) {
    // 목표 날짜 계산
    const targetDate = new Date(endDate);
    const timeDiff = targetDate - currentDate;

    // 남은 일수와 시간 계산
    let daysLeft = Math.floor(timeDiff / (1000 * 60 * 60 * 24)); // 남은 일수
    let hoursLeft = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); // 남은 시간

    // 진행률 계산 (퍼센트)
    let percentage = Math.floor((currentAmount / goalAmount) * 100);

    // 진행률이 100%를 넘으면 100%로 고정
    if (percentage > 100) {
        percentage = 100;
    }

    // 각 요소 가져오기
    const percentageElement = document.getElementById(`progress-percentage-${index}`);
    const fundingElement = document.getElementById(`progress-funding-${index}`);
    const daysElement = document.getElementById(`progress-days-${index}`);
    const progressBar = document.getElementById(`progress-bar-${index}`);

    // 종료된 상태 처리 (마감 또는 남은 시간)
    if (daysLeft < 0) {
        daysLeft = "마감";
    } else if (daysLeft === 0 && hoursLeft > 0) {
        daysLeft = `${hoursLeft}시간 남음`;
    } else if (daysLeft === 0 && hoursLeft <= 0) {
        daysLeft = "마감";
    } else {
        daysLeft = `${daysLeft}일 남음`;
    }

    // 각 요소에 텍스트 설정
    if (percentageElement) {
        percentageElement.innerText = `${percentage}%`;
    }

    if (fundingElement) {
        fundingElement.innerText = `${currentAmount.toLocaleString()}원`;
    }

    if (daysElement) {
        daysElement.innerText = daysLeft;
    }

    if (progressBar) {
        progressBar.style.width = `${percentage}%`;
    }
}
