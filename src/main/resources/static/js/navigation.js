// 동적으로 콘텐츠를 로드하는 함수
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
				bindEventModalEvents(); // 이벤트 모달 이벤트 재설정
			} else if (url === '/staff/notice') {
				bindNoticeModalEvents(); // 공지 모달 이벤트 재설정
			}
		} else {
			document.getElementById('content').innerHTML = '콘텐츠를 불러오는 데 실패했습니다.';
		}
	};

	// 요청 보내기
	xhr.send();
}

// 이벤트 등록 모달 이벤트 바인딩 함수
function bindEventModalEvents() {
	var eventModal = document.getElementById('eventModal');
	var openEventModalBtn = document.getElementById('openEventModal');
	var closeEventModalBtn = document.querySelector('#eventModal .close');

	if (openEventModalBtn) {
		// "이벤트 등록" 버튼 클릭 시 모달 열기
		openEventModalBtn.addEventListener('click', function() {
			eventModal.style.display = 'flex';  // 모달을 표시
		});
	}

	if (closeEventModalBtn) {
		// "X" 버튼 클릭 시 이벤트 모달 닫기
		closeEventModalBtn.addEventListener('click', function() {
			eventModal.style.display = 'none';  // 모달을 숨김
		});
	}

	// 모달 밖의 영역 클릭 시 모달 닫기
	window.addEventListener('click', function(event) {
		if (event.target == eventModal) {
			eventModal.style.display = 'none';  // 모달을 숨김
		}
	});
}

// 공지 등록 모달 이벤트 바인딩 함수
function bindNoticeModalEvents() {
	var noticeModal = document.getElementById('noticeModal');
	var openNoticeModalBtn = document.getElementById('openNoticeModal');
	var closeNoticeModalBtn = document.querySelector('#noticeModal .close');

	if (openNoticeModalBtn) {
		// "공지 등록" 버튼 클릭 시 모달 열기
		openNoticeModalBtn.addEventListener('click', function() {
			noticeModal.style.display = 'flex';  // 모달을 표시
		});
	}

	if (closeNoticeModalBtn) {
		// "X" 버튼 클릭 시 공지 모달 닫기
		closeNoticeModalBtn.addEventListener('click', function() {
			noticeModal.style.display = 'none';  // 모달을 숨김
		});
	}

	// 모달 밖의 영역 클릭 시 모달 닫기
	window.addEventListener('click', function(event) {
		if (event.target == noticeModal) {
			noticeModal.style.display = 'none';  // 모달을 숨김
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