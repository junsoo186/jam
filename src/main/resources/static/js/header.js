/**
 *  헤더 스크립 트 영역
 *  사이바 구현 필요
 */

 
   document.addEventListener('DOMContentLoaded', function() {
        const isLoggedIn = true; 
        
        if (isLoggedIn) {
            const loginLabel = document.querySelector('.nav-login');
            loginLabel.textContent = '프로필';
            loginLabel.addEventListener('click', function() {
                // 프로필 페이지로 이동하는 코드 추가
                window.location.href = '/profile'; // 프로필 페이지 경로
            });
        }
    });