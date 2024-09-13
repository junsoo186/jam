// 이벤트 등록 모달 이벤트 바인딩 함수
function bindEventModalEvents() {
    var eventModal = document.getElementById('eventModal');
    var openEventModalBtn = document.getElementById('openEventModal');
    var closeEventModalBtn = document.querySelector('#eventModal .close');

    if (openEventModalBtn) {
        openEventModalBtn.addEventListener('click', function () {
            eventModal.style.display = 'flex';
        });
    }

    if (closeEventModalBtn) {
        closeEventModalBtn.addEventListener('click', function () {
            eventModal.style.display = 'none';
        });
    }

    window.addEventListener('click', function (event) {
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
        openNoticeModalBtn.addEventListener('click', function () {
            noticeModal.style.display = 'flex';
        });
    }

    if (closeNoticeModalBtn) {
        closeNoticeModalBtn.addEventListener('click', function () {
            noticeModal.style.display = 'none';
        });
    }

    window.addEventListener('click', function (event) {
        if (event.target == noticeModal) {
            noticeModal.style.display = 'none';
        }
    });
}

// 동적으로 콘텐츠를 로드하는 함수
function bindProjectModalEvents() {
    console.log("Binding project modal events"); // 이벤트 바인딩 확인

    // 동적으로 생성된 버튼을 위해 이벤트 위임 사용
    document.body.addEventListener('click', function (event) {
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
        closeModalBtn.addEventListener('click', function () {
            document.getElementById('projectModal').style.display = 'none';
            console.log("Modal closed."); // 모달 닫힘 이벤트 확인
        });
    }

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener('click', function (event) {
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

    openContentModalBtns.forEach(function (button) {
        button.addEventListener('click', function () {
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

    closeModalBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    window.addEventListener('click', function (event) {
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

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
                modal.style.display = 'flex'; // 모달 표시
            }
        };

        xhr.send();
    }

    // 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
    openBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
            loadExternalJSP(jspUrl); // JSP 파일 로드
        });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    closeModalBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener('click', function (event) {
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

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
                modal.style.display = 'flex'; // 모달 표시
            }
        };

        xhr.send();
    }

    // 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
    openBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
            loadExternalJSP(jspUrl); // JSP 파일 로드
        });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    closeModalBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
}

function bindPayModalEvents() {
    const modal = document.getElementById('payModal');
    const modalBody = document.getElementById('payModal'); // 모달 콘텐츠를 삽입할 영역
    const openBtns = document.querySelectorAll('.detail-pay-btn');
    const closeModalBtn = document.querySelector('.close');

    // openBtns가 존재하는지 확인하고 이벤트 바인딩
    if (openBtns) {
        openBtns.forEach(function (btn) {
            btn.addEventListener('click', function () {
                const jspUrl = btn.getAttribute('data-url');
                const refundId = btn.getAttribute('data-refund-id');
                loadExternalJSP(jspUrl, refundId);
            });
        });
    }

    // closeModalBtn이 존재하는지 확인하고 이벤트 바인딩
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', function () {
            modal.style.display = 'none';
        });
    }

    // modal 외부 클릭 시 닫기
    window.addEventListener('click', function (event) {
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

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                modalBody.innerHTML = xhr.responseText; // JSP 내용을 모달 안에 삽입
                modal.style.display = 'flex'; // 모달 표시
            }
        };

        xhr.send();
    }

    // 상세보기 버튼 클릭 시 모달 열기 및 JSP 파일 로드
    openBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            const jspUrl = btn.getAttribute('data-url'); // 버튼의 data-url 속성에서 JSP 파일 경로 가져오기
            loadExternalJSP(jspUrl); // JSP 파일 로드
        });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    closeModalBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
}