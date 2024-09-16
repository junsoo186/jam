// 페이지가 로드될 때 이벤트 상태를 자동으로 확인하고 결제 버튼의 이벤트 핸들러를 설정함
document.addEventListener('DOMContentLoaded', async function() {
    console.log("DOMContentLoaded 이벤트 호출됨");
    await checkEventStatus();  // 이벤트 상태를 먼저 확인한 후 버튼 설정
});

// 이벤트 토글 버튼을 클릭했을 때 상태를 변경하는 함수
document.getElementById("toggle-event-button").addEventListener("click", function() {
    fetch("/pay/toggleEvent", { method: 'POST' })  // /pay/toggleEvent API에 POST 요청을 보냄
        .then(response => response.text())  // 서버로부터 텍스트 응답을 받음
        .then(message => {
            alert(message);  // 이벤트 상태 변경 메시지를 알림으로 표시
            checkEventStatus();  // 상태를 다시 확인해서 화면을 업데이트함
        });
});

// 페이지가 로드되면 이벤트 상태를 확인하는 함수
async function checkEventStatus() {
    console.log("checkEventStatus 함수 호출됨");
    
    // fetch 호출 성공 여부 확인
    const response = await fetch("/pay/eventStatus");  // /pay/eventStatus API에 GET 요청을 보냄
    const isEventActive = await response.json();  // JSON 응답을 받음
    console.log("이벤트 활성 상태: ", isEventActive); // 이벤트 상태를 콘솔에 출력

    // 요소가 정상적으로 가져와지는지 확인
    const paymentButton1 = document.getElementById('payment-button-1000');
    const paymentButton2 = document.getElementById('payment-button-2000');
    const paymentButton3 = document.getElementById('payment-button-3000');
    const paymentButton4 = document.getElementById('payment-button-4000');
    const paymentButton5 = document.getElementById('payment-button-5000');

    if (!paymentButton1 || !paymentButton2 || !paymentButton3 || !paymentButton4 || !paymentButton5) {
        console.error("결제 버튼을 찾을 수 없습니다.");
        return;
    }

    // 이벤트가 활성화된 경우
    if (isEventActive) {
		// 이벤트 활성화 메시지 표시
        document.getElementById('event-message').innerText = "이벤트 중! 추가 할인이 적용됩니다.";  
       
       	// 이벤트 시 추가 코인 수량 적용
        document.getElementById('coin-1000').innerText = "1100코인";  
        document.getElementById('coin-2000').innerText = "2100코인"; 
        document.getElementById('coin-3000').innerText = "3100코인";  
        document.getElementById('coin-4000').innerText = "4100코인"; 
        document.getElementById('coin-5000').innerText = "5100코인";  

        // 버튼 클릭 시 동적으로 변경된 값으로 결제 요청
        paymentButton1.onclick = function() { 
            console.log("1100 코인 결제 요청");  // 로그 추가
            requestPayment(1000, '1100'); 
        };
        paymentButton2.onclick = function() { 
            console.log("2100 코인 결제 요청");  // 로그 추가
            requestPayment(2000, '2100'); 
        };
        paymentButton3.onclick = function() { 
            console.log("3100 코인 결제 요청");  // 로그 추가
            requestPayment(3000, '3100'); 
        };
        paymentButton4.onclick = function() { 
            console.log("4100 코인 결제 요청");  // 로그 추가
            requestPayment(4000, '4100'); 
        };
        paymentButton5.onclick = function() { 
            console.log("5100 코인 결제 요청");  // 로그 추가
            requestPayment(5000, '5100'); 
        };
        
    } else { // 이벤트가 비활성화된 경우
    
         // 일반 결제 메시지 표시
        document.getElementById('event-message').innerText = "일반 결제입니다."; 
        
        // 기본 코인 수량
        document.getElementById('coin-1000').innerText = "1000코인";  
        document.getElementById('coin-2000').innerText = "2000코인";  
        document.getElementById('coin-3000').innerText = "3000코인";  
        document.getElementById('coin-4000').innerText = "4000코인";  
        document.getElementById('coin-5000').innerText = "5000코인";  

        // 버튼 클릭 시 기본 값으로 결제 요청
        paymentButton1.onclick = function() { 
            console.log("1000 코인 결제 요청");  // 로그 추가
            requestPayment(1000, '1000'); 
        };
        paymentButton2.onclick = function() { 
            console.log("2000 코인 결제 요청");  // 로그 추가
            requestPayment(2000, '2000'); 
        };
        paymentButton3.onclick = function() { 
            console.log("3000 코인 결제 요청");  // 로그 추가
            requestPayment(3000, '3000'); 
        };
        paymentButton4.onclick = function() { 
            console.log("4000 코인 결제 요청");  // 로그 추가
            requestPayment(4000, '4000'); 
        };
        paymentButton5.onclick = function() { 
            console.log("5000 코인 결제 요청");  // 로그 추가
            requestPayment(5000, '5000'); 
        };
    }
}