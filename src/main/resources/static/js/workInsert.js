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

    // 기존 이미지 파일 선택 시 미리 보기를 표시하는 함수
    const bookCoverInput = document.getElementById('bookCover');
    if (bookCoverInput) {
        bookCoverInput.addEventListener('change', function (event) {
            const reader = new FileReader();
            reader.onload = function () {
                const output = document.getElementById('bookCoverPreview');
                output.src = reader.result;
                output.style.display = 'block';

                // 기존 이미지 숨기기 (요소가 존재하는지 확인)
                const currentCoverImage = document.getElementById('currentCoverImage');
                if (currentCoverImage) {
                    currentCoverImage.style.display = 'none';
                }
            };
            reader.readAsDataURL(event.target.files[0]);
        });
    }

    // 라벨을 클릭하면 파일 선택 창이 열리도록 설정
    const bookCoverLabel = document.querySelector('label[for="bookCover"]');
    if (bookCoverLabel) {
        bookCoverLabel.onclick = function () {
            bookCoverInput.click();
        };
    }

    // 새로운 이미지 파일 선택 시 미리 보기를 표시하는 함수
    function previewNewImage(event) {
        var reader = new FileReader();
        reader.onload = function () {
            var output = document.getElementById('newCoverImage');
            output.src = reader.result;
            document.getElementById('newCoverPreview').style.display = 'block'; // 미리 보기 div 표시

            // 기존 이미지 숨기기 (요소가 존재하는지 확인)
            const currentCoverImage = document.getElementById('currentCoverImage');
            if (currentCoverImage) {
                currentCoverImage.style.display = 'none';
            }
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    // 선택 가능한 이미지 목록에서 클릭 시 미리 보기를 업데이트하는 함수
    const selectableImages = document.querySelectorAll('.selectable-image');
    selectableImages.forEach(image => {
        image.addEventListener('click', function () {
            // 이미지 선택 시 bookCoverPreview 이미지 업데이트
            const preview = document.getElementById('bookCoverPreview');
            preview.src = this.src;
            preview.style.display = 'block';

            // 기존 이미지 숨기기 (요소가 존재하는지 확인)
            const currentCoverImage = document.getElementById('currentCoverImage');
            if (currentCoverImage) {
                currentCoverImage.style.display = 'none';
            }

            // 선택된 이미지 표시 (선택한 이미지만 테두리 표시)
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
