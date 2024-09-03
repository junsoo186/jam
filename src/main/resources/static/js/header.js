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
/*========*/
   document.addEventListener('DOMContentLoaded', function() {
        var chatLink = document.getElementById('chat-link');

        chatLink.addEventListener('click', function(event) {
            event.preventDefault(); 

            // 창 열기
            window.open('/chatPage', 'chatWindow', 'width=400,height=600');
        });
    });





/*사이드바 관련 스크립트 종료*/