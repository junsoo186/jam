/**
 * 
 */



const ws = new WebSocket('ws://192.168.0.32:8080/ws/chat');

ws.onopen = function() {
    console.log('WebSocket 연결이 열렸습니다.');
};

ws.onmessage = function(event) {
    const messagesDiv = document.getElementById('messages');
    const message = document.createElement('div');
    message.textContent = event.data;
    messagesDiv.appendChild(message);
    messagesDiv.scrollTop = messagesDiv.scrollHeight; 
};

ws.onclose = function() {
    console.log('WebSocket 연결이 닫혔습니다.');
};

ws.onerror = function(error) {
    console.error('WebSocket 오류: ', error);
};

function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();
    if (message) {
        ws.send(` ${message}`);
        input.value = ''; 
    } else {
        console.log('메시지는 비어 있을 수 없습니다.');
    }
}