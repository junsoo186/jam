document.addEventListener("DOMContentLoaded", function() {
    const projectImgsInput = document.getElementById('projectImgs');
    const previewContainer = document.getElementById('previewContainer');
    const addRewardBtn = document.getElementById('addRewardBtn');
    const fundingFormElement = document.getElementById('fundingFormElement');  // 수정된 부분
    const rewardContainer = document.getElementById('reward-container');

    // 커스텀 버튼 클릭 시 파일 선택 트리거
    customUploadBtn.addEventListener('click', function() {
        projectImgsInput.click();  // 숨겨진 파일 입력 요소 클릭
    });

    // 이미지 미리보기 기능
    projectImgsInput.addEventListener('change', function() {
        const files = projectImgsInput.files;

        if (files.length > 0) {
            Array.from(files).forEach(file => {
                const reader = new FileReader();

                reader.onload = function(e) {
                    // 이미지 컨테이너 생성
                    const imgContainer = document.createElement('div');
                    imgContainer.classList.add('img-container'); // 스타일 적용을 위한 클래스 추가
                    imgContainer.style.display = 'inline-block';
                    imgContainer.style.margin = '10px';

                    // 이미지 요소 생성
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '200px';

                    // 이미지 컨테이너에 이미지 추가
                    imgContainer.appendChild(img);

                    // 미리보기 컨테이너에 이미지 컨테이너 추가
                    previewContainer.appendChild(imgContainer);
                }

                reader.readAsDataURL(file);
            });
        }
    });

    // 리워드 추가 버튼 클릭 이벤트
    if (addRewardBtn) {
        addRewardBtn.addEventListener('click', addReward);
    }

    // 리워드 추가 함수
    function addReward() {
        const newRewardDiv = document.createElement('div');
        newRewardDiv.className = 'reward-group';
        newRewardDiv.innerHTML = `
        <div class="form-group">
            <label for="rewardContent-${rewardIndex}">리워드 이름:</label>
            <input type="text" id="rewardContent-${rewardIndex}" name="rewards[${rewardIndex}].content" placeholder="리워드 이름을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="rewardPoint-${rewardIndex}">리워드 금액 (원):</label>
            <input type="number" id="rewardPoint-${rewardIndex}" name="rewards[${rewardIndex}].point" min="1" step="1000" placeholder="리워드 금액을 입력하세요" required>
        </div>
        `;
        rewardContainer.appendChild(newRewardDiv);
        rewardIndex++;  // 인덱스 증가
    }

    // 폼 제출 시 리워드 데이터를 폼에 동적으로 추가
    fundingFormElement.addEventListener('submit', function(event) {  // 수정된 부분
        // 폼 제출 전에 외부 리워드 데이터를 폼에 추가
        const rewards = document.querySelectorAll('.reward-group');
        rewards.forEach((reward, index) => {
            const rewardContent = reward.querySelector(`input[name="rewards[${index}].content"]`).value;
            const rewardPrice = reward.querySelector(`input[name="rewards[${index}].price"]`).value;

            // 숨겨진 input 요소로 동적으로 추가
            const hiddenContent = document.createElement('input');
            hiddenContent.type = 'hidden';
            hiddenContent.name = `rewards[${index}].content`;
            hiddenContent.value = rewardContent;

            const hiddenPrice = document.createElement('input');
            hiddenPrice.type = 'hidden';
            hiddenPrice.name = `rewards[${index}].price`;
            hiddenPrice.value = rewardPrice;

            fundingFormElement.appendChild(hiddenContent);
            fundingFormElement.appendChild(hiddenPrice);
        });
    });
});
