// 메뉴 링크 클릭 이벤트 바인딩
function bindMenuLinks() {
    var menuLinks = document.querySelectorAll('.menu-link');

    // 이미 바인딩된 이벤트가 있을 수 있으므로, 기존 이벤트를 제거하고 새로 바인딩
    menuLinks.forEach(function (link) {
        link.removeEventListener('click', handleMenuClick); // 기존 이벤트 제거
        link.addEventListener('click', handleMenuClick);
    });
}

// 메뉴 링크 클릭 시 호출되는 함수
function handleMenuClick(event) {
    event.preventDefault(); // 기본 링크 동작 방지

    var url = this.getAttribute('data-url');
    console.log(`1. 메뉴 링크 클릭됨 - URL: ${url}`);
    loadContent(url); // URL에 따라 콘텐츠 로드
}

// 외부 스크립트를 로드하는 함수
function loadExternalScript(scriptUrl, callback) {
    var script = document.createElement('script');
    script.src = scriptUrl;
    script.type = 'text/javascript';

    // 스크립트 로드 완료 시 콜백 실행
    script.onload = function () {
        console.log(`${scriptUrl} 로드 완료`);
        if (callback) callback();
    };

    script.onerror = function () {
        console.error(`${scriptUrl} 로드 실패`);
    };

    document.body.appendChild(script);
}

function loadContent(url) {
    console.log(`2. 콘텐츠 로드 시작 - URL: ${url}`);

    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);

    xhr.onload = function () {
        console.log(`3. 콘텐츠 요청 응답 상태: ${xhr.status}`);
        if (xhr.status === 200) {
            console.log(`4. 콘텐츠 로드 성공 - URL: ${url}`);
            document.getElementById('content').innerHTML = xhr.responseText;

            if (url === '/pay/payment-management') {
                console.log('5. 결제 관리 페이지 로드 중 - /pay/payment-management');

                loadExternalScript('/js/pay/payment.js', function () {
                    console.log('6. payment.js 스크립트 로드 완료 및 이벤트 바인딩 중');

                    console.log('7. loadPaymentManagement 호출 전 확인');
                    console.log('window.loadPaymentManagement:', window.loadPaymentManagement);

                    if (typeof window.loadPaymentManagement === 'function') {
                        console.log('8. loadPaymentManagement 함수 호출 시작');
                        window.loadPaymentManagement();
                    } else {
                        console.error('8. loadPaymentManagement 함수가 정의되지 않음');
                    }

                    bindPayModalEvents();
                    bindDonationModalEvents();
                });
            }
        } else {
            console.error('4. 콘텐츠 로드 실패 - 응답 상태:', xhr.status);
            document.getElementById('content').innerHTML = '콘텐츠를 불러오는 데 실패했습니다.';
        }
    };

    xhr.onerror = function () {
        console.error('콘텐츠 로드 중 오류 발생');
        document.getElementById('content').innerHTML = '콘텐츠를 불러오는 도중 오류가 발생했습니다.';
    };

    xhr.send();
    console.log('2. XHR 요청 전송 완료');
}

// 페이지 로딩 시 메뉴 링크 바인딩
document.addEventListener('DOMContentLoaded', function () {
    console.log('0. DOMContentLoaded 이벤트 발생');
    bindMenuLinks();
});
