document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM fully loaded and parsed");

    // URL에서 검색어 추출
    const urlParams = new URLSearchParams(window.location.search);
    const query = urlParams.get('q'); // URL 파라미터에서 검색어 추출

    if (query) {
        fetchSearchResults(query); // 검색어가 있으면 검색 함수 호출
    } else {
        console.error("Query parameter is missing in URL.");
    }

    // 검색 결과를 가져와서 페이지에 출력하는 함수
    function fetchSearchResults(query) {
        const resultsList = document.getElementById('searchPageResults');
        
        if (!resultsList) {
            console.error('Search results element not found');
            return;
        }

        console.log("Fetching search results for query:", query); // 디버깅용 로그

        // 검색 요청 보내기
        fetch(`/search-page?q=${encodeURIComponent(query)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log("Search results received:", data); // 받은 데이터 확인 (디버깅용)

                // 검색 결과 초기화
                resultsList.innerHTML = '';

                // 검색 결과가 없으면 메시지 표시
                if (data.length === 0) {
                    const noResultsMessage = document.createElement('div');
                    noResultsMessage.textContent = '결과가 없습니다.';
                    noResultsMessage.style.textAlign = 'center';
                    noResultsMessage.style.padding = '10px';
                    resultsList.appendChild(noResultsMessage);
                    return;
                }

                // 검색 결과 리스트를 동적으로 생성하여 페이지에 추가
                data.forEach((book, index) => {
                    const listItem = document.createElement('div');
                    listItem.classList.add('book--item');
                    listItem.setAttribute('data-work-id', book.bookId); // bookId를 data 속성으로 설정

                    // 나이 제한에 따른 추가 정보 설정
                    let additionalInfo = '';
                    if (book.age === '15') {
                        additionalInfo = '<div class="age--mark" style="background-color: blue; color: white;">15</div>';
                    } else if (book.age === '19') {
                        additionalInfo = '<div class="age--mark" style="background-color: red; color: white;">19</div>';
                    }

                    // 각 책의 내용을 생성
                    listItem.innerHTML = `
                    <div class="book--info">
                        <div class="book--cover">
                            <img src="${book.bookCoverImage || '/images/default_cover.jpg'}" alt="${book.title}">
                            ${additionalInfo}
                        </div>
                        <div class="book--text">
                            <div class="text--number">${index + 1}</div>
                            <div>
                                <p class="text--title">${book.title}</p>
                                <p class="text--writer">저자: ${book.author}</p>
                                <p class="text--view">조회수: ${book.views}</p>
                                <p class="text--view">좋아요: ${book.likes}</p>
                            </div>
                        </div>
                    </div>
                `;
                    resultsList.appendChild(listItem); // 리스트에 항목 추가

                    // 클릭 이벤트 추가
                    listItem.addEventListener('click', function () {
                        const bookId = this.getAttribute('data-work-id'); // bookId 가져오기
                        window.location.href = `/write/workDetail?bookId=${bookId}`; // 페이지 이동
                    });
                });
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
                resultsList.innerHTML = ''; // 에러 발생 시 결과 초기화
            });
    }
});
