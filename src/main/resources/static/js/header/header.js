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
    
/*========*/    
    document.addEventListener("DOMContentLoaded", function() {
		var chatLink = document.getElementById('chat-link-admin');
		
		chatLink.addEventListener('click', function(event) {
			event.preventDefault();
			
			// 창 열기
			window.open('/admin/chatRooms', 'chatWindow', 'width=400,height=600')
		});
	});

//"이벤트 활성화 버튼"이 클릭되었을 때 이벤트 상태를 토글하는 함수
document.getElementById("toggle-event-button").addEventListener("click", function() {
    // fetch를 사용해 "/pay/toggleEvent"로 POST 요청을 보냄
    fetch("/pay/toggleEvent", { method: 'POST' })
        .then(response => {
            // 서버 응답이 성공적이면
            if (response.ok) {
                alert("이벤트 상태가 변경되었습니다.");  // 알림 메시지 출력
            } else {
                alert("이벤트 상태 변경 실패");  // 실패 시 알림 메시지 출력
            }
        });
});

//"이벤트 상태 확인" 버튼을 클릭했을 때 이벤트 상태를 확인하는 함수
document.getElementById("check-event-status-button").addEventListener("click", function() {
    // fetch를 사용해 "/pay/eventStatus"로 GET 요청을 보냄 (현재 이벤트 상태 확인)
    fetch("/pay/eventStatus")
        .then(response => response.json())  // 응답을 JSON 형식으로 받음
        .then(isEventActive => {
            // 이벤트가 활성화된 상태이면
            if (isEventActive) {
                alert("현재 이벤트 상태: 활성화");  // 이벤트 활성화 상태를 알림
            } else {
                alert("현재 이벤트 상태: 비활성화");  // 이벤트 비활성화 상태를 알림
            }
        })
        .catch(error => {
            // 오류가 발생한 경우 콘솔에 로그 출력
            console.error("이벤트 상태를 가져오는 중 오류 발생:", error);
        });
});



/*사이드바 관련 스크립트 종료*/


/*사이드바 관련 스크립트 종료*/