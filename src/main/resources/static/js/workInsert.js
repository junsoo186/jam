
     // 선택된 값을 숨겨진 필드에 업데이트하는 함수
    function updateHiddenInput(selectId, hiddenInputId) {
        const selectedValue = document.getElementById(selectId).value;
        document.getElementById(hiddenInputId).value = selectedValue;
    }

    // 페이지 로드 시 기본값 설정
    document.addEventListener('DOMContentLoaded', function() {
        updateHiddenInput('ageSelect', 'age');
        updateHiddenInput('genreSelect', 'genreId');
        updateHiddenInput('categorySelect', 'categoryId');
    });
    
        // 다른 주소로 폼을 제출하는 함수
        function submitFormToDifferentAction(actionUrl) {
            var form = document.getElementById('bookForm');
            form.action = actionUrl;  // 폼의 action 속성을 변경
            form.submit();  // 폼을 제출
        }