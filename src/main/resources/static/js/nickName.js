let checkNickName = window.document.getElementById("nickName");
let checkNickNameButton = window.document.getElementById("checkNickName");

checkNickNameButton.addEventListener("click", function () {
    alert("닉네임 중복 버튼 연결 알림");

    // checkNickName 입력 필드의 값을 가져와 nickname 변수에 저장합니다.
    let nickname = checkNickName.value;
	console.log(nickname)
    // nickname 변수를 사용하여 fetch 요청을 보냅니다.
    fetch('/user/messageTest', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            nickname: nickname // nickname 변수를 JSON 형식으로 변환하여 보냅니다.
        }),
    })
    .then(response => {
        if (response.ok) {
            return response.json(); // 응답을 JSON 형식으로 변환합니다.
        } else {
            throw new Error('Network response was not ok');
        }
    })
    .then(data => {
        // 서버로부터의 응답 데이터를 처리합니다.
        alert('POST 요청이 성공했습니다: ' + JSON.stringify(data));
    })
    .catch(error => {
        console.error('Fetch 작업에 문제가 발생했습니다:', error);
        alert('POST 요청 중 오류가 발생했습니다');
    });
});