
// WebSocket 연결 설정
// 서버에서 WebSocket을 통해 해당 채팅방에 연결. localhost 환경에서 서버의 WebSocket 엔드포인트에 연결
// WebSocket 연결 설정
// 서버에서 WebSocket을 통해 해당 채팅방에 연결. localhost 환경에서 서버의 WebSocket 엔드포인트에 연결
const ws = new WebSocket(`ws://localhost:8080/ws/chat/${roomId}`);
// const ws = new WebSocket('ws://192.168.0.32:8080/ws/chat/${roomId}');

// WebSocket이 연결되었을 때 호출되는 함수
ws.onopen = function () {
	// 연결 성공 시 콘솔에 메시지 출력
    console.log('채팅방에 연결되었습니다.');
};

// 서버로부터 메시지를 수신할 때 호출되는 함수
ws.onmessage = function (event) {
	// 메시지를 표시할 div 요소
    const messagesDiv = document.getElementById('messages');
    try {
		// 서버로부터 받은 메시지를 JSON으로 파싱
        const messageData = JSON.parse(event.data); 
		
		// 메시지 컨테이너 div 생성
        const messageContainer = document.createElement('div');
        // 메시지 송신자가 현재 사용자와 같은지에 따라 다른 스타일 적용 (내 메시지 vs 다른 사용자의 메시지)
        messageContainer.className = (messageData.userId == userId) ? 'message-container my-message-container' : 'message-container other-message-container';
		
		// 프로필 이미지를 표시할 img 요소 생성
        const profileImage = document.createElement('img');
        // 사용자가 프로필 이미지를 지정했는지 확인하고, 없으면 기본 이미지를 사용
        profileImage.src = messageData.profileImg ? messageData.profileImg : '/path/to/default/profileImg.jpg'; 
        profileImage.className = 'profile-image'; // 프로필 이미지에 클래스 추가
		
		// 메시지를 표시할 div 요소 생성
        const message = document.createElement('div');
        // 송신자에 따라 메시지 스타일을 다르게 적용
        message.className = (messageData.userId == userId) ? 'my-message' : 'other-message';
        // 현재 사용자의 메시지면 "나:", 다른 사용자의 메시지면 닉네임과 함께 메시지 표시
        message.innerHTML = (messageData.userId == userId) ? `나: ${messageData.content}` : `${messageData.nickname}: ${messageData.content}`;
		
		// 메시지 컨테이너에 프로필 이미지와 메시지 내용을 추가
        messageContainer.appendChild(profileImage);
        messageContainer.appendChild(message);
		
		// 메시지 div에 새 메시지 컨테이너를 추가하여 화면에 표시
        messagesDiv.appendChild(messageContainer);
        // 스크롤을 가장 아래로 자동으로 이동시켜 최신 메시지가 항상 보이도록 설정
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    } catch (error) {
		// JSON 파싱에 실패했을 때 예외 처리
        console.error("JSON 파싱 오류: ", error, "수신된 데이터:", event.data);
        const message = document.createElement('div');
        message.className = 'system-message';
        // JSON 파싱에 실패하면 데이터를 그대로 시스템 메시지로 표시
        message.textContent = event.data; 
        messagesDiv.appendChild(message);
    }
};

// WebSocket 연결이 종료되었을 때 호출되는 함수
ws.onclose = function () {
	// 연결 종료 시 콘솔에 메시지 출력
    console.log('연결이 끊겼습니다.');
};

// WebSocket 오류가 발생했을 때 호출되는 함수
ws.onerror = function (error) {
	// 오류 발생 시 콘솔에 출력
    console.error('WebSocket 오류가 발생했습니다:', error);
};

// 사용자가 메시지를 전송할 때 호출되는 함수
function sendMessage() {
	// 메시지를 입력하는 input 필드
    const input = document.getElementById('messageInput');
    // 입력된 메시지에서 앞뒤 공백을 제거
    const message = input.value.trim();
    if (message) {  // 메시지가 비어 있지 않을 때
        if (typeof nickname !== 'undefined') { // nickname 변수가 정의되어 있는지 확인
       		// WebSocket을 통해 서버로 메시지 전송 (JSON 형태로 사용자 정보와 메시지 내용 전송)
            ws.send(JSON.stringify({ userId: userId, nickname: nickname, content: message }));
            input.value = ''; // 메시지를 전송한 후 input 필드를 비움
        } else {
			// nickname이 없으면 오류 출력
            console.error('nickname이 정의되지 않았습니다.');
        }
    } else {
		// 메시지가 비어 있을 경우 경고 출력
        console.log('메시지는 비어 있을 수 없습니다.');
    }
}

// 메시지 입력 필드에서 Enter 키를 눌렀을 때 메시지를 전송하는 이벤트 리스너
document.getElementById('messageInput').addEventListener('keyup', function (event) {
    if (event.key === 'Enter') { // Enter 키를 눌렀을 때
    	// 메시지 전송 함수 호출
        sendMessage(); 
    }
});