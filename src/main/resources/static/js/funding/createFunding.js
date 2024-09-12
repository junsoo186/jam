document.addEventListener('DOMContentLoaded', function () {
    const projectImgsInput = document.getElementById('mFile');
    const previewContainer = document.getElementById('previewContainer');
    const addRewardBtn = document.getElementById('addRewardBtn');
    const fundingFormElement = document.getElementById('fundingFormElement');
    const rewardContainer = document.getElementById('reward-container');
    const dateEndInput = document.getElementById('dateEnd');
    let selectedFiles = []; // 선택된 파일을 저장할 배열
    let rewardIndex = 1;  // 리워드 인덱스를 1로 시작 (0은 이미 사용 중)
    let editorInstance;  // CKEditor 인스턴스 저장

    // 커스텀 샘플 이미지 선택 버튼 클릭 시 파일 선택 트리거
    document.getElementById('customUploadBtn').addEventListener('click', function () {
        projectImgsInput.click();
    });

    // 샘플 이미지 선택 후 미리보기 및 mFile 배열에 추가 처리
    projectImgsInput.addEventListener('change', function () {
        const files = projectImgsInput.files;

        if (files.length > 0) {
            // 새로 선택한 파일들이 중복되지 않도록 추가
            Array.from(files).forEach((file, index) => {
                if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
                    selectedFiles.push(file);  // 중복되지 않는 파일만 배열에 추가

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const imgContainer = document.createElement('div');
                        imgContainer.classList.add('img-container');
                        imgContainer.style.display = 'inline-block';
                        imgContainer.style.margin = '10px';

                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.style.maxWidth = '100px';
                        img.style.maxHeight = '100px';

                        const removeImgBtn = document.createElement('button');
                        removeImgBtn.textContent = 'X';
                        removeImgBtn.classList.add('btn--remove');
                        removeImgBtn.dataset.imgIndex = selectedFiles.length - 1;

                        imgContainer.appendChild(img);
                        imgContainer.appendChild(removeImgBtn);
                        previewContainer.appendChild(imgContainer); // 이전 이미지 유지하면서 새로운 이미지 추가
                    };

                    reader.readAsDataURL(file);
                }
            });
        }
    });

    // 샘플 이미지 삭제 버튼 처리
    previewContainer.addEventListener('click', function (event) {
        if (event.target.classList.contains('btn--remove')) {
            const imgIndex = event.target.dataset.imgIndex;
            selectedFiles.splice(imgIndex, 1);  // 해당 이미지를 배열에서 제거
            event.target.parentElement.remove();  // 미리보기에서 삭제
        }
    });

    // 리워드 추가 버튼 처리
    addRewardBtn.addEventListener('click', function () {
        const newRewardDiv = document.createElement('div');
        newRewardDiv.className = 'reward--group--area';
        newRewardDiv.id = `reward-${rewardIndex}`;
        newRewardDiv.innerHTML = `
            <div class="form--group--area">
                <label for="rewardContent-${rewardIndex}" class="form--label--area">리워드 이름:</label>
                <input type="text" id="rewardContent-${rewardIndex}" name="rewards[${rewardIndex}].content" class="form--input--text" placeholder="리워드 내용을 입력하세요" required>
            </div>
            <div class="form--group--area">
                <label for="rewardPoint-${rewardIndex}" class="form--label--area">리워드 금액 (원):</label>
                <input type="number" id="rewardPoint-${rewardIndex}" name="rewards[${rewardIndex}].point" class="form--input--number" min="1" step="1000" placeholder="리워드 금액을 입력하세요" required>
            </div>
            <div class="form--group--area">
                <label for="rewardQuantity-${rewardIndex}" class="form--label--area">리워드 수량:</label>
                <input type="number" id="rewardQuantity-${rewardIndex}" name="rewards[${rewardIndex}].quantity" class="form--input--number" min="1" step="1" placeholder="리워드 수량을 입력하세요" required>
            </div>
            <button type="button" class="btn--remove-reward" data-reward-id="${rewardIndex}">X</button>
        `;
        rewardContainer.appendChild(newRewardDiv);
        rewardIndex++;
    });

    // 리워드 삭제 버튼 처리 (최소 1개는 남기기)
    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('btn--remove-reward')) {
            const rewardId = event.target.dataset.rewardId;
            const rewardGroup = document.getElementById(`reward-${rewardId}`);

            if (document.querySelectorAll('.reward--group--area').length > 1) {
                rewardGroup.remove();  // 리워드 삭제
            } else {
                alert('리워드는 최소 1개는 유지해야 합니다.');
            }
        }
    });

    // 폼 제출 시, 선택된 파일들과 리워드 데이터를 함께 전송
    fundingFormElement.addEventListener('submit', function (event) {
        event.preventDefault();

        // CKEditor의 내용을 <textarea>에 동기화
        if (editorInstance) {
            document.getElementById('editor').value = editorInstance.getData();
        }

        // 중복 제출 방지 및 로딩 상태 표시
        const submitButton = fundingFormElement.querySelector('button[type="submit"]');
        submitButton.disabled = true;
        submitButton.value = 'Submitting...';  // 제출 중 상태 표시

        const formData = new FormData(fundingFormElement);

        // 선택된 샘플 이미지를 FormData에 추가 (중복 확인 후 추가)
        const uniqueFiles = new Set(); // 중복 방지를 위한 Set
        selectedFiles.forEach((file) => {
            if (!uniqueFiles.has(file.name)) {  // 파일명이 중복되지 않으면 추가
                uniqueFiles.add(file.name);  // 중복 방지를 위해 파일명 저장
                formData.append('mFile', file);  // 파일 추가
            }
        });

        // 리워드 데이터를 배열에 저장
        const rewardsArray = [];
        const rewards = document.querySelectorAll('.reward--group--area');
        rewards.forEach((reward) => {
            const rewardContentInput = reward.querySelector(`input[name^="rewards"][name$=".content"]`);
            const rewardPointInput = reward.querySelector(`input[name^="rewards"][name$=".point"]`);
            const rewardQuantityInput = reward.querySelector(`input[name^="rewards"][name$=".quantity"]`);

            if (rewardContentInput && rewardPointInput && rewardQuantityInput) {
                rewardsArray.push({
                    content: rewardContentInput.value,
                    point: rewardPointInput.value,
                    quantity: rewardQuantityInput.value
                });
            }
        });

        // 리워드 데이터를 JSON으로 직렬화해서 FormData에 추가
        formData.append('rewards', JSON.stringify(rewardsArray));  // 리워드를 JSON 문자열로 변환해 추가

        // 서버로 FormData 전송
        fetch('/funding/createFunding', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();  // JSON으로 응답을 파싱
            })
            .then(data => {
                console.log('Returned Data:', data);  // 서버에서 받은 데이터 출력
                const projectId = data.projectId;  // 서버에서 반환된 projectId 확인
                console.log('Project ID:', projectId);

                if (projectId) {
                    window.location.href = `/funding/fundingDetail?projectId=${projectId}`;  // projectId를 URL에 포함하여 이동
                } else {
                    console.error('Project ID is undefined or null');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            })
            .finally(() => {
                // 제출 버튼 복원
                submitButton.disabled = false;
                submitButton.value = 'Submit';
            });
    });

    // 오늘 날짜로부터 7일 이후로 설정하는 기능
    const today = new Date();
    const minDate = new Date(today.setDate(today.getDate() + 7));

    const yyyy = minDate.getFullYear();
    const mm = String(minDate.getMonth() + 1).padStart(2, '0');
    const dd = String(minDate.getDate()).padStart(2, '0');
    const formattedDate = `${yyyy}-${mm}-${dd}`;

    dateEndInput.value = formattedDate;

    document.getElementById("dateEnd").setAttribute("min", formattedDate);

    // CKEditor 5 초기화
    ClassicEditor
        .create(document.querySelector('#editor'), {
            ckfinder: {
                uploadUrl: '/funding/image'
            }
        })
        .then(editor => {
            editorInstance = editor;
        })
        .catch(error => {
            console.error(error);
        });
});
