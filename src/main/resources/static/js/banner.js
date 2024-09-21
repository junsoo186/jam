
let currentBannerIndex = 0;
const banners = document.querySelectorAll('.banner--content');
const totalBanners = banners.length;
const bannerChangeInterval = 3000;

console.log("총 배너 수: ", totalBanners);  

if (totalBanners > 1) {
    function showNextBanner() {
        console.log("현재 배너 인덱스: ", currentBannerIndex); 

        
        banners[currentBannerIndex].style.display = 'none';

       
        currentBannerIndex = (currentBannerIndex + 1) % totalBanners;

        console.log("다음 배너 인덱스: ", currentBannerIndex);  

        
        banners[currentBannerIndex].style.display = 'block';
    }

    banners[currentBannerIndex].style.display = 'block';

   
    setInterval(showNextBanner, bannerChangeInterval);
} else {
    console.log("배너가 1개이므로 슬라이드를 실행하지 않습니다.");
}
