document.addEventListener('DOMContentLoaded', function () {
    const projectImgsInput = document.getElementById('mFile');
    const previewContainer = document.getElementById('previewContainer');
    const mainImagePreview = document.getElementById('mainImagePreview');
    const addRewardBtn = document.getElementById('addRewardBtn');
    const fundingFormElement = document.getElementById('fundingFormElement');
    const rewardContainer = document.getElementById('reward-container');
    let selectedFiles = [];
    let rewardIndex = 1;
    let editorInstance;

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

    // 커스텀 샘플 이미지 선택 버튼 클릭 시 파일 선택 트리거
    document.getElementById('customUploadBtn').addEventListener('click', function () {
        projectImgsInput.click();
    });

    // 선택된 샘플 이미지의 미리보기 처리
    projectImgsInput.addEventListener('change', function () {
        const files = projectImgsInput.files;
        if (files.length > 0) {
            Array.from(files).forEach((file, index) => {
                if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
                    selectedFiles.push(file);

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
                        previewContainer.appendChild(imgContainer);
                    };

                    reader.readAsDataURL(file);
                }
            });
        }
    });

    // 샘플 이미지 삭제 기능 + 서버로 이미지 삭제 요청
    previewContainer.addEventListener('click', function (event) {
        if (event.target.classList.contains('btn--remove')) {
            event.preventDefault();  // 기본 동작 방지 (페이지 리로드 방지)

            const imgId = event.target.dataset.imgId;
            const imgIndex = event.target.dataset.imgIndex;

            if (imgId) {
                // 서버에 이미지 삭제 요청 (기존 이미지 삭제)
                fetch(`/funding/deleteImage?imgId=${imgId}`, {
                    method: 'DELETE',
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // 이미지가 성공적으로 삭제되면 DOM에서 해당 이미지 삭제
                            event.target.parentElement.remove();
                        } else {
                            alert('이미지 삭제에 실패했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
            } else if (imgIndex) {
                // 새로 추가된 이미지 삭제 (미리보기 목록에서만 삭제)
                selectedFiles.splice(imgIndex, 1); // 선택된 파일 목록에서 제거
                event.target.parentElement.remove(); // DOM에서 삭제
            }
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

    // 리워드 삭제 처리 및 인덱스 재조정
    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('btn--remove-reward')) {
            const rewardId = event.target.dataset.rewardId;
            const rewardGroup = document.getElementById(`reward-${rewardId}`);

            if (document.querySelectorAll('.reward--group--area').length > 1) {
                rewardGroup.remove();

                // 리워드 인덱스 재조정
                const rewards = document.querySelectorAll('.reward--group--area');
                rewardIndex = 1;
                rewards.forEach((reward, index) => {
                    reward.id = `reward-${index + 1}`;
                    reward.querySelector('.btn--remove-reward').dataset.rewardId = index + 1;

                    const contentInput = reward.querySelector(`input[name^="rewards"][name$=".content"]`);
                    contentInput.id = `rewardContent-${index + 1}`;
                    contentInput.name = `rewards[${index + 1}].content`;

                    const pointInput = reward.querySelector(`input[name^="rewards"][name$=".point"]`);
                    pointInput.id = `rewardPoint-${index + 1}`;
                    pointInput.name = `rewards[${index + 1}].point`;

                    const quantityInput = reward.querySelector(`input[name^="rewards"][name$=".quantity"]`);
                    quantityInput.id = `rewardQuantity-${index + 1}`;
                    quantityInput.name = `rewards[${index + 1}].quantity`;
                });
            } else {
                alert('리워드는 최소 1개는 유지해야 합니다.');
            }
        }
    });

    // 폼 제출 시 CKEditor 데이터와 선택된 파일 전송
    fundingFormElement.addEventListener('submit', function (event) {
        event.preventDefault();

        // CKEditor 데이터 동기화
        if (editorInstance) {
            document.getElementById('editor').value = editorInstance.getData();
        }

        const submitButton = fundingFormElement.querySelector('button[type="submit"]');
        submitButton.disabled = true;
        submitButton.value = 'Submitting...';

        const formData = new FormData(fundingFormElement);

        // 선택된 샘플 이미지 추가
        const uniqueFiles = new Set();
        selectedFiles.forEach((file) => {
            if (!uniqueFiles.has(file.name)) {
                uniqueFiles.add(file.name);
                formData.append('mFile', file);
            }
        });

        // 리워드 데이터를 추가
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

        formData.append('rewards', JSON.stringify(rewardsArray));

        // 서버로 FormData 전송
        fetch('/funding/updateFunding', {
            method: 'POST',
            body: formData,
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                const projectId = data.projectId;
                if (projectId) {
                    window.location.href = `/funding/fundingDetail?projectId=${projectId}`;
                } else {
                    console.error('Project ID is undefined or null');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            })
            .finally(() => {
                submitButton.disabled = false;
                submitButton.value = 'Submit';
            });
    });

    // 종료 날짜를 오늘로부터 7일 이후로 설정
    const today = new Date();
    const minDate = new Date(today.setDate(today.getDate() + 7));

    const yyyy = minDate.getFullYear();
    const mm = String(minDate.getMonth() + 1).padStart(2, '0');
    const dd = String(minDate.getDate()).padStart(2, '0');
    const formattedDate = `${yyyy}-${mm}-${dd}`;

    document.getElementById("dateEnd").setAttribute("min", formattedDate);
});
