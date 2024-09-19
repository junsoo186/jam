const ws = new WebSocket('ws://192.168.0.32:8080/ws/chat');

ws.onopen = function () {
    console.log('채팅방에 연결되었습니다.');
};

ws.onmessage = function (event) {
    const messagesDiv = document.getElementById('messages');
    try {
        const messageData = JSON.parse(event.data); 

        const messageContainer = document.createElement('div');
        messageContainer.className = (messageData.userId == userId) ? 'message-container my-message-container' : 'message-container other-message-container';

        const profileImage = document.createElement('img');
        profileImage.src = messageData.profileImg ? messageData.profileImg : '/path/to/default/profileImg.jpg'; 
        profileImage.className = 'profile-image';

        const message = document.createElement('div');
        message.className = (messageData.userId == userId) ? 'my-message' : 'other-message';
        message.innerHTML = (messageData.userId == userId) ? `나: ${messageData.content}` : `${messageData.nickname}: ${messageData.content}`;

        messageContainer.appendChild(profileImage);
        messageContainer.appendChild(message);

        messagesDiv.appendChild(messageContainer);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    } catch (error) {
        console.error("JSON 파싱 오류: ", error, "수신된 데이터:", event.data);
        const message = document.createElement('div');
        message.className = 'system-message';
        message.textContent = event.data; 
        messagesDiv.appendChild(message);
    }
};

ws.onclose = function () {
    console.log('연결이 끊겼습니다.');
};

ws.onerror = function (error) {
    console.error('WebSocket 오류가 발생했습니다:', error);
};

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

document.getElementById('messageInput').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
});