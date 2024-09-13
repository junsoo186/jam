function loadPaymentManagement(page = 1, pageSize = 5) {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `/pay/payment-management?page=${page}&pageSize=${pageSize}`, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            const data = JSON.parse(xhr.responseText);
            const payList = data.payList;
            const currentPage = data.currentPage;
            const totalPages = data.totalPages;

            // 결제 목록 렌더링
            const tableBody = document.getElementById('paymentTableBody');
            tableBody.innerHTML = '';

            payList.forEach(function (pay) {
                const row = `<tr>
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

            // 페이지네이션 처리
            const pagination = document.getElementById('pagination');
            pagination.innerHTML = '';

            for (let i = 1; i <= totalPages; i++) {
                const pageButton = `<button onclick="loadPaymentManagement(${i}, ${pageSize})">${i}</button>`;
                pagination.insertAdjacentHTML('beforeend', pageButton);
            }
        } else {
            console.error('데이터 로드 실패');
        }
    };

    xhr.send();
}

// 초기 페이지 로드 시 호출
document.addEventListener('DOMContentLoaded', function () {
    loadPaymentManagement();
});
