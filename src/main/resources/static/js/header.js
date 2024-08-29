/**
 * 
 */

/*사이드바 관련 스크립트 시작*/
document.addEventListener("DOMContentLoaded", function() {
    const profile = document.querySelector('.nav-profile');
    const sidebar = document.querySelector('.sidebar');


    profile.addEventListener('click', function(event) {
        event.stopPropagation(); 
        sidebar.classList.toggle('open'); 
    });

    
    document.addEventListener('click', function(event) {
        if (!sidebar.contains(event.target) && !profile.contains(event.target)) {
            sidebar.classList.remove('open'); 
        }
    });

    
    sidebar.addEventListener('click', function(event) {
        event.stopPropagation();
    });
});
/*사이드바 관련 스크립트 종료*/