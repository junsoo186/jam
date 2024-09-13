document.addEventListener('DOMContentLoaded', function () {
    initializeChat();
});

// 채팅 기능 초기화
function initializeChat() {
    var chatLink = document.getElementById('chat-link');

    chatLink.addEventListener('click', function (event) {
        event.preventDefault();

        // 창 열기
        window.open('/chatPage', 'chatWindow', 'width=400,height=600');
    });
}