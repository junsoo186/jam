document.addEventListener('DOMContentLoaded', function () {
    let currentPage = 0;
    const pageSize = 16;  // 한번에 불러올 프로젝트 개수
    const projectContainer = document.querySelector('.project-container');
    const loadingIndicator = document.querySelector('.loading-indicator'); // 이미 HTML에 있는 요소 사용

    const currentDate = new Date(); // 현재 날짜를 한 번만 가져옴
    let isLoading = false; // 로딩 중인지 확인하는 변수
    let hasMoreData = true; // 더 불러올 데이터가 있는지 확인

    // 데이터를 서버에서 불러오는 함수
    function fetchProjects(page) {
        if (isLoading || !hasMoreData) return; // 이미 로딩 중이거나 데이터가 더 이상 없으면 중단
        isLoading = true; // 로딩 상태로 설정

        fetch(`/funding/fundingList?page=${page}&size=${pageSize}`)
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    hasMoreData = false; // 더 이상 데이터가 없음을 설정
                    loadingIndicator.style.display = 'none'; // 로딩 인디케이터 숨기기
                    return;
                }

                data.forEach((project, index) => {
                    const projectCard = document.createElement('div');
                    projectCard.classList.add('project-card');
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

                    // form 영역 클릭 시 해당 경로로 이동
                    projectCard.addEventListener('click', function () {
                        const form = projectCard.closest('form');
                        if (form) {
                            form.submit();  // form을 submit하여 해당 경로로 이동
                        }
                    });
                });

                currentPage++;
                isLoading = false; // 로딩 완료
            })
            .catch(err => {
                console.error('Error fetching projects:', err);
                isLoading = false; // 오류 발생 시에도 로딩 완료로 설정
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
