document.addEventListener('DOMContentLoaded', function() {
	console.log("DOM fully loaded and parsed"); // DOM 로드 확인
	// 프로젝트 데이터 객체
	const projectData = {
		1: {
			name: "업무자동화 프로젝트",
			creator: "박민수",
			period: "2023-06-28 ~ 2023-08-10",
			goal: "80%",
			budget: "₩1,500,000",
			company: "레드트리 팀",
			contact: "박태영, 010-1111-2222",
			note: "말일에 제작 재확정 예정입니다. 업체 담당자에게 연락 부탁드립니다."
		},
		2: {
			name: "디자인 리뉴얼 프로젝트",
			creator: "이수진",
			period: "2023-07-01 ~ 2023-08-20",
			goal: "55%",
			budget: "₩800,000",
			company: "블루트리 팀",
			contact: "김영희, 010-2222-3333",
			note: "프로젝트 관련 사항 협의 중."
		}
	};
	const contentData = {
		1: {
			name: "어벤져스 대작",
			age: "전체이용가",
			creator: "김사자",
			period: "2024-08-26 ~ 2024-09-16",
			schedule: "6개월",
			goal: "수익 창출 및 펀딩",
			note: "이 콘텐츠는 재미를 최우선으로 두었습니다."
		}
		// Add more projects as necessary
	};

	// 메뉴 링크 클릭 이벤트 바인딩
	var menuLinks = document.querySelectorAll('.menu-link');
	menuLinks.forEach(function(link) {
		link.addEventListener('click', function() {
			var url = this.getAttribute('data-url');
			loadContent(url); // URL에 따라 콘텐츠 로드
		});
	});

	if (sectionUrl) {
		loadContent(sectionUrl);
	}
	// 동적으로 콘텐츠를 로드하는 함수
	function loadContent(url) {
		var xhr = new XMLHttpRequest();
		xhr.open('GET', url, true);
		xhr.onload = function() {
			if (xhr.status === 200) {
				document.getElementById('content').innerHTML = xhr.responseText;
				// 동적으로 로드된 콘텐츠에 이벤트 리스너 다시 바인딩
				if (url === '/staffEvent/list') {
					bindEventModalEvents(); // 이벤트 모달 이벤트 재설정
				} else if (url === '/staff/notice') {
					bindNoticeModalEvents(); // 공지 모달 이벤트 재설정
				} else if (url === '/staff/content-management') {
					bindProjectModalEvents(); // 프로젝트 모달 이벤트 재설정
					bindContentModalEvents(); // 컨텐츠 모달 이벤트 재설정
				} else if (url === '/staff/report') {
					bindReportContentModalEvents();
					bindReportUserModalEvents();
				} else if (url === '/staff/payment-management') {
					bindPayModalEvents();
					bindDonationModalEvents();
				}
			} else {
				document.getElementById('content').innerHTML = '콘텐츠를 불러오는 데 실패했습니다.';
			}
		};

		xhr.send();
	}

	// 이벤트 등록 모달 이벤트 바인딩 함수
	function bindEventModalEvents() {

		var eventModal = document.getElementById('eventModal');
		var openEventModalBtn = document.getElementById('openEventModal');

		var closeEventModalBtn = document.querySelector('#eventModal .close');

		if (openEventModalBtn) {
			openEventModalBtn.addEventListener('click', function() {
				eventModal.style.display = 'flex';
			});
		}

		if (closeEventModalBtn) {
			closeEventModalBtn.addEventListener('click', function() {
				eventModal.style.display = 'none';
			});
		}

		window.addEventListener('click', function(event) {
			if (event.target == eventModal) {
				eventModal.style.display = 'none';
			}
		});
	}

	// 공지 등록 모달 이벤트 바인딩 함수
	function bindNoticeModalEvents() {
		var noticeModal = document.getElementById('noticeModal');
		var openNoticeModalBtn = document.getElementById('openNoticeModal');
		var closeNoticeModalBtn = document.querySelector('#noticeModal .close');

		if (openNoticeModalBtn) {
			openNoticeModalBtn.addEventListener('click', function() {
				noticeModal.style.display = 'flex';
			});
		}

		if (closeNoticeModalBtn) {
			closeNoticeModalBtn.addEventListener('click', function() {
				noticeModal.style.display = 'none';
			});
		}

		window.addEventListener('click', function(event) {
			if (event.target == noticeModal) {
				noticeModal.style.display = 'none';
			}
		});
	}

	// 동적으로 콘텐츠를 로드하는 함수
	function bindProjectModalEvents() {
		console.log("Binding project modal events"); // 이벤트 바인딩 확인

		// 동적으로 생성된 버튼을 위해 이벤트 위임 사용
		document.body.addEventListener('click', function(event) {
			if (event.target.classList.contains('openProjectModalBtn')) {
				const projectId = event.target.getAttribute('data-id');
				console.log("Button clicked. Project ID:", projectId); // 버튼 클릭 시 projectId 확인

				const project = projectData[projectId];
				if (project) {
					console.log("Project data found:", project); // Project 데이터가 제대로 받아졌는지 확인

					document.getElementById('modal-project-name').textContent = project.name;
					document.getElementById('modal-creator').textContent = project.creator;
					document.getElementById('modal-period').textContent = project.period;
					document.getElementById('modal-goal').textContent = project.goal;
					document.getElementById('modal-budget').textContent = project.budget;
					document.getElementById('modal-company').textContent = project.company;
					document.getElementById('modal-contact').textContent = project.contact;
					document.getElementById('modal-note').textContent = project.note;

					document.getElementById('projectModal').style.display = 'flex';
					console.log("Modal opened."); // 모달이 제대로 열렸는지 확인
				} else {
					console.log("Project data not found for ID:", projectId); // 데이터가 없을 때 로그
				}
			}
		});

		// 모달 닫기 이벤트 바인딩
		var closeModalBtn = document.querySelector('#projectModal .close');
		if (closeModalBtn) {
			closeModalBtn.addEventListener('click', function() {
				document.getElementById('projectModal').style.display = 'none';
				console.log("Modal closed."); // 모달 닫힘 이벤트 확인
			});
		}

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener('click', function(event) {
			var projectModal = document.getElementById('projectModal');
			if (event.target == projectModal) {
				projectModal.style.display = 'none';
				console.log("Modal closed by clicking outside."); // 모달 외부 클릭으로 닫혔는지 확인
			}
		});
	}

	function bindContentModalEvents() {
		const openContentModalBtns = document.querySelectorAll('.openContentModalBtn');
		const modal = document.getElementById('contentModal');
		const closeModalBtn = document.querySelector('.close');

		openContentModalBtns.forEach(function(button) {
			button.addEventListener('click', function() {
				const contentId = this.getAttribute('data-id');
				const content = contentData[contentId];

				if (content) {
					document.getElementById('modal-project-name').textContent = content.name;
					document.getElementById('modal-age').textContent = content.age;
					document.getElementById('modal-creator').textContent = content.creator;
					document.getElementById('modal-period').textContent = content.period;
					document.getElementById('modal-schedule').textContent = content.schedule;
					document.getElementById('modal-goal').textContent = content.goal;
					document.getElementById('modal-note').textContent = content.note;

					modal.style.display = 'flex';
				}
			});
		});

		closeModalBtn.addEventListener('click', function() {
			modal.style.display = 'none';
		});

		window.addEventListener('click', function(event) {
			if (event.target === modal) {
				modal.style.display = 'none';
			}
		});
	}

	function bindReportContentModalEvents() {
		// 모달 관련 변수들
		const modal = document.getElementById('reportContentModal');
		const modalBody = document.getElementById('reportContentModalBody'); // 모달 콘텐츠를 삽입할 영역
		const openBtns = document.querySelectorAll('.detail-content-btn');
		const closeModalBtn = document.querySelector('.close');

		// AJAX로 외부 JSP 파일 불러오기 함수
		function loadExternalJSP(url) {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
					modal.style.display = 'flex'; // 모달 표시
				}
			};

			xhr.send();
		}

		// 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
		openBtns.forEach(function(btn) {
			btn.addEventListener('click', function() {
				const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
				loadExternalJSP(jspUrl); // JSP 파일 로드
			});
		});

		// 닫기 버튼 클릭 시 모달 닫기
		closeModalBtn.addEventListener('click', function() {
			modal.style.display = 'none';
		});

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener('click', function(event) {
			if (event.target === modal) {
				modal.style.display = 'none';
			}
		});
	}

	function bindReportUserModalEvents() {
		// 모달 관련 변수들
		const modal = document.getElementById('reportUserModal');
		const modalBody = document.getElementById('reportUserModal'); // 모달 콘텐츠를 삽입할 영역
		const openBtns = document.querySelectorAll('.detail-user-btn');
		const closeModalBtn = document.querySelector('.close');

		// AJAX로 외부 JSP 파일 불러오기 함수
		function loadExternalJSP(url) {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
					modal.style.display = 'flex'; // 모달 표시
				}
			};

			xhr.send();
		}

		// 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
		openBtns.forEach(function(btn) {
			btn.addEventListener('click', function() {
				const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
				loadExternalJSP(jspUrl); // JSP 파일 로드
			});
		});

		// 닫기 버튼 클릭 시 모달 닫기
		closeModalBtn.addEventListener('click', function() {
			modal.style.display = 'none';
		});

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener('click', function(event) {
			if (event.target === modal) {
				modal.style.display = 'none';
			}
		});
	}

	function bindPayModalEvents() {
		// 모달 관련 변수들
		const modal = document.getElementById('payModal');
		const modalBody = document.getElementById('payModal'); // 모달 콘텐츠를 삽입할 영역
		const openBtns = document.querySelectorAll('.detail-pay-btn');
		const closeModalBtn = document.querySelector('.close');

		// AJAX로 외부 JSP 파일 불러오기 함수
		function loadExternalJSP(url) {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
					modal.style.display = 'flex'; // 모달 표시
				}
			};

			xhr.send();
		}

		// 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
		openBtns.forEach(function(btn) {
			btn.addEventListener('click', function() {
				const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
				loadExternalJSP(jspUrl); // JSP 파일 로드
			});
		});

		// 닫기 버튼 클릭 시 모달 닫기
		closeModalBtn.addEventListener('click', function() {
			modal.style.display = 'none';
		});

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener('click', function(event) {
			if (event.target === modal) {
				modal.style.display = 'none';
			}
		});
	}

	function bindDonationModalEvents() {
		// 모달 관련 변수들
		const modal = document.getElementById('donationModal');
		const modalBody = document.getElementById('donationModal'); // 모달 콘텐츠를 삽입할 영역
		const openBtns = document.querySelectorAll('.detail-donation-btn');
		const closeModalBtn = document.querySelector('.close');

		// AJAX로 외부 JSP 파일 불러오기 함수
		function loadExternalJSP(url) {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
					modal.style.display = 'flex'; // 모달 표시
				}
			};

			xhr.send();
		}

		// 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
		openBtns.forEach(function(btn) {
			btn.addEventListener('click', function() {
				const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
				loadExternalJSP(jspUrl); // JSP 파일 로드
			});
		});

		// 닫기 버튼 클릭 시 모달 닫기
		closeModalBtn.addEventListener('click', function() {
			modal.style.display = 'none';
		});

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener('click', function(event) {
			if (event.target === modal) {
				modal.style.display = 'none';
			}
		});
	}


	// 메인페이지 이동
	document.getElementById('mainButton').addEventListener('click', function() {
		window.location.href = 'http://localhost:8080/';
	});

	// 페이지 로드 시 대시보드 콘텐츠를 기본으로 로드
	loadContent('/staff/dashboard');
});

