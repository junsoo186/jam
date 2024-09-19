document.addEventListener('DOMContentLoaded', function () {
    const deleteModal = document.getElementById('deleteEventModal');
    const updateModal = document.getElementById('eventModal');  // 수정 모달 추가
    const closeModalButtons = document.querySelectorAll('.close');
    let eventIdToDelete = null;
    let eventIdToUpdate = null;  // 수정할 이벤트 ID를 저장

    // 삭제 버튼 클릭 시 삭제 모달 열기
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function () {
            eventIdToDelete = this.getAttribute('data-id');
            openModal(deleteModal);  // 모달을 여는 공통 함수 호출
        });
    });

    // 삭제 확인 버튼 클릭 시
    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        fetch(`/staffEvent/delete/${eventIdToDelete}`, { method: 'DELETE' })
            .then(response => {
                if (response.ok) {
                    window.location.reload();  // 삭제 후 페이지 새로고침
                } else {
                    console.error('삭제 실패:', response);
                }
            })
            .catch(error => console.error('Error:', error));
    });

    // 수정 버튼 클릭 시 수정 모달 열기
    document.querySelectorAll('.btn-edit').forEach(button => {
        button.addEventListener('click', function () {
            eventIdToUpdate = this.getAttribute('data-id');
            openUpdateModal(eventIdToUpdate);  // 수정 모달을 여는 함수 호출
        });
    });

    // 수정 모달을 여는 함수
    function openUpdateModal(eventId) {
        const modalBody = document.getElementById('modalBody');

        fetch(`/staffEvent/update/${eventId}`)
            .then(response => response.text())
            .then(html => {
                modalBody.innerHTML = html;  // JSP 내용을 모달에 삽입
                openModal(updateModal);  // 모달을 열기
                initializeEditor();  // CKEditor 초기화
            })
            .catch(error => console.error('Error loading update modal content:', error));
    }

    // CKEditor 초기화 함수
    function initializeEditor() {
        if (document.querySelector('#eventContent')) {
            ClassicEditor
                .create(document.querySelector('#eventContent'))
                .then(editor => {
                    editorInstance = editor;
                })
                .catch(error => {
                    console.error(error);
                });
        }
    }

    // 모달 열기 함수 (deleteModal, updateModal 공통)
    function openModal(modal) {
        modal.style.display = 'block';  // 모달 표시
    }

    // 모달 닫기 함수
    function closeModal(modal) {
        modal.style.display = 'none';  // 모달 닫기
    }

    // 모달 닫기 이벤트 설정
    closeModalButtons.forEach(button => {
        button.addEventListener('click', function () {
            closeModal(deleteModal);
            closeModal(updateModal);  // 수정 모달도 닫기
        });
    });

    // 모달 외부를 클릭하면 모달 닫기
    window.addEventListener('click', function (event) {
        if (event.target === deleteModal) {
            closeModal(deleteModal);
        }
        if (event.target === updateModal) {  // 수정 모달 닫기
            closeModal(updateModal);
        }
    });
});
