


document.addEventListener('DOMContentLoaded', function() {
	
	const signUpButton = document.querySelector('button[type="submit"]'); // 가입하기 버튼
	
	function updateSignUpButton(isEnabled) {
        signUpButton.disabled = !isEnabled; // 버튼을 비활성화하거나 활성화
    }
    
	updateSignUpButton(false); // 버튼 비활성화
	
	window.checkNickName = function() {
		const nickName = document.getElementById('nickName').value;
	//	const nickNameCheckMessage = document.getElementById('nickNameCheckMessage'); // 메시지 표시 영역
		const nickNameCheckMessage = document.getElementById('nickNameChek'); // 메시지 표시 영역

		// 닉네임 중복 체크 API 호출
		fetch(`/user/check-nickname?nickName=${encodeURIComponent(nickName)}`)
			.then(response => {
				if (response.status === 409) {
					// 중복된 닉네임일 경우
					nickNameCheckMessage.textContent = '이미 사용 중인 닉네임입니다.';
					nickNameCheckMessage.style.color = 'red'; // 중복일 경우 빨간색 표시
					updateSignUpButton(false); // 버튼 비활성화
					
				} else if (response.ok) {
					// 사용 가능한 닉네임일 경우
					nickNameCheckMessage.textContent = '사용 가능한 닉네임입니다.';
					nickNameCheckMessage.style.color = 'green'; // 사용 가능할 경우 초록색 표시
					updateSignUpButton(true); // 버튼 활성화
				}
			})
			.catch(error => {
				console.error('Error:', error);
				nickNameCheckMessage.textContent = '서버와의 통신 중 오류가 발생했습니다.';
				nickNameCheckMessage.style.color = 'red';
				 updateSignUpButton(false); // 버튼 비활성화
			});
	};

});