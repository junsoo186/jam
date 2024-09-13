document.addEventListener('DOMContentLoaded', function() {
	
	
	//현재 날짜를 가져와 max 속성으로 설정
	const birthDateInput = document.getElementById('birthDate');
	const today = new Date().toISOString().split('T')[0]; // 현재 날짜 형식화
	birthDateInput.setAttribute('max', today); // max 속성에 현재 날짜 설정

    document.getElementById('mFile').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewImage = document.getElementById('previewImage');
                previewImage.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }  
    });
	
	
	// 닉네임 중복 체크
	const signUpButton = document.getElementById('modify'); // 수정하기 버튼
		
	
	function updateSignUpButton(isEnabled) {
		signUpButton.disabled = !isEnabled; // 버튼을 비활성화하거나 활성화
	}

//	updateSignUpButton(false); // 버튼 비활성화
	
	window.checkNickName = function() {
		const nickName = document.getElementById('nickName').value;
		const nickNameCheckMessage = document.getElementById('nickNameCheckMessage'); // 메시지 표시 영역
		
		
		

		// 닉네임이 입력되지 않았을 경우 중복 검사 실행 안함
		if (!nickName.trim()) {
			nickNameCheckMessage.textContent = '닉네임을 입력하세요.';
			nickNameCheckMessage.style.color = 'red';
			updateSignUpButton(false);
			return;
		}

		// 닉네임 중복 체크 API 호출
		fetch(`/user/check-nickname?nickName=${encodeURIComponent(nickName)}`)
			.then(response => {
				if (response.status === 409) {
					// 중복된 닉네임일 경우
					nickNameCheckMessage.textContent = '이미 사용 중인 닉네임입니다.';
					nickNameCheckMessage.style.color = 'red'; // 중복일 경우 빨간색 표시
					updateSignUpButton(false); // 버튼 비활성화
					isNickNameValid = false;
				} else if (response.ok) {
					// 사용 가능한 닉네임일 경우
					nickNameCheckMessage.textContent = '사용 가능한 닉네임입니다.';
					nickNameCheckMessage.style.color = 'green'; // 사용 가능할 경우 초록색 표시
					updateSignUpButton(true); // 버튼 활성화
					isNickNameValid = true;
				}
			})
			.catch(error => {
				console.error('Error:', error);
				nickNameCheckMessage.textContent = '서버와의 통신 중 오류가 발생했습니다.';
				nickNameCheckMessage.style.color = 'red';
				updateSignUpButton(false); // 버튼 비활성화
				isNickNameValid = false;
			});
		};

	});
	
	
	// 숫자만 입력받도록 제한하는 함수 (전화번호 숫자만 받기 최대 13자리)
    function validatePhoneNumber(input) {
        const value = input.value;

        // 숫자가 아닌 값은 모두 제거
        input.value = value.replace(/[^0-9]/g, '');

        // 최대 11자리까지만 입력 가능
        if (input.value.length > 11) {
            input.value = input.value.substring(0, 11);
        }
    }
	
	
	
	
	
	