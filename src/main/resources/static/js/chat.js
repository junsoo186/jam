/**
 * 
 */

        const ws = new WebSocket('ws://localhost:8080/ws/chat');

        ws.onopen = function() {
            console.log('WebSocket connection opened');
        };

        ws.onmessage = function(event) {
            const messagesDiv = document.getElementById('messages');
            const message = document.createElement('div');
            message.textContent = event.data;
            messagesDiv.appendChild(message);
            messagesDiv.scrollTop = messagesDiv.scrollHeight; 
        };

        ws.onclose = function() {
            console.log('WebSocket connection closed');
        };

        ws.onerror = function(error) {
            console.error('WebSocket error: ', error);
        };

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            if (message) {
                ws.send(message);
                input.value = ''; 
            } else {
                console.log('Message cannot be empty');
            }
        }