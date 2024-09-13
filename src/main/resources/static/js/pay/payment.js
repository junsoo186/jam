let contentLoaded = false;

function loadContent() {
    if (contentLoaded) return; // 이미 로드된 경우 함수 종료
    contentLoaded = true; // 로드 중 표시

    console.log('콘텐츠 로드 시작');
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/pay/payment-management', true);

    xhr.onload = function() {
        if (xhr.status === 200) {
            console.log('콘텐츠 로드 성공');
            console.log('로드된 콘텐츠:', xhr.responseText);
            
            const contentContainer = document.getElementById('contentContainer'); // ID 확인
            if (contentContainer) {
                contentContainer.innerHTML = xhr.responseText;

                // 콘텐츠 삽입 후 바로 호출
                initializePaymentManagement();
            } else {
                console.error('콘텐츠를 삽입할 요소를 찾을 수 없습니다');
            }
        } else {
            console.error('콘텐츠 로드 실패', xhr.status);
        }
        contentLoaded = false; // 로드 완료 후 표시 초기화
    };

    xhr.onerror = function() {
        console.error('콘텐츠 로드 중 오류 발생');
        contentLoaded = false; // 오류 발생 시 표시 초기화
    };

    xhr.send();
    console.log('콘텐츠 요청 전송 완료');
}


function initializePaymentManagement() {
    console.log('initializePaymentManagement 호출');

    const tableBody = document.getElementById('paymentTableBody');
    if (tableBody) {
        console.log('테이블 바디 요소 찾음');
        window.loadPaymentManagement(1, 5);
    } else {
        console.error('테이블 바디 요소를 찾을 수 없습니다');
    }
}

function initializePaymentManagement() {
    console.log('initializePaymentManagement 호출');

    // 테이블 바디 요소가 동적으로 로드된 콘텐츠 안에 존재할 경우
    const tableBody = document.getElementById('paymentTableBody');
    if (tableBody) {
        console.log('테이블 바디 요소 찾음');
        window.loadPaymentManagement(1, 5); // 페이지가 로드된 후에 호출
    } else {
        console.error('테이블 바디 요소를 찾을 수 없습니다');
    }
}

window.loadPaymentManagement = function (page = 1, pageSize = 5) {
    console.log(`1. loadPaymentManagement 호출됨 - Page: ${page}, Page Size: ${pageSize}`);

    const xhr = new XMLHttpRequest();
    xhr.open('GET', `/pay/payment-management?page=${page}&pageSize=${pageSize}`, true);

    xhr.onload = function () {
        console.log(`2. XHR 요청 성공 - 상태: ${xhr.status}`);
        if (xhr.status === 200) {
            try {
                console.log('3. JSON 데이터 파싱 시도');
                const data = JSON.parse(xhr.responseText);
                console.log('4. JSON 데이터 파싱 성공 - 데이터:', data);

                const payList = data.payList;
                const currentPage = data.currentPage;
                const totalPages = data.totalPages;

                const tableBody = document.getElementById('paymentTableBody');
                if (tableBody) {
                    console.log('5. 테이블 바디 찾음, 기존 데이터 지우기');
                    tableBody.innerHTML = '';

                    payList.forEach(function (pay, index) {
                        console.log(`6. 결제 목록 렌더링 중 - ${index + 1}/${payList.length}`);
                        const row = `
                            <tr>
                                <td>${pay.createdAt}</td>
                                <td>${pay.paymentKey}</td>
                                <td>${pay.email}</td>
                                <td>${pay.paymentMethod || 'N/A'}</td>
                                <td>${pay.refundAmount}원</td>
                                <td>${pay.status}</td>
                                <td><button class="detail-pay-btn" data-url="/pay/payDetail" data-refund-id="${pay.refundId}">[상세보기]</button></td>
                            </tr>`;
                        tableBody.insertAdjacentHTML('beforeend', row);
                    });

                    console.log('7. 결제 목록 렌더링 완료');
                    renderPagination(currentPage, totalPages, pageSize);
                } else {
                    console.error('5. 테이블 바디 요소를 찾을 수 없습니다');
                }
            } catch (error) {
                console.error('4. JSON 파싱 실패', error);
                console.error('서버 응답 내용: ', xhr.responseText);
            }
        } else {
            console.error(`2. XHR 요청 실패 - 상태: ${xhr.status}`);
        }
    };

    xhr.onerror = function () {
        console.error('2. XHR 요청 중 오류 발생');
    };

    xhr.send();
    console.log('1. XHR 요청 전송 완료');
};

// 페이지네이션 렌더링 함수
function renderPagination(currentPage, totalPages, pageSize) {
    console.log(`8. 페이지네이션 렌더링 시작 - 현재 페이지: ${currentPage}, 총 페이지: ${totalPages}`);
    const pagination = document.getElementById('pagination');
    if (!pagination) {
        console.error('8. 페이지네이션 요소를 찾을 수 없습니다');
        return;
    }

    if (!totalPages || totalPages < 2) {
        console.log('8. 총 페이지가 2개 미만이므로 페이지네이션을 표시하지 않음');
        return; // 페이지가 1개 이하일 경우 페이지네이션을 표시하지 않음
    }

    pagination.innerHTML = '';

    // 이전 버튼
    const prevButton = document.createElement('button');
    prevButton.textContent = '이전';
    prevButton.classList.add('page-item');
    if (currentPage === 1) {
        prevButton.classList.add('disabled');
    } else {
        prevButton.addEventListener('click', () => {
            console.log('9. 이전 버튼 클릭');
            loadPaymentManagement(currentPage - 1, pageSize);
        });
    }
    pagination.appendChild(prevButton);

    // 페이지 번호 (현재 페이지 주변 2개씩 표시)
    const maxVisiblePages = 5;
    let startPage = Math.max(currentPage - 2, 1);
    let endPage = Math.min(currentPage + 2, totalPages);

    if (currentPage <= 3) {
        endPage = Math.min(5, totalPages);
    } else if (currentPage + 2 >= totalPages) {
        startPage = Math.max(totalPages - 4, 1);
    }

    if (startPage > 1) {
        addPageItem(1);
        if (startPage > 2) {
            addEllipsis();
        }
    }

    for (let i = startPage; i <= endPage; i++) {
        addPageItem(i);
    }

    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            addEllipsis();
        }
        addPageItem(totalPages);
    }

    // 다음 버튼
    const nextButton = document.createElement('button');
    nextButton.textContent = '다음';
    nextButton.classList.add('page-item');
    if (currentPage === totalPages) {
        nextButton.classList.add('disabled');
    } else {
        nextButton.addEventListener('click', () => {
            console.log('9. 다음 버튼 클릭');
            loadPaymentManagement(currentPage + 1, pageSize);
        });
    }
    pagination.appendChild(nextButton);

    function addPageItem(pageNumber) {
        const pageButton = document.createElement('button');
        pageButton.textContent = pageNumber;
        pageButton.classList.add('page-item');
        if (pageNumber === currentPage) {
            pageButton.classList.add('active');
        } else {
            pageButton.addEventListener('click', () => {
                console.log(`9. 페이지 번호 클릭 - 이동할 페이지: ${pageNumber}`);
                loadPaymentManagement(pageNumber, pageSize);
            });
        }
        pagination.appendChild(pageButton);
    }

    function addEllipsis() {
        const dots = document.createElement('span');
        dots.textContent = '...';
        dots.classList.add('page-item');
        dots.style.cursor = 'default';
        pagination.appendChild(dots);
    }

    console.log('8. 페이지네이션 렌더링 완료');
}
