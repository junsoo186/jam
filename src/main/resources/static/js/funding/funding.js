document.addEventListener('DOMContentLoaded', function () {
    const projectContainer = document.querySelector('.funding-box');
    const currentDate = new Date(); // 현재 날짜

    const urlParams = new URLSearchParams(window.location.search);
    const bookId = urlParams.get('bookId'); // bookId를 가져옴

    // 데이터를 서버에서 불러오는 함수 (단일 프로젝트만 불러옴)
    function fetchSingleProject() {
        fetch(`/funding/funding?bookId=${bookId}`) // 1개의 프로젝트만 불러옴
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    console.error('No project data found.');
                    return;
                }

                const project = data; // 첫 번째 프로젝트만 가져옴

                // projectId가 유효한지 확인
                if (!project.projectId) {
                    console.error('Invalid projectId for project:', project);
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
                            <span class="progress-percentage" id="progress-percentage-0"></span>
                            <span class="progress-funding" id="progress-funding-0"></span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar" id="progress-bar-0"></div>
                        </div>
                        <div class="progress-days" id="progress-days-0"></div>
                    </div>
                `;
                projectContainer.appendChild(projectCard);

                // 진행 상황 계산 함수 호출
                calculateProgress(0, project.totalAmount, project.goal, project.dateEnd, currentDate);

                // 프로젝트 카드 클릭 시 페이지 이동
                projectCard.addEventListener('click', function () {
                    if (project.projectId) {
                        window.location.href = `/funding/fundingDetail?projectId=${project.projectId}`; // projectId로 이동
                    } else {
                        console.error('Invalid projectId for navigation');
                    }
                });
            })
            .catch(err => {
                console.error('Error fetching project:', err);
            });
    }

    // 초기 데이터 로드 (단일 프로젝트만 출력)
    fetchSingleProject();
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
