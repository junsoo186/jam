// 선택된 값을 숨겨진 필드에 업데이트하는 함수
function updateHiddenInput(selectId, hiddenInputId) {
    const selectedValue = document.getElementById(selectId).value;
    document.getElementById(hiddenInputId).value = selectedValue;
}

// 페이지 로드 시 기본값 설정
document.addEventListener('DOMContentLoaded', function () {
    updateHiddenInput('ageSelect', 'age');
    updateHiddenInput('genreSelect', 'genreId');
    updateHiddenInput('categorySelect', 'categoryId');

    // 이미지 파일 선택 시 미리 보기를 표시하는 함수
    function displayImagePreview(inputElement, previewElementId) {
        if (inputElement.files && inputElement.files[0]) {
            const file = inputElement.files[0];

            // 파일 유효성 검사 (이미지 파일만 허용)
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 선택할 수 있습니다.');
                return;
            }

            const reader = new FileReader();
            reader.onload = function () {
                const output = document.getElementById(previewElementId);
                output.src = reader.result;
                output.style.display = 'block';

                // 기존 이미지 숨기기 (요소가 존재하는지 확인)
                const currentCoverImage = document.getElementById('currentCoverImage');
                if (currentCoverImage) {
                    currentCoverImage.style.display = 'none';
                }
            };
            reader.readAsDataURL(file);
        }
    }

    // 기존 이미지 파일 선택 시 미리 보기를 표시
    const bookCoverInput = document.getElementById('bookCover');
    if (bookCoverInput) {
        bookCoverInput.addEventListener('change', function (event) {
            displayImagePreview(event.target, 'bookCoverPreview');
        });
    }

    // 라벨 클릭 시 파일 선택 창 열기
    const bookCoverLabel = document.querySelector('label[for="bookCover"]');
    if (bookCoverLabel) {
        bookCoverLabel.onclick = function () {
            bookCoverInput.click();
        };
    }

    // 선택 가능한 이미지 목록에서 클릭 시 미리 보기 업데이트
    const selectableImages = document.querySelectorAll('.selectable-image');
    selectableImages.forEach(image => {
        image.addEventListener('click', function () {
            const preview = document.getElementById('bookCoverPreview');
            preview.src = this.src;
            preview.style.display = 'block';

            // 기존 이미지 숨기기
            const currentCoverImage = document.getElementById('currentCoverImage');
            if (currentCoverImage) {
                currentCoverImage.style.display = 'none';
            }

            // 선택된 이미지 강조 표시
            selectableImages.forEach(img => img.classList.remove('selected'));
            this.classList.add('selected');
        });
    });
});

// 다른 주소로 폼을 제출하는 함수
function submitFormToDifferentAction(actionUrl) {
    var form = document.getElementById('bookForm');
    if (form) {
        form.action = actionUrl;  // 폼의 action 속성을 변경
        form.submit();  // 폼을 제출
    }
}
