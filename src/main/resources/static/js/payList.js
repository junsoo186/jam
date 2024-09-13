/**
 * 
 */

/*
 document.addEventListener('DOMContentLoaded', function()  {
	
	document.getElementById('button').addEventListener('click', function() {
		
		 button.disabled = true;
		
	});
*/	
// 부모 창에서 실행되는 함수: 팝업 창에서 호출
function submitRefundForm(paymentKey) {
    document.getElementById('refundForm_' + paymentKey).submit();
}

function showAlertAndOpenTerms(paymentKey, refundAmount) {
    // 약관 창을 새 탭으로 열기
    window.open('/pay/termsAndConditions?paymentKey=' + paymentKey, '_blank', 'width=500,height=500');
}

// 환불 버튼을 N초 후에 숨기는 함수 (12초로 설정됨)
function hideRefundButtonAfterTimeout(paymentKey, createdAt, hideAfterMilliseconds) {
    const createdTime = new Date(createdAt); // 결제 날짜를 자바스크립트 Date 객체로 변환
    const currentTime = new Date(); // 현재 시간
    const diffInMilliseconds = currentTime - createdTime; // 현재 시간과 결제 시간의 차이를 밀리초로 계산

    const remainingTime = hideAfterMilliseconds - diffInMilliseconds; // 설정된 시간에서 남은 시간을 계산

    if (remainingTime > 0) {
        // 남은 시간이 0보다 크면, 해당 시간만큼 기다렸다가 버튼을 숨김
        setTimeout(function () {
            const button = document.getElementById('refundButton_' + paymentKey);
            if (button) {
                button.style.display = 'none';
            }
        }, remainingTime);
    } else {
        // 이미 시간이 지났다면 즉시 버튼을 숨김
        const button = document.getElementById('refundButton_' + paymentKey);
        if (button) {
            button.style.display = 'none';
        }
    }
}

	
