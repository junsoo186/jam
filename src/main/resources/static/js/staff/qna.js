document.addEventListener('DOMContentLoaded', function () {
    let currentPage = 1;
    const pageSize = 10;
    const searchInput = document.getElementById('searchInput');
    const modal = document.getElementById('qnaModal');
    const modalBody = document.getElementById('modalBody');
    const closeModalBtn = document.querySelector('.close-modal');

    // QnA 데이터를 서버에서 불러오는 함수
    function loadQna(page, searchQuery = '') {
        const url = searchQuery
            ? `/staff/qna?page=${page}&size=${pageSize}&search=${searchQuery}`
            : `/staff/qna?page=${page}&size=${pageSize}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                renderQnaList(data.qnaList);
                renderPagination(data.currentPage, data.totalPages);
            })
            .catch(error => console.error('Error:', error));
    }

    // QnA 데이터를 테이블에 렌더링하는 함수
    function renderQnaList(qnaList) {
        const qnaTableBody = document.getElementById('qnaTableBody');
        qnaTableBody.innerHTML = ''; // 기존 데이터 초기화

        if (qnaList.length > 0) {
            qnaList.forEach((qna) => {
                const row = document.createElement('tr');
                const createdAtFormatted = new Date(qna.createdAt).toLocaleDateString('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                });

                row.innerHTML = `
                    <td>${createdAtFormatted}</td>
                    <td>${qna.title}</td>
                    <td>${qna.answerContent ? qna.staffName : '미정'}</td>
                    <td><span class="status-label ${qna.answerContent ? 'blue' : 'green'}">${qna.answerContent ? '답변 완료' : '답변 대기 중'}</span></td>
                    <td>
                        <button class="btn btn-view" data-id="${qna.qnaId}">보기</button>
                        <button class="btn btn-delete" data-id="${qna.qnaId}">삭제</button>
                    </td>
                `;

                qnaTableBody.appendChild(row);

                // 보기 버튼에 이벤트 리스너 추가 (QnA 상세 보기)
                row.querySelector('.btn-view').addEventListener('click', function () {
                    const qnaId = this.getAttribute('data-id');
                    openQnaDetailModal(qnaId); // QnA 상세 모달 열기
                });

                // 삭제 버튼에 이벤트 리스너 추가 (QnA 삭제)
                row.querySelector('.btn-delete').addEventListener('click', function () {
                    const qnaId = this.getAttribute('data-id');
                    deleteQna(qnaId); // QnA 삭제 함수 호출
                });
            });
        } else {
            qnaTableBody.innerHTML = '<tr><td colspan="5">Q&A 문의 내역이 없습니다.</td></tr>';
        }
    }

    // QnA 삭제 함수
    function deleteQna(qnaId) {
        if (confirm('정말로 이 Q&A를 삭제하시겠습니까?')) {
            fetch(`/staff/qnaDelete/${qnaId}`, {
                method: 'DELETE',
            })
            .then(response => {
                if (response.ok) {
                    alert('Q&A가 삭제되었습니다.');
                    loadQna(currentPage); // QnA 리스트 다시 로드
                } else {
                    alert('Q&A 삭제에 실패했습니다.');
                }
            })
            .catch(error => console.error('Error deleting QnA:', error));
        }
    }

    // QnA 상세 모달을 여는 함수
    function openQnaDetailModal(qnaId) {
        fetch(`/staff/qnaDetail/${qnaId}`)
            .then(response => response.text()) // JSP 파일을 텍스트 형식으로 불러옴
            .then(html => {
                modalBody.innerHTML = html; // JSP 파일 내용을 모달에 삽입
                modal.style.display = 'block'; // 모달을 화면에 표시
            })
            .catch(error => console.error('Error loading QnA detail:', error));
    }

    // 모달 닫기
    closeModalBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });

    // 페이지네이션을 렌더링하는 함수
    function renderPagination(currentPage, totalPages) {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = ''; // 기존 페이지 버튼 초기화

        // 이전 버튼
        if (currentPage > 1) {
            const prevButton = document.createElement('button');
            prevButton.textContent = '이전';
            prevButton.addEventListener('click', function () {
                loadQna(currentPage - 1, searchInput.value);
            });
            pagination.appendChild(prevButton);
        }

        // 페이지 번호 버튼
        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement('button');
            pageButton.textContent = i;
            if (i === currentPage) {
                pageButton.disabled = true; // 현재 페이지 비활성화
            }
            pageButton.addEventListener('click', function () {
                loadQna(i, searchInput.value);
            });
            pagination.appendChild(pageButton);
        }

        // 다음 버튼
        if (currentPage < totalPages) {
            const nextButton = document.createElement('button');
            nextButton.textContent = '다음';
            nextButton.addEventListener('click', function () {
                loadQna(currentPage + 1, searchInput.value);
            });
            pagination.appendChild(nextButton);
        }
    }

    // 검색 버튼 클릭 시 검색 결과를 로드
    document.getElementById('searchBtn').addEventListener('click', function () {
        loadQna(1, searchInput.value); // 검색 시 1페이지부터 로드
    });

    // 페이지 최초 로드 시 QnA 데이터를 불러옴
    loadQna(currentPage);
});
