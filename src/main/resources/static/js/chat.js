/**
 * 
 */



const ws = new WebSocket('ws://192.168.0.32:8080/ws/chat');

ws.onopen = function() {
       ws.send(`채팅방 연결되었습니다..`);
};

ws.onmessage = function(event) {
    const messagesDiv = document.getElementById('messages');
    const message = document.createElement('div');
    message.textContent = `${nickname}: ${event.data}`; 
    messagesDiv.appendChild(message);
    messagesDiv.scrollTop = messagesDiv.scrollHeight; 
};

ws.onclose = function() {
     ws.send(`연결 끊겼습니다.`); 
};

ws.onerror = function(error) {
    ws.send(`오류 발생`); 
};

function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();
    if (message) {
        ws.send(`${nickname}: ${message}`); 
        input.value = ''; 
    } else {
        console.log('메시지는 비어 있을 수 없습니다.');
    }
}

document.getElementById('messageInput').addEventListener('keyup', function(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
});