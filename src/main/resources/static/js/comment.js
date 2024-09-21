// 문서가 로드되면 실행
document.addEventListener('DOMContentLoaded', function() {
    
    // 첫 로드 시 최신순으로 댓글 로드
    loadComments('newest');

    // 댓글 폼 제출 시 새로고침을 막고 AJAX 요청으로 처리
    document.getElementById('commentForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음
        
        const formData = new FormData(this);  // 폼 데이터 수집
        const url = '/write/comment'; // 댓글 제출 URL
        
        // AJAX 요청으로 댓글 제출
        fetch(url, {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json(); // 응답을 JSON으로 변환
        })
        .then(result => {
            if (result.success) {
                // 댓글 성공 시, 최신순으로 다시 댓글을 로드
                loadComments('newest');
                this.reset(); // 폼 리셋
            } else {
                alert('댓글 작성에 실패했습니다.');
            }
        })
        .catch(error => console.error('Error:', error)); // 에러 처리
    });
});

// 댓글을 AJAX로 로드
function loadComments(sortBy, event = null) {
    if (event) {
        event.preventDefault(); // 새로고침 방지
    }

    const bookId = document.querySelector('input[name="bookId"]').value; // bookId 가져오기

    // AJAX 요청을 통해 댓글을 불러옴
    fetch(`/write/workDetail/comments?bookId=${bookId}&sortBy=${sortBy}`)
        .then(response => response.json())
        .then(comments => {
            const commentSection = document.getElementById('commentSection');
            commentSection.innerHTML = ''; // 기존 댓글 제거

            // 불러온 댓글을 화면에 출력
            comments.forEach(comment => {
                const commentElement = document.createElement('div');
                commentElement.classList.add('comment');
                commentElement.innerHTML = `
                    <div style="border-bottom: solid 1px #d1d1d1; width:800px; display:flex;">
                    <div>
                    <strong>${comment.nickName}</strong>
                    <div>
                    <p>${comment.comment}</p>
                    <div style="display:flex; width:800px;justify-content: flex-end;">
                    <p style="font-size: 10px; color: #ff4d6d; ">좋아요: ${comment.likeCount}</p>
                    </div>
                    </div>
                    `;
                commentSection.appendChild(commentElement);
            });
        })
        .catch(error => console.error('Error loading comments:', error));
}