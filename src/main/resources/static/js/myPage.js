
  var principalEmail = <c:out value='${principal != null ? principal.email : ""}' />;
  
  function toggleButton(selected) {
      const supporterButton = document.getElementById('supporterButton');
      const makerButton = document.getElementById('makerButton');

      if (selected === 'supporter') {
          supporterButton.classList.add('active');
          makerButton.classList.remove('active');
                              
          // 선택된 상태를 로컬 스토리지에 저장
          localStorage.setItem('selectedButton', 'supporter');
          
      } else {
          makerButton.classList.add('active');
          supporterButton.classList.remove('active');
          
       	// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
          window.location.href = '/write/workList'; // 컨트롤러 경로로 리다이렉트
          
          // 선택된 상태를 로컬 스토리지에 저장
          localStorage.setItem('selectedButton', 'maker');
          
          
      }
  }
  
// 페이지 로드 시 로컬 스토리지에서 선택된 버튼 상태를 불러와 유지
  window.onload = function() {
      const selectedButton = localStorage.getItem('selectedButton');
      const supporterButton = document.getElementById('supporterButton');
      const makerButton = document.getElementById('makerButton');
      
      // 로그인된 사용자의 email이 있을 경우 "유저" 버튼을 활성화
      if (!selectedButton && principalEmail !== "") {
          supporterButton.classList.add('active');
          makerButton.classList.remove('active');
          sessionStorage.setItem('selectedButton', 'supporter'); // 기본값으로 저장
      } else if (selectedButton === 'supporter') {
          supporterButton.classList.add('active');
          makerButton.classList.remove('active');
      } else if (selectedButton === 'maker') {
          makerButton.classList.add('active');
          supporterButton.classList.remove('active');
      }
  }