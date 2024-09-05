const ws = new WebSocket('ws://192.168.0.32:8080/ws/chat');

// 웹소켓 연결이 열렸을 때
ws.onopen = function() {
    console.log('채팅방에 연결되었습니다.');
};

// 메시지를 수신할 때
ws.onmessage = function(event) {
    const messagesDiv = document.getElementById('messages');
    try {
        const messageData = JSON.parse(event.data);

        // 메시지 컨테이너 생성
        const messageContainer = document.createElement('div');
        messageContainer.className = 'message-container';

        // 프로필 이미지 생성
        const profileImage = document.createElement('img');
        profileImage.src = (messageData.userId == userId) ? profileImg : messageData.profileImg;
        profileImage.className = 'profile-image';

        // 메시지 내용 생성
        const message = document.createElement('div');
        message.className = (messageData.userId == userId) ? 'my-message' : 'other-message';
        message.innerHTML = (messageData.userId == userId) ? `나: ${messageData.content}` : `${messageData.nickname}: ${messageData.content}`;

        // 메시지 컨테이너에 이미지와 메시지 추가
        messageContainer.appendChild(profileImage);
        messageContainer.appendChild(message);

        // 메시지를 화면에 추가
        messagesDiv.appendChild(messageContainer);
        messagesDiv.scrollTop = messagesDiv.scrollHeight; // 메시지를 추가한 후 스크롤을 맨 아래로 이동
    } catch (error) {
        console.error("JSON 파싱 오류: ", error, "수신된 데이터:", event.data);

        const message = document.createElement('div');
        message.className = 'system-message';
        message.textContent = event.data;
        messagesDiv.appendChild(message);
    }
};

// 웹소켓 연결이 닫혔을 때
ws.onclose = function() {
    console.log('연결이 끊겼습니다.');
};

// 웹소켓 오류가 발생했을 때
ws.onerror = function(error) {
    console.log('오류가 발생했습니다.');
};

// 메시지를 전송할 때
function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();
    if (message) {
        if (typeof nickname !== 'undefined') {
            ws.send(JSON.stringify({ userId: userId, nickname: nickname, content: message }));
            input.value = ''; 
        } else {
            console.error('nickname이 정의되지 않았습니다.');
        }
    } else {
        console.log('메시지는 비어 있을 수 없습니다.');
    }
}

// Enter 키로 메시지 전송을 트리거
document.getElementById('messageInput').addEventListener('keyup', function(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
});