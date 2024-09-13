// menu.js

// 메뉴 링크 클릭 이벤트 바인딩
function bindMenuLinks() {
    var menuLinks = document.querySelectorAll('.menu-link');
    menuLinks.forEach(function (link) {
        link.addEventListener('click', function () {
            var url = this.getAttribute('data-url');
            loadContent(url); // URL에 따라 콘텐츠 로드
        });
    });
}

// 동적으로 콘텐츠를 로드하는 함수
function loadContent(url) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            document.getElementById('content').innerHTML = xhr.responseText;

            // 동적으로 로드된 콘텐츠에 이벤트 리스너 다시 바인딩
            if (url === '/staff/event') {
                bindEventModalEvents();
            } else if (url === '/staff/notice') {
                bindNoticeModalEvents();
            } else if (url === '/staff/content-management') {
                bindProjectModalEvents();
                bindContentModalEvents();
            } else if (url === '/staff/report') {
                bindReportContentModalEvents();
                bindReportUserModalEvents();
            } else if (url === '/pay/payment-management') {
                bindPayModalEvents();
                bindDonationModalEvents();
            }
        } else {
            document.getElementById('content').innerHTML = '콘텐츠를 불러오는 데 실패했습니다.';
        }
    };

    xhr.send();
}
