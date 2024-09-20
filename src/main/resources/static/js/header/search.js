function searchBooks(query) {
    const resultsList = document.getElementById('searchResults');
    if (query.length === 0) {
        resultsList.innerHTML = '';
        resultsList.style.display = 'none';
        return;
    }
    if (query.length >= 2) {
        fetch(`/search?q=${encodeURIComponent(query)}`)
            .then(response => response.json())
            .then(data => {
                resultsList.innerHTML = '';
                resultsList.style.display = 'block';
                data.forEach(book => {
                    const listItem = document.createElement('li');
                    const tagText = book.tagNames ? `[Tags: ${book.tagNames}]` : '';
                    const bookImage = document.createElement('img');
                    bookImage.src = book.bookCoverImage || '/images/default_cover.jpg';
                    const textContainer = document.createElement('div');
                    textContainer.textContent = `${book.title} by ${book.author} ${tagText}`;
                    listItem.appendChild(bookImage);
                    listItem.appendChild(textContainer);
                    resultsList.appendChild(listItem);
                });
            })
            .catch(error => {
                console.error('Error:', error);
                resultsList.innerHTML = '';
                resultsList.style.display = 'none';
            });
    } else {
        resultsList.innerHTML = '';
        resultsList.style.display = 'none';
    }
}
