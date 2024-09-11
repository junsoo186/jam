document.addEventListener("DOMContentLoaded", function () {
    const projects = document.querySelectorAll('.project-card');

    const currentDate = new Date(); // 현재 날짜를 한 번만 가져옴

    projects.forEach((project, index) => {
        const goalAmount = project.getAttribute('data-goal');
        const currentAmount = project.getAttribute('data-current');
        const endDate = project.getAttribute('data-end-date');

        const parsedGoal = parseInt(goalAmount, 10);
        const parsedCurrent = parseInt(currentAmount, 10);

        calculateProgress(index, parsedCurrent, parsedGoal, endDate, currentDate);

        // form 영역 클릭 시 해당 경로로 이동
        project.addEventListener('click', function () {
            const form = project.closest('form');
            if (form) {
                form.submit();  // form을 submit하여 해당 경로로 이동
            }
        });
    });
});

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
