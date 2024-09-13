function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 주소 선택 시 처리 로직 (기존과 동일)
            var addr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

document.getElementById('checkoutForm').addEventListener('submit', function (e) {
    // 결제 전 필수 필드 확인
    const postcode = document.getElementById('sample6_postcode').value;
    const basicAddress = document.getElementById('sample6_address').value;
    const detailedAddress = document.getElementById('sample6_detailAddress').value;

    if (!postcode || !basicAddress || !detailedAddress) {
        alert('주소를 입력해 주세요.');
        e.preventDefault(); // 폼 제출 중단
        return;
    }

    // 유효성 검사가 완료되면 폼이 제출됩니다.
});
