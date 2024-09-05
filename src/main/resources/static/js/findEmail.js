function checkEmail(event) {
    event.preventDefault(); // 폼 제출 막기

    const email = document.getElementById("email").value;
    const resultDiv = document.getElementById("result");

    if (!email) {
        resultDiv.innerHTML = "이메일을 입력해주세요.";
        return;
    }

    // 이메일 확인 요청을 서버로 보내기
    fetch(`/user/check-email?email=${encodeURIComponent(email)}`)
        .then(response => {
            if (response.status === 409) {
                return response.text().then(text => {
                    resultDiv.innerHTML = `<p style="color: red;">가입이 되어있는 이메일 입니다.</p>`;
                });
            } else if (response.ok) {
                return response.text().then(text => {
                    resultDiv.innerHTML = `<p style="color: green;">가입 되어 있지 않은 이메일 입니다.</p>`;
                });
            } else {
                throw new Error("서버와의 통신 중 오류가 발생했습니다.");
            }
        })
        .catch(error => {
            console.error('Error:', error);
            resultDiv.innerHTML = `<p style="color: red;">오류가 발생했습니다. 나중에 다시 시도해주세요.</p>`;
        });
}
