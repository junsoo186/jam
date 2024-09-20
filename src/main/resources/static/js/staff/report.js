document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('reportContentModal');
    const modalBody = document.getElementById('reportContentModalBody');
    const closeBtn = document.querySelector('.close');
    let hideProcessed = true;  // 내역 숨기기 상태

    // 모달 창을 여는 함수
    function openModal(url) {
        fetch(url)
            .then(response => response.text())
            .then(data => {
                modalBody.innerHTML = data;  // 모달 본문에 데이터 삽입
                modal.style.display = 'block';  // 모달 창 열기
            })
            .catch(error => console.error('Error fetching detail:', error));
    }

    // 모달 닫기 버튼 클릭 이벤트 처리
    closeBtn.addEventListener('click', function () {
        modal.style.display = 'none';  // 모달 창 닫기
    });

    // 모달 바깥을 클릭하면 닫기
    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });

    // 테이블마다 다른 상세보기 URL을 설정하는 함수
    function bindDetailViewEvents() {
        document.querySelectorAll('.detail-content-btn').forEach(button => {
            button.addEventListener('click', function () {
                const reportType = this.getAttribute('data-report-type');  // 책, 프로젝트, 사용자 구분
                const reportId = this.getAttribute('data-report-id');      // reportId 값
                let url = '';

                // 신고 유형에 따라 다른 엔드포인트로 요청
                if (reportType === 'book') {
                    url = `/staff/bookReportDetail?reportId=${reportId}`;
                } else if (reportType === 'project') {
                    url = `/staff/projectReportDetail?reportId=${reportId}`;
                } else if (reportType === 'user') {
                    url = `/staff/userReportDetail?reportId=${reportId}`;
                }

                openModal(url);  // 모달 열기
            });
        });
    }

    // 신고 데이터를 가져오는 함수 (AJAX로)
    function loadReports() {
        fetch('/staff/report')  // 서버의 "/report" 엔드포인트에 요청
            .then(response => response.json())  // JSON 응답을 파싱
            .then(data => {
                // 책 신고 데이터를 렌더링
                renderReports('book-report-body', data.bookReports, 'book');

                // 프로젝트 신고 데이터를 렌더링
                renderReports('project-report-body', data.projectReports, 'project');

                // 사용자 신고 데이터를 렌더링
                renderReports('user-report-body', data.userReports, 'user');

                // 이벤트 리스너를 다시 바인딩합니다.
                bindDetailViewEvents();

                // 처리된 항목 숨기기 적용
                applyHideProcessed();
            })
            .catch(error => console.error('Error fetching reports:', error));
    }

    // 데이터를 테이블에 렌더링하는 함수
    // 데이터를 테이블에 렌더링하는 함수
    function renderReports(tableBodyId, reports, reportType) {
        const tableBody = document.getElementById(tableBodyId);
        tableBody.innerHTML = '';  // 기존 데이터를 비웁니다.

        // 새 데이터를 테이블에 추가합니다.
        reports.forEach(report => {
            const row = document.createElement('tr');
            row.classList.add(`${reportType}-report-row`);
            row.setAttribute('data-processed', report.processing);  // 처리된 상태 저장

            // 관리자 이름이 없을 경우 '담당자 없음'으로 대체
            const adminName = report.adminName ? report.adminName : '미 처리';

            row.innerHTML = `
                <td>${report.bookTitle || report.projectTitle || report.reportedUserName}</td>
                <td>${report.userName}</td>
                <td>${report.periodContent}</td>
                <td>${new Date(report.createdAt).toLocaleString()}</td>
                <td>${report.processing}</td>
                <td>${adminName}</td>  <!-- 관리자가 없는 경우 처리 -->
                <td>${report.bookReportCount || report.projectReportCount || report.userReportCount}</td>
                <td><button class="detail-content-btn" data-report-id="${report.reportId}" data-report-type="${reportType}">상세보기</button></td>
        `;
            tableBody.appendChild(row);
        });
    }


    // 처리된 항목 숨기기 / 보이기 기능
    const toggleProcessedBtn = document.getElementById('toggleProcessed');
    toggleProcessedBtn.addEventListener('click', function () {
        hideProcessed = !hideProcessed;
        applyHideProcessed();  // 처리된 항목 숨기기 또는 보이기
        toggleProcessedBtn.textContent = hideProcessed ? '처리된 내역 보기' : '처리된 내역 숨기기';
    });

    function applyHideProcessed() {
        document.querySelectorAll('tr[data-processed="Y"]').forEach(row => {
            row.style.display = hideProcessed ? 'none' : '';  // 처리된 항목 숨기거나 보이기
        });
    }

    // 신고된 순서대로 정렬하는 함수
    function sortReportsByDate(tableBodyId) {
        const tableBody = document.getElementById(tableBodyId);
        const rows = Array.from(tableBody.querySelectorAll('tr'));
        rows.sort((a, b) => {
            const dateA = new Date(a.querySelector('td:nth-child(4)').textContent);  // 신고일을 기준으로 정렬
            const dateB = new Date(b.querySelector('td:nth-child(4)').textContent);
            return dateA - dateB;  // 오름차순 정렬
        });
        rows.forEach(row => tableBody.appendChild(row));  // 정렬된 순서대로 다시 추가
    }

    // 정렬 버튼 클릭 이벤트 처리
    document.getElementById('sortBookReportsByDate').addEventListener('click', function () {
        sortReportsByDate('book-report-body');
    });
    document.getElementById('sortProjectReportsByDate').addEventListener('click', function () {
        sortReportsByDate('project-report-body');
    });
    document.getElementById('sortUserReportsByDate').addEventListener('click', function () {
        sortReportsByDate('user-report-body');
    });

    // 페이지 로드 시 데이터를 가져옵니다.
    loadReports();

    // 주기적으로 1분마다 데이터를 갱신합니다.
    setInterval(loadReports, 60000);
});
