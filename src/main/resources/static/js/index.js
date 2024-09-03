// /js/index.js

document.addEventListener('DOMContentLoaded', function() {
    const pageNumbers = document.querySelectorAll('.page--num');
    const banners = document.querySelectorAll('.visual--image');
    const textBoxes = document.querySelectorAll('.banner--text--box');
    const bannerContainer = document.getElementById('top--banner');

    // 각 배너에 대해 배경색을 정의합니다.
    const bannerBackgrounds = [
        'radial-gradient(#1F325C, #3A5CA8)',  // 배너 1의 배경색
        'radial-gradient(#283048, #859398)',  // 배너 2의 배경색
        'radial-gradient(#134E5E, #71B280)'   // 배너 3의 배경색
    ];

    pageNumbers.forEach(pageNum => {
        pageNum.addEventListener('click', function() {
            const pageIndex = this.getAttribute('data--page') - 1; // 인덱스는 0부터 시작

            // 모든 배너와 텍스트박스를 숨기고, 활성 페이지 업데이트
            banners.forEach(banner => {
                if (banner) banner.style.display = 'none';
            });
            textBoxes.forEach(textBox => {
                if (textBox) textBox.style.display = 'none';
            });
            pageNumbers.forEach(num => num.classList.remove('active'));

            // 클릭된 페이지에 해당하는 배너와 텍스트박스를 표시
            const selectedBanner = document.getElementById('banner--' + (pageIndex + 1));
            const selectedText = document.getElementById('text--' + (pageIndex + 1));

            if (selectedBanner) selectedBanner.style.display = 'block';
            if (selectedText) selectedText.style.display = 'block';
            this.classList.add('active');

            // 배너의 배경색을 변경
            if (bannerContainer) bannerContainer.style.backgroundImage = bannerBackgrounds[pageIndex];
        });
    });

    // 초기 배경색 설정
    if (bannerContainer) bannerContainer.style.backgroundImage = bannerBackgrounds[0];
});
