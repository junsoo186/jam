document.addEventListener('DOMContentLoaded', function () {
	let isEmailVerified = false;  // 이메일 인증 여부를 저장하는 변수
	let isEmailDuplicate = false; // 이메일 중복 여부를 저장하는 변수

	// 이메일 중복 체크
	document.getElementById('email').addEventListener('blur', function () {
		const email = this.value;
		const emailCheckMessage = document.getElementById('emailCheckMessage');  // 메시지 표시 영역

		// 이메일 중복 체크 API 호출
		fetch(`/user/check-email?email=${encodeURIComponent(email)}`)
			.then(response => {
				if (response.status === 409) {
					// 중복된 이메일일 경우
					emailCheckMessage.textContent = '이미 사용 중인 이메일입니다.';
					emailCheckMessage.style.color = 'red';  // 중복일 경우 빨간색 표시
					document.getElementById('emailButton').disabled = true; // 인증 요청 버튼 비활성화
					isEmailDuplicate = true;
				} else if (response.ok) {
					// 사용 가능한 이메일일 경우
					emailCheckMessage.textContent = '사용 가능한 이메일입니다.';
					emailCheckMessage.style.color = 'green';  // 사용 가능할 경우 초록색 표시
					document.getElementById('emailButton').disabled = false; // 인증 요청 버튼 활성화
					isEmailDuplicate = false;
				}
			})
			.catch(error => {
				console.error('Error:', error);
				emailCheckMessage.textContent = '서버와의 통신 중 오류가 발생했습니다.';
				emailCheckMessage.style.color = 'red';
			});
	});

	// 인증 요청 버튼 클릭 시
	document.getElementById('emailButton').addEventListener('click', function () {
		const email = document.getElementById('email').value;

		// 이메일 유효성 검사
		const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (!emailPattern.test(email)) {
			alert('유효한 이메일을 입력하세요.');
			return;
		}

		// 이메일 중복인 경우 전송 차단
		if (isEmailDuplicate) {
			alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.');
			return;
		}

		// 서버로 인증 요청 (fetch 사용)
		fetch('/user/emails/verification-requests', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded',
			},
			body: new URLSearchParams({ 'email': email })
		}).then(response => {
			if (response.ok) {
				alert('인증 이메일이 전송되었습니다.');

				// 이메일 필드를 숨기고 인증 코드 입력 섹션을 표시
				document.getElementById('emailButton').style.display='none';
				document.getElementById('verificationEmail').value = email;  // 숨겨진 이메일 필드에 값 저장
				document.getElementById('verificationSection').style.display = 'block';  // 인증 코드 입력 섹션 표시
			} else {
				alert('인증 요청 중 오류가 발생했습니다.');
			}
		}).catch(error => {
			console.error('Error:', error);
			alert('서버와의 통신 중 오류가 발생했습니다.');
		});
	});

	// 인증 확인 버튼 동작
	document.getElementById('verificationButton').addEventListener('click', function () {
		const email = document.getElementById('verificationEmail').value;
		const authCode = document.getElementById('authCode').value;

		// 서버로 인증 코드 검증 요청
		fetch(`/user/emails/verifications?email=${encodeURIComponent(email)}&code=${encodeURIComponent(authCode)}`, {
			method: 'GET'
		}).then(response => response.json())
			.then(data => {
				if (data.success) {
					alert('이메일 인증이 성공했습니다.');

					// 인증 성공 시 인증 확인 버튼을 비활성화하고 인증 완료로 표시
					const verificationButton = document.getElementById('verificationButton');
					verificationButton.disabled = true;
					verificationButton.textContent = "인증 완료";

					// 이메일 인증 완료 플래그 설정
					isEmailVerified = true;
				} else {
					alert('인증 코드가 유효하지 않습니다.');
				}
			}).catch(error => {
				console.error('Error:', error);
				alert('오류가 발생했습니다.');
			});
	});

	// 회원가입 버튼 클릭 시
	document.querySelector('form').addEventListener('submit', function (event) {
		if (!isEmailVerified) {
			alert('이메일 인증을 완료해야 회원가입을 할 수 있습니다.');
			event.preventDefault();  // 폼 제출 중지
		}
	});
});
