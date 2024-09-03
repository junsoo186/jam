// 선택된 값을 숨겨진 필드에 업데이트하는 함수
function updateHiddenInput(selectId, hiddenInputId) {
    const selectElement = document.getElementById(selectId);
    const hiddenInputElement = document.getElementById(hiddenInputId);
    if (selectElement && hiddenInputElement) {
        hiddenInputElement.value = selectElement.value;
    }
}

// 페이지 로드 시 기본값 설정
document.addEventListener('DOMContentLoaded', function() {
    updateHiddenInput('ageSelect', 'age');
    updateHiddenInput('genreSelect', 'genreId');
    updateHiddenInput('categorySelect', 'categoryId');
});

// 다른 주소로 폼을 제출하는 함수
function submitFormToDifferentAction(actionUrl) {
    const form = document.getElementById('bookForm');
    if (form) {
        form.action = actionUrl;
        form.submit();
    }
}

// 기존 이미지 파일 선택 시 미리 보기를 표시하는 함수
document.getElementById('bookCover')?.addEventListener('change', function(event) {
    const reader = new FileReader();
    reader.onload = function() {
        const output = document.getElementById('bookCoverPreview');
        if (output) {
            output.src = reader.result;
            output.style.display = 'block';
        }

        const currentCoverImage = document.getElementById('currentCoverImage');
        if (currentCoverImage) {
            currentCoverImage.style.display = 'none';
        }
    };
    reader.readAsDataURL(event.target.files[0]);
});

// 라벨을 클릭하면 파일 선택 창이 열리도록 설정
document.querySelector('label[for="bookCover"]')?.addEventListener('click', function() {
    const bookCoverInput = document.getElementById('bookCover');
    if (bookCoverInput) {
        bookCoverInput.click();
    }
});

// 새로운 이미지 파일 선택 시 미리 보기를 표시하는 함수
function previewNewImage(event) {
    const reader = new FileReader();
    reader.onload = function() {
        const output = document.getElementById('newCoverImage');
        if (output) {
            output.src = reader.result;
            document.getElementById('newCoverPreview').style.display = 'block';
        }

        const currentCoverImage = document.getElementById('currentCoverImage');
        if (currentCoverImage) {
            currentCoverImage.style.display = 'none';
        }
    };
    reader.readAsDataURL(event.target.files[0]);
}

// 선택 가능한 이미지 목록에서 클릭 시 미리 보기를 업데이트하는 함수
const selectableImages = document.querySelectorAll('.image');
selectableImages.forEach(image => {
    image.addEventListener('click', function() {
        const preview = document.getElementById('bookCoverPreview');
        if (preview) {
            preview.src = this.querySelector('img').src;
            preview.style.display = 'block';
        }

        const currentCoverImage = document.getElementById('currentCoverImage');
        if (currentCoverImage) {
            currentCoverImage.style.display = 'none';
        }

        selectableImages.forEach(img => img.classList.remove('selected'));
        this.classList.add('selected');
    });
});
