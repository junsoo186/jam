document.addEventListener('DOMContentLoaded', function () {
    let currentPage = 1; // 페이지 번호는 1부터 시작
    const pageSize = 5; // 한 페이지에 보여줄 프로젝트 수
    const projectList = document.getElementById('project-list');
    const paginationContainer = document.querySelector('.pagination-container');

    function fetchProjects(page) {
        fetch(`/staff/content-management?page=${page}&size=${pageSize}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                displayProjects(data.projects); // 프로젝트 데이터 표시
                setupPagination(data.totalPages, page); // 총 페이지 수에 따라 페이지 버튼 생성
            })
            .catch(error => {
                console.error('Error fetching projects:', error);
            });
    }

    function displayProjects(projects) {
        projectList.innerHTML = ''; // 기존 목록 초기화
        projects.forEach(project => {
            // 날짜 포맷 (년-월-일 형식)
            const createdAtFormatted = new Date(project.createdAt).toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            });

            const dateEndFormatted = new Date(project.dateEnd).toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            });

            // 목표 금액 포맷
            const goalFormatted = project.goal.toLocaleString('ko-KR');

            // 테이블 행 생성
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td><a href="/funding/fundingDetail?projectId=${project.projectId}">${project.title}</td>
                <td>${project.author}</td>
                <td>${createdAtFormatted} ~ ${dateEndFormatted}</td>
                <td>₩${goalFormatted}</td>
                <td><button class="openProjectModalBtn" data-id="${project.projectId}">[상세]</button></td>
                <td>${project.staffAgree}</td>
            `;
            projectList.appendChild(tr);
        });
    }

    function setupPagination(totalPages, currentPage) {
        paginationContainer.innerHTML = ''; // 기존 페이지 버튼 초기화

        for (let i = 1; i <= totalPages; i++) { // 총 페이지 수에 맞춰 페이지 버튼 생성
            const pageButton = document.createElement('button');
            pageButton.classList.add('page-button');
            pageButton.textContent = i;
            if (i === currentPage) {
                pageButton.disabled = true; // 현재 페이지는 비활성화
            }
            pageButton.addEventListener('click', function () {
                fetchProjects(i); // 클릭된 페이지로 데이터 가져오기
            });
            paginationContainer.appendChild(pageButton);
        }
    }

    // 모달 창 열기 이벤트
    projectList.addEventListener('click', function (event) {
        if (event.target.classList.contains('openProjectModalBtn')) {
            const projectId = event.target.getAttribute('data-id');
            openModal(projectId);
        }
    });

    // 모달 열기 (외부 JSP)
    function openModal(projectId) {
        const modalContainer = document.getElementById('modalContainer'); // 모달이 로드될 요소
        fetch(`/staff/contentDetail?projectId=${projectId}`) // JSP 파일을 불러오는 요청
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text(); // 텍스트 형식으로 응답을 받음 (HTML)
            })
            .then(html => {
                modalContainer.innerHTML = html; // JSP에서 반환된 HTML을 모달 컨테이너에 삽입
                document.getElementById('projectModal').style.display = 'block'; // 모달 열기
            })
            .catch(error => console.error('Error fetching modal content:', error));
    }

    // 모달 닫기 이벤트
    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('close')) {
            document.getElementById('projectModal').style.display = 'none';
        }
    });

    // 초기 프로젝트 목록 로드
    fetchProjects(currentPage);
});
