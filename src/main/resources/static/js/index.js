document.addEventListener('DOMContentLoaded', function() {
	const pageNumbers = document.querySelectorAll('.page--num');
	const banners = document.querySelectorAll('.visual--image');
	const textBoxes = document.querySelectorAll('.banner--text--box');
	const bannerContainer = document.getElementById('top--banner');

	const slider = document.querySelector('.slider');
	const slides = document.querySelectorAll('.slide');
	
	const prevBtn = document.querySelector('.prev--btn');
	const nextBtn = document.querySelector('.next--btn');

	const slidesToShow = 3; // 한 번에 보이는 슬라이드 수
	const slideWidth = 100 / slidesToShow; // 각 슬라이드의 너비 (100% / 보여질 슬라이드 수)

	// 각 배너에 대해 배경색을 정의합니다.
	const bannerBackgrounds = [
		'radial-gradient(#1F325C, #3A5CA8)',  // 배너 1의 배경색
		'radial-gradient(#283048, #859398)',  // 배너 2의 배경색
		'radial-gradient(#134E5E, #71B280)'   // 배너 3의 배경색
	];

	let currentIndex = 0; // 현재 배너 인덱스

	// 배너 전환 함수
	function showBanner(index) {
		// 모든 배너와 텍스트박스를 숨기고, 활성 페이지 업데이트
		banners.forEach(banner => banner.style.display = 'none');
		textBoxes.forEach(textBox => textBox.style.display = 'none');
		pageNumbers.forEach(num => num.classList.remove('active'));

		// 해당 인덱스에 맞는 배너와 텍스트박스를 보여주기
		banners[index].style.display = 'block';
		textBoxes[index].style.display = 'block';
		
		pageNumbers[index].classList.add('active');

		// 배너의 배경색을 변경
		if (bannerContainer) {
		bannerContainer.style.backgroundImage = bannerBackgrounds[index];
		}
	}

	// 자동 슬라이드 시작 함수
	function startAutoSlide() {
		setInterval(function() {
			currentIndex = (currentIndex + 1) % banners.length; // 다음 배너 인덱스 계산
			showBanner(currentIndex);
		}, 3000); // 3000ms = 3초
	}

	// 페이지 번호 클릭 이벤트 설정
	pageNumbers.forEach((pageNum, index) => {
		pageNum.addEventListener('click', function() {
			currentIndex = index; // 클릭된 페이지의 인덱스로 설정
			showBanner(currentIndex); // 해당 배너 표시
		});


	});

	// 슬라이더 스타일 업데이트
	slides.forEach(slide => {
		slide.style.flex = `0 0 ${slideWidth}%`; // 슬라이드 너비 설정
	});


	// 이전 슬라이드로 이동
/*	prevBtn.addEventListener('click', function() {
		if (currentIndex > 0) {
			currentIndex--;
			updateSlider();
		}
	});
	
	// 다음 슬라이드로 이동
	nextBtn.addEventListener('click', function() {
		if (currentIndex < slides.length - slidesToShow) {
			currentIndex++;
			updateSlider();
		}
	});*/

	// 슬라이더 위치 업데이트
	function updateSlider() {
		slider.style.transform = `translateX(-${currentIndex * slideWidth}%)`; // 슬라이더 이동
	}
	startAutoSlide(); // 자동 슬라이드 시작
});

// 카테고리별 스위칭
  document.addEventListener('DOMContentLoaded', function() {
    // 페이지가 로드되면 카테고리 목록을 가져옴
    fetchCategories();
});

let currentViewsOrder = 'DESC';  // 초기 VIEWS 정렬 순서
let currentLikesOrder = 'DESC';  // 초기 LIKES 정렬 순서
    let activeCategoryId = 3;        // 초기 카테고리 ID를 3으로 설정

    // 카테고리 목록을 가져와서 버튼 생성
    function fetchCategories() {
        fetch('/api/categories')  // 카테고리 목록을 가져오는 API 호출
            .then(response => response.json())
            .then(categories => {
                const categoryFilter = document.getElementById('categoryFilter');
                categoryFilter.innerHTML = '';  // 기존 내용을 지움

                categories.forEach(category => {
                    const button = document.createElement('button');
                    button.classList.add('category--btn');
                    button.textContent = category.categoryName;
                    button.setAttribute('data-category-id', category.categoryId);  // 카테고리 ID 설정

                    // 카테고리 버튼 클릭 시 동작
                    button.onclick = () => {
                        document.querySelectorAll('.category--btn').forEach(btn => {
                            btn.classList.remove('active');
                        });
                        button.classList.add('active');
                        activeCategoryId = category.categoryId;  // 선택된 카테고리 저장

                        // VIEWS 기준으로 초기 정렬하여 책 목록을 가져옴
                        fetchBooksByCategoryOrder('views', currentViewsOrder);
                    };

                    categoryFilter.appendChild(button);  // 카테고리 버튼을 추가

                    // 카테고리 ID가 3인 버튼을 초기 활성화
                    if (category.categoryId === 3) {
                        button.classList.add('active');
                        fetchBooksByCategoryOrder('views', currentViewsOrder);  // 기본 정렬 기준으로 책 목록을 가져옴
                    }
                });
            })
            .catch(error => console.error('Error fetching categories:', error));
    }


