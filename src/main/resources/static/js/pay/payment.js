document.addEventListener("DOMContentLoaded", function() {
    let currentPage = 1;  // 처음 로드 시 페이지 번호는 1
    const pageSize = 5;   // 한 페이지당 보여줄 항목 수

    // 페이지 로드 시 데이터를 불러오는 함수
    function loadPayments(page) {
        fetch(`/pay/payment-management?page=${page}&pageSize=${pageSize}`)
            .then(response => response.json())
            .then(data => {
                renderPayments(data.payList);
                renderPagination(data.currentPage, data.totalPages);
            })
            .catch(error => console.error('Error:', error));
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
                    <td>${payment.paymentMethod}</td>
                    <td>${formatCurrency(payment.refundAmount)}</td>
                    <td>${payment.status}</td>
                    <td><button class="details-btn" data-id="${payment.refundId}">상세보기</button></td>
                `;

                paymentTableBody.appendChild(row);
            });

            bindDetailButtons();
        } else {
            paymentTableBody.innerHTML = "<tr><td colspan='7'>환불 신청 내역 없음</td></tr>";
        }
    }

    // 페이지네이션을 렌더링하는 함수
    function renderPagination(currentPage, totalPages) {
        const pagination = document.getElementById("pagination");
        pagination.innerHTML = "";  // 기존 페이지네이션을 비움

        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement("button");
            pageButton.textContent = i;
            pageButton.classList.add("page-btn");
            if (i === currentPage) {
                pageButton.classList.add("active");
            }
            pageButton.addEventListener("click", () => {
                currentPage = i;
                loadPayments(i);
            });
            pagination.appendChild(pageButton);
        }
    }

    // 상세보기 버튼에 이벤트 바인딩
    function bindDetailButtons() {
        const detailButtons = document.querySelectorAll(".details-btn");
        detailButtons.forEach(button => {
            button.addEventListener("click", function() {
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
        const closeModalBtn = document.querySelector('.close');
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

    // 금액 포맷팅 함수 (예시)
    function formatCurrency(amount) {
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(amount);
    }

    // 날짜 포맷팅 함수 (예시)
    function formatDate(dateString) {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('ko-KR', options);
    }

    // 페이지 최초 로드 시 결제 데이터를 불러옴
    loadPayments(currentPage);

    // **추가 1**: 자동 데이터 갱신 (30초마다 데이터 갱신)
    setInterval(function() {
        loadPayments(currentPage);
    }, 30000);  // 30초마다 자동 갱신
});
