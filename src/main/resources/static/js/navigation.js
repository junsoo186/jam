function loadContent(url) {
    // XMLHttpRequest 객체 생성
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    
    // 서버 응답을 받았을 때 처리할 내용
    xhr.onload = function() {
        if (xhr.status === 200) {
            // content 영역에 서버에서 받은 데이터를 삽입
            document.getElementById('content').innerHTML = xhr.responseText;

            // 동적으로 로드된 콘텐츠에 이벤트 리스너 다시 바인딩
            if (url === '/staff/event') {
                bindModalEvents(); // 모달 이벤트 재설정 함수 호출
            }
        } else {
            document.getElementById('content').innerHTML = '콘텐츠를 불러오는 데 실패했습니다.';
        }
    };

    // 요청 보내기
    xhr.send();
}

// 모달 이벤트 리스너 바인딩 함수
function bindModalEvents() {
    var modal = document.getElementById('eventModal');
    var openModalBtn = document.getElementById('openEventModal');
    var closeModalBtn = document.querySelector('.modal .close');

    if (openModalBtn) {
        // "이벤트 등록" 버튼 클릭 시 모달 열기
        openModalBtn.addEventListener('click', function() {
            modal.style.display = 'block';  // 모달을 표시
        });
    }

    if (closeModalBtn) {
        // "X" 버튼 클릭 시 모달 닫기
        closeModalBtn.addEventListener('click', function() {
            modal.style.display = 'none';  // 모달을 숨김
        });
    }

    // 모달 밖의 영역 클릭 시 모달 닫기
    window.addEventListener('click', function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';  // 모달을 숨김
        }
    });
}

// 메인페이지 이동
document.getElementById('mainButton').addEventListener('click', function() {
			window.location.href = 'http://localhost:8080/';
		});
		
// 페이지 로드 시 대시보드 콘텐츠를 기본으로 로드
window.onload = function() {
    loadContent('/staff/dashboard');
};