// 선택한 카테고리의 책 목록을 가져옴
function fetchBooksByCategoryOrder(filter, order) {
    if (!activeCategoryId) return;  // 선택된 카테고리가 없는 경우 중단

    fetch(`/api/booksByCategoryOrder?categoryId=${activeCategoryId}&filter=${filter}&order=${order}`)  // API 호출
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('categoryContent');
            bookListDiv.innerHTML = '';  // 기존 콘텐츠 지움

            if (books.length === 0) {
                bookListDiv.innerHTML = '<p>해당 카테고리에 속한 책이 없습니다.</p>';
            } else {
                books.forEach(book => {
                    const bookItem = document.createElement('div');
                    bookItem.classList.add('book--item');
                       // <img src="/images/${book.bookCoverImage}" alt="${book.title}">
                    bookItem.innerHTML = `
                        <div class="book--info">
                        	<img src="/images/bannerimg1.jpg" alt="매직 스플릿">
                            <h4>${book.title}</h4>
                            <p>저자: ${book.author}</p>
                            <p>조회수: ${book.views}</p>
                            <p>좋아요: ${book.likes}</p>
                        </div>
                    `;
                    bookListDiv.appendChild(bookItem);
                });
            }
        })
        .catch(error => console.error('Error fetching books:', error));
}

// VIEWS 정렬 버튼 토글
function toggleViewsOrder() {
    // 정렬 순서를 변경
    currentViewsOrder = currentViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    document.getElementById('viewsButton').textContent = `VIEWS (${currentViewsOrder})`;

    // 현재 선택된 카테고리로 VIEWS 기준 정렬된 책 목록을 가져옴
    fetchBooksByCategoryOrder('views', currentViewsOrder);
}

// LIKES 정렬 버튼 토글
function toggleLikesOrder() {
    // 정렬 순서를 변경
    currentLikesOrder = currentLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    document.getElementById('likesButton').textContent = `LIKES (${currentLikesOrder})`;

    // 현재 선택된 카테고리로 LIKES 기준 정렬된 책 목록을 가져옴
    fetchBooksByCategoryOrder('likes', currentLikesOrder);
}

// 페이지가 로드되면 카테고리 목록을 가져옴
document.addEventListener('DOMContentLoaded', function() {
    fetchCategories();
});


// 장르별 스위칭
document.addEventListener('DOMContentLoaded', function() {
    // 페이지 로드 시 장르 목록을 가져옴
    fetchGenres();
});

let currentFilter = 'views';  // 초기 정렬 기준: 조회수
let currentOrder = 'DESC';    // 초기 정렬 순서: 내림차순
let selectedGenreId = 1;      // 기본 선택된 장르 ID

// 장르 목록을 가져와서 버튼 생성
function fetchGenres() {
    fetch('/api/genres')  // 장르 목록을 가져오는 API 호출
        .then(response => response.json())
        .then(genres => {
            const genreFilter = document.getElementById('genreFilter');
            genreFilter.innerHTML = '';  // 기존 내용을 지움

            genres.forEach(genre => {
                const button = document.createElement('button');
                button.classList.add('genre--btn');
                button.textContent = genre.genreName;
                button.onclick = () => {
                    // 장르 버튼 클릭 시, 해당 장르의 책 목록을 현재 정렬 기준으로 가져옴
                    selectedGenreId = genre.genreId;
                    fetchBooksByGenreOrder(selectedGenreId);
                };
                genreFilter.appendChild(button);  // 장르 버튼을 추가
            });

            // 기본 장르 ID로 책 목록을 불러옴
            fetchBooksByGenreOrder(selectedGenreId);
        })
        .catch(error => console.error('Error fetching genres:', error));
}

// 선택한 장르의 책 목록을 가져옴
function fetchBooksByGenreOrder(genreId) {
    fetch(`/api/booksByGenreOrder?genreId=${genreId}&filter=${currentFilter}&order=${currentOrder}`)  // API 호출
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('genreContent');
            bookListDiv.innerHTML = '';  // 기존 콘텐츠 지움

            if (books.length === 0) {
                bookListDiv.innerHTML = '<p>해당 장르에 속한 책이 없습니다.</p>';
            } else {
                books.forEach(book => {
                    const bookItem = document.createElement('div');
                    bookItem.classList.add('book--item');
                    //    <img src="/images/${book.bookCoverImage}" alt="${book.title}">
                    bookItem.innerHTML = `
                        <div class="book--info">
                            <img src="/images/bannerimg1.jpg" alt="매직 스플릿">
                            <h4>${book.title}</h4>
                            <p>저자: ${book.author}</p>
                            <p>조회수: ${book.views}</p>
                            <p>좋아요: ${book.likes}</p>
                        </div>
                    `;
                    bookListDiv.appendChild(bookItem);
                });
            }
        })
        .catch(error => console.error('Error fetching books:', error));
}

// 조회수 정렬 버튼 클릭
function toggleViewsOrder() {
    currentFilter = 'views';  // 조회수 기준으로 설정
    currentOrder = currentOrder === 'ASC' ? 'DESC' : 'ASC';  // 정렬 순서 토글
    fetchBooksByGenreOrder(selectedGenreId);  // 선택된 장르로 책 목록을 다시 불러옴
}

// 좋아요 정렬 버튼 클릭
function toggleLikesOrder() {
    currentFilter = 'likes';  // 좋아요 기준으로 설정
    currentOrder = currentOrder === 'ASC' ? 'DESC' : 'ASC';  // 정렬 순서 토글
    fetchBooksByGenreOrder(selectedGenreId);  // 선택된 장르로 책 목록을 다시 불러옴
}