// 채팅 페이지 연결 

document.addEventListener('DOMContentLoaded', function() {
	var chatLink = document.getElementById('chat-link');

	chatLink.addEventListener('click', function(event) {
		event.preventDefault();

		// 창 열기
		window.open('/chatPage', 'chatWindow', 'width=400,height=600');
	});
});

// 이벤트 수정 모달 이벤트 바인딩 함수
function bindEventUpdateModalEvents() {
    var eventUpdateModal = document.getElementById('eventUpdateModal');
    var closeEventUpdateModalBtn = document.querySelector('#eventUpdateModal .close');

    // 수정 버튼을 클릭할 때마다 해당 이벤트 ID로 모달을 엽니다.
    document.querySelectorAll('.edit-event-btn').forEach(button => {
        button.addEventListener('click', function() {
            var eventId = this.getAttribute('data-event-id');
            
            // 서버에서 해당 이벤트 정보를 가져와 모달에 채우기
            fetch(`/staffEvent/detail/${eventId}`)
                .then(response => response.json())
                .then(data => {
                    // 모달 내 폼에 데이터 채우기
                    document.getElementById('update-event-id').value = data.eventId;
                    document.getElementById('update-event-title').value = data.eventTitle;
                    document.getElementById('update-event-description').value = data.eventContent;
                    document.getElementById('update-start-day').value = data.startDay;
                    document.getElementById('update-end-day').value = data.endDay;

                    // 수정 모달 열기
                    eventUpdateModal.style.display = 'flex';
                })
                .catch(error => console.error('Error fetching event data:', error));
        });
    });

    // 수정 모달 닫기 이벤트
    if (closeEventUpdateModalBtn) {
        closeEventUpdateModalBtn.addEventListener('click', function() {
            eventUpdateModal.style.display = 'none';
        });
    }

    window.addEventListener('click', function(event) {
        if (event.target == eventUpdateModal) {
            eventUpdateModal.style.display = 'none';
        }
    });
}

window.onload = function() {
    bindEventModalEvents(); // 기존 이벤트 등록 모달 바인딩 함수
    bindEventUpdateModalEvents(); // 새로운 이벤트 수정 모달 바인딩 함수
};



