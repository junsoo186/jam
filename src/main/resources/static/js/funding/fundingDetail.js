document.addEventListener('DOMContentLoaded', function () {
    // 목표 금액과 모인 금액 가져오기
    const goalAmount = document.getElementById('goalAmount').getAttribute('data-goal');
    const totalAmount = document.getElementById('totalAmount').getAttribute('data-total');
    
    const endDateStr = "${project.dateEnd}"; // 서버에서 전달된 종료 날짜
    const endDate = new Date(endDateStr); // 날짜 객체로 변환

    // 정수로 변환
    const goal = parseInt(goalAmount, 10);
    const total = parseInt(totalAmount, 10);

    // 달성률 계산
    let percentage = 0;
    if (goal > 0) {
        percentage = Math.floor((total / goal) * 100);
    }

    // 달성률이 100%를 초과하지 않도록 설정
    if (percentage > 100) {
        percentage = 100;
    }

    // 페이지에 달성률 표시
    const percentageElement = document.getElementById('percentage');
    percentageElement.innerText = `${percentage}% 달성`;

    // 달성률을 콘솔에 출력 (디버깅용)
    console.log(`펀딩 달성률: ${percentage}%`);

    // 남은 시간을 계산하는 함수
    function calculateRemainingTime() {
        const now = new Date();
        const remainingTime = endDate - now; // 남은 시간을 밀리초 단위로 계산

        if (remainingTime > 0) {
            const days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
            const hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);

            document.getElementById('remainingTime').textContent =
                `${days}일 ${hours}시간 ${minutes}분 ${seconds}초`;
        } else {
            document.getElementById('remainingTime').textContent = "종료됨";
        }
    }

    // 초기 실행
    calculateRemainingTime();

    // 1초마다 남은 시간을 업데이트
    setInterval(calculateRemainingTime, 1000);

    // 슬라이더 기능
    let slideIndex = 0;
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.prev');
    const nextBtn = document.querySelector('.next');

    function showSlide(index) {
        slides.forEach((slide, idx) => {
            slide.classList.remove('active');
            if (idx === index) {
                slide.classList.add('active');
            }
        });

        dots.forEach((dot, idx) => {
            dot.classList.remove('active');
            if (idx === index) {
                dot.classList.add('active');
            }
        });
    }

    function nextSlide() {
        slideIndex = (slideIndex + 1) % slides.length;
        showSlide(slideIndex);
    }

    function prevSlide() {
        slideIndex = (slideIndex - 1 + slides.length) % slides.length;
        showSlide(slideIndex);
    }

    // Dot을 클릭했을 때 해당 슬라이드로 이동
    dots.forEach((dot, idx) => {
        dot.addEventListener('click', () => {
            slideIndex = idx;
            showSlide(slideIndex);
        });
    });

    nextBtn.addEventListener('click', nextSlide);
    prevBtn.addEventListener('click', prevSlide);

    // 3초마다 자동 슬라이드 전환
    setInterval(nextSlide, 3000);
});
