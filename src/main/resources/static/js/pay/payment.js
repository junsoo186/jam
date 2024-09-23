document.addEventListener("DOMContentLoaded", function () {
    let currentPage = 1;  // 처음 로드 시 페이지 번호는 1
    const pageSize = 5;   // 한 페이지당 보여줄 항목 수

    // 페이지 로드 시 데이터를 불러오는 함수
    function loadPayments(page) {
        fetch(`/pay/payment-management?page=${page}&pageSize=${pageSize}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                renderPayments(data.payList); // 결제 리스트 렌더링
                renderPagination(data.currentPage, data.totalPages); // 페이지네이션 생성
            })
            .catch(error => console.error('Error fetching payments:', error));
    }

    // 결제 데이터를 테이블에 렌더링하는 함수
    function renderPayments(payList) {
        const paymentTableBody = document.getElementById("paymentTableBody");
        paymentTableBody.innerHTML = "";  // 기존 데이터를 비움

        if (payList.length > 0) {
            payList.forEach(payment => {
                const row = document.createElement("tr");

                row.innerHTML = `
                    <td>${formatDate(payment.createdAt)}</td>
                    <td>${payment.paymentKey}</td>
                    <td>${payment.email}</td>
                    <td>${payment.method}</td>
                    <td>${formatCurrency(payment.refundAmount)}</td>
                    <td>${payment.status}</td>
                    <td><button class="details-btn" data-id="${payment.refundId}">상세보기</button></td>
                `;
                paymentTableBody.appendChild(row);
            });

            // 상세보기 버튼에 이벤트 바인딩
            bindDetailButtons();
        } else {
            paymentTableBody.innerHTML = "<tr><td colspan='7'>환불 신청 내역 없음</td></tr>";
        }
    }

    // 페이지네이션을 렌더링하는 함수
    function renderPagination(currentPage, totalPages) {
        const pagination = document.getElementById("pagination");
        pagination.innerHTML = "";  // 기존 페이지네이션을 비움

        if (totalPages === 0) return; // 페이지가 없는 경우는 아무 작업도 하지 않음

        // 이전 페이지 버튼 추가
        const prevButton = document.createElement("button");
        prevButton.textContent = "이전";
        prevButton.disabled = currentPage === 1;
        prevButton.addEventListener("click", () => loadPayments(currentPage - 1));
        pagination.appendChild(prevButton);

        // 각 페이지 버튼 생성
        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement("button");
            pageButton.textContent = i;
            pageButton.classList.add("page-btn");
            if (i === currentPage) {
                pageButton.classList.add("active");
                pageButton.disabled = true; // 현재 페이지는 비활성화
            }
            pageButton.addEventListener("click", () => loadPayments(i));
            pagination.appendChild(pageButton);
        }

        // 다음 페이지 버튼 추가
        const nextButton = document.createElement("button");
        nextButton.textContent = "다음";
        nextButton.disabled = currentPage === totalPages;
        nextButton.addEventListener("click", () => loadPayments(currentPage + 1));
        pagination.appendChild(nextButton);
    }

    // 상세보기 버튼에 이벤트 바인딩
    function bindDetailButtons() {
        const detailButtons = document.querySelectorAll(".details-btn");
        detailButtons.forEach(button => {
            button.addEventListener("click", function () {
                const paymentId = this.getAttribute("data-id");
                openPayModal(paymentId);
            });
        });
    }

    // 모달 열기 및 외부 JSP 파일 로드
    function openPayModal(refundId) {
        const modal = document.getElementById('payModal');
        const modalBody = document.getElementById('payModalBody');

        // AJAX로 모달에 보여줄 JSP 파일을 로드
        fetch(`/pay/payDetail?refundId=${refundId}`)
            .then(response => response.text())
            .then(html => {
                modalBody.innerHTML = html;  // 모달 내용에 JSP 파일을 삽입
                modal.style.display = 'block';  // 모달을 보여줌
            })
            .catch(error => console.error('Error loading modal content:', error));

        // 모달 닫기 이벤트 설정
        const closeModalBtn = modal.querySelector('.close');
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

    // 금액 포맷팅 함수
    function formatCurrency(amount) {
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(amount);
    }

    // 날짜 포맷팅 함수
    function formatDate(dateString) {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('ko-KR', options);
    }

    // 페이지 최초 로드 시 결제 데이터를 불러옴
    loadPayments(currentPage);

    // 자동 데이터 갱신 (30초마다)
    setInterval(function () {
        loadPayments(currentPage);
    }, 30000);  // 30초마다 자동 갱신
});
