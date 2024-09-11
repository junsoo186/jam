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


// 버튼 활성화 함수
function setActiveButton(container, activeId) {
    const buttons = container.querySelectorAll('button');
    buttons.forEach(button => {
        const buttonId = button.getAttribute('data-id');  // 버튼에 저장된 ID
        if (buttonId == activeId) {  // ID가 맞으면 active 클래스를 추가
            button.classList.add('active');
        } else {
            button.classList.remove('active');  // 다른 버튼들은 active 제거
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    fetchCategories();
    fetchGenres();

    // 초기 카테고리와 장르 선택 후 책 목록 자동 로드
    fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);  // 초기 카테고리 책 목록 로드
    fetchBooksByGenreOrder('views', currentGenreViewsOrder);        // 초기 장르 책 목록 로드
});

// 카테고리 정렬을 위한 초기 설정
let currentCategoryViewsOrder = 'DESC';
let currentCategoryLikesOrder = 'DESC';
let activeCategoryId = 3;  // 초기 카테고리 ID (기본 선택할 카테고리 ID)

// 장르 정렬을 위한 초기 설정
let currentGenreViewsOrder = 'DESC';
let currentGenreLikesOrder = 'DESC';
let selectedGenreId = 2;  // 초기 장르 ID (기본 선택할 장르 ID)

// 이미지 유효성 확인 함수 (단순화된 버전)
function getValidImagePath(imagePath, callback) {
    if (!imagePath || imagePath.trim() === '') {
        callback('/images/bannerimg1.jpg');  // 기본 이미지로 대체
        return;
    }

    // fetch로 이미지 존재 여부 확인
    fetch(imagePath, { method: 'HEAD' })
        .then(response => {
            if (response.ok) {
                callback(imagePath);  // 유효한 이미지 경로 반환
            } else {
                callback('/images/bannerimg1.jpg');  // 이미지가 없을 경우 기본 이미지로 대체
            }
        })
        .catch(() => {
            callback('/images/bannerimg1.jpg');  // 오류가 발생해도 기본 이미지로 대체
        });
}


// 카테고리 목록을 가져와서 버튼 생성
function fetchCategories() {
    fetch('/api/categories')
        .then(response => response.json())
        .then(categories => {
            const categoryFilter = document.getElementById('categoryFilter');
            categoryFilter.innerHTML = '';  // 필터 영역 초기화

            categories.forEach(category => {
                const button = document.createElement('button');
                button.classList.add('category--btn');
                button.textContent = category.categoryName;
                button.setAttribute('data-id', category.categoryId);  // 버튼에 카테고리 ID를 저장
                button.onclick = () => {
                    activeCategoryId = category.categoryId;
                    fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);
                    setActiveButton(categoryFilter, activeCategoryId);  // 클릭된 버튼에 활성화 상태 추가
                };
                categoryFilter.appendChild(button);
            });

            // 초기 카테고리 ID에 맞는 버튼에 활성화 상태 추가
            setActiveButton(categoryFilter, activeCategoryId);  // 초기 설정된 카테고리 활성화
        });
}

// 장르 목록을 가져와서 버튼 생성
function fetchGenres() {
    fetch('/api/genres')
        .then(response => response.json())
        .then(genres => {
            const genreFilter = document.getElementById('genreFilter');
            genreFilter.innerHTML = '';  // 필터 영역 초기화

            genres.forEach(genre => {
                const button = document.createElement('button');
                button.classList.add('genre--btn');
                button.textContent = genre.genreName;
                button.setAttribute('data-id', genre.genreId);  // 버튼에 장르 ID를 저장
                button.onclick = () => {
                    selectedGenreId = genre.genreId;
                    fetchBooksByGenreOrder('views', currentGenreViewsOrder);
                    setActiveButton(genreFilter, selectedGenreId);  // 클릭된 버튼에 활성화 상태 추가
                };
                genreFilter.appendChild(button);
            });

            // 초기 장르 ID에 맞는 버튼에 활성화 상태 추가
            setActiveButton(genreFilter, selectedGenreId);  // 초기 설정된 장르 활성화
        });
}

// 책 목록을 카테고리별로 가져와서 렌더링
function fetchBooksByCategoryOrder(filter, order) {
    if (!activeCategoryId) return;

    fetch(`/api/booksByCategoryOrder?categoryId=${activeCategoryId}&filter=${filter}&order=${order}`)
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('categoryContent');
            bookListDiv.innerHTML = '';

            if (books.length === 0) {
                bookListDiv.innerHTML = '<p>해당 카테고리에 속한 책이 없습니다.</p>';
            } else {
                books.forEach(book => {
                                      if (book.bookCoverImage) {
                        getValidImagePath(book.bookCoverImage, (validImagePath) => {
                            if (validImagePath !== '/images/bannerimg1.jpg') {
                                const bookItem = document.createElement('div');
                                bookItem.classList.add('book--item');

                                bookItem.innerHTML = `
                                    <div class="book--info">
                                        <img src="${validImagePath}" alt="${book.title}" id="category-book-cover-${book.bookId}">
                                        <h4>${book.title}</h4>
                                        <p>저자: ${book.author}</p>
                                        <p>조회수: ${book.views}</p>
                                        <p>좋아요: ${book.likes}</p>
                                    </div>
                                `;
                                bookListDiv.appendChild(bookItem);
                            }
                        });
                    }
                });
            }
        })
        .catch(error => console.error('Error fetching books:', error));
}

// 장르별 책 목록을 가져와서 렌더링
function fetchBooksByGenreOrder(filter, order) {
    fetch(`/api/booksByGenreOrder?genreId=${selectedGenreId}&filter=${filter}&order=${order}`)
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('genreContent');
            bookListDiv.innerHTML = '';  // 책 목록 초기화

            if (books.length === 0) {
                bookListDiv.innerHTML = '<p>해당 장르에 속한 책이 없습니다.</p>';
            } else {
                books.forEach(book => {
                                                        if (book.bookCoverImage) {
                        getValidImagePath(book.bookCoverImage, (validImagePath) => {
                            if (validImagePath !== '/images/bannerimg1.jpg') {
                                const bookItem = document.createElement('div');
                                bookItem.classList.add('book--item');

                                bookItem.innerHTML = `
                                    <div class="book--info">
                                        <img src="${validImagePath}" alt="${book.title}" id="category-book-cover-${book.bookId}">
                                        <h4>${book.title}</h4>
                                        <p>저자: ${book.author}</p>
                                        <p>조회수: ${book.views}</p>
                                        <p>좋아요: ${book.likes}</p>
                                    </div>
                                `;
                                bookListDiv.appendChild(bookItem);
                            }
                        });
                    }
                });
            }
        });
}

// 조회수와 좋아요 정렬 버튼
function toggleCategoryViewsOrder() {
    currentCategoryViewsOrder = currentCategoryViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);
}

function toggleCategoryLikesOrder() {
    currentCategoryLikesOrder = currentCategoryLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByCategoryOrder('likes', currentCategoryLikesOrder);
}

function toggleGenreViewsOrder() {
    currentGenreViewsOrder = currentGenreViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByGenreOrder('views', currentGenreViewsOrder);
}

function toggleGenreLikesOrder() {
    currentGenreLikesOrder = currentGenreLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByGenreOrder('likes', currentGenreLikesOrder);
}

