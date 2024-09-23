function toggleHeart(bookId) {
    const heartContainer = document.querySelector('.heart-container');
    
    // 서버로 POST 요청 보내기
    fetch('/like', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ bookId: bookId })
    })
    .then(response => {
        if (response.ok) {
            heartContainer.classList.toggle('active'); 
        } else {
            console.error('Failed to toggle like');
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}