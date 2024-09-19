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
        // banners와 textBoxes가 비어있을 경우 함수 종료
        if (banners.length === 0 || textBoxes.length === 0 || pageNumbers.length === 0) {
            console.error('배너 또는 텍스트 박스가 없습니다.');
            return;
        }

        // 모든 배너와 텍스트박스를 숨기고, 활성 페이지 업데이트
        banners.forEach(banner => banner.style.display = 'none');
        textBoxes.forEach(textBox => textBox.style.display = 'none');
        pageNumbers.forEach(num => num.classList.remove('active'));

        // 인덱스가 banners 배열 길이를 넘지 않는지 확인
        if (index >= 0 && index < banners.length) {
            // 해당 인덱스에 맞는 배너와 텍스트박스를 보여주기
            banners[index].style.display = 'block';
            textBoxes[index].style.display = 'block';
            pageNumbers[index].classList.add('active');

            // 배너의 배경색을 변경
            if (bannerContainer) {
                bannerContainer.style.backgroundImage = bannerBackgrounds[index];
            }
        } else {
            console.error('유효하지 않은 배너 인덱스입니다.');
        }
    }

    // 자동 슬라이드 시작 함수
    function startAutoSlide() {
        if (banners.length === 0) return; // 배너가 없는 경우 슬라이드 동작 중단
        setInterval(function() {
            currentIndex = (currentIndex + 1) % banners.length; // 다음 배너 인덱스 계산
            showBanner(currentIndex);
        }, 3000); // 3000ms = 3초
    }

    startAutoSlide(); // 슬라이드 자동 시작

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
// 이전 슬라이드 버튼 이벤트
if (prevBtn) {
    prevBtn.addEventListener('click', function() {
        if (currentIndex > 0) {
            currentIndex--;
            updateSlider();
        }
    });
}

// 다음 슬라이드 버튼 이벤트
if (nextBtn) {
    nextBtn.addEventListener('click', function() {
        if (currentIndex < slides.length - slidesToShow) {
            currentIndex++;
            updateSlider();
        }
    });
}

	// 슬라이더 위치 업데이트
	function updateSlider() {
		slider.style.transform = `translateX(-${currentIndex * slideWidth}%)`; // 슬라이더 이동
	}
	startAutoSlide(); // 자동 슬라이드 시작
});
// 카테고리 정렬을 위한 초기 설정
let currentCategoryViewsOrder = 'DESC';
let currentCategoryLikesOrder = 'DESC';
let activeCategoryId = 3;  // 초기 카테고리 ID (기본 선택할 카테고리 ID)

// 장르 정렬을 위한 초기 설정
let currentGenreViewsOrder = 'DESC';
let currentGenreLikesOrder = 'DESC';
let selectedGenreId = 2;  // 초기 장르 ID (기본 선택할 장르 ID)

// 요일별 정렬을 위한 초기 설정
let currentDayViewsOrder = 'DESC';
let currentDayLikesOrder = 'DESC';
let activeSerialDay = '월요일';  // 초기 선택할 요일

// 이미지 경로를 확인하는 함수 (Promise를 반환)
function getValidImagePath(imagePath) {
    return new Promise((resolve) => {
        if (!imagePath || imagePath.trim() === '' || imagePath === '/images/') {
            resolve('/images/banner/bannerimg1.jpg');
            return;
        }

        fetch(imagePath, { method: 'HEAD' })
            .then(response => {
                if (response.ok) {
                    resolve(imagePath);
                } else {
                    resolve('/images/banner/bannerimg1.jpg');
                }
            })
            .catch(() => {
                resolve('/images/banner/bannerimg1.jpg');
            });
    });
}

// 책 목록을 정렬하는 함수 (조회수 또는 좋아요 기준)
function sortBooks(books, sortBy, order) {
    return books.sort((a, b) => {
        let valueA = sortBy === 'views' ? a.views : a.likes;
        let valueB = sortBy === 'views' ? b.views : b.likes;
        return order === 'ASC' ? valueA - valueB : valueB - valueA;
    });
}

// 버튼 활성화 함수
function setActiveButton(container, activeId) {
    const buttons = container.querySelectorAll('button');
    buttons.forEach(button => {
        const buttonId = button.getAttribute('data-id') || button.getAttribute('data-day');  // 버튼에 저장된 ID 또는 요일
        if (buttonId == activeId) {
            button.classList.add('active');
            console.log('Active button:', button);
        } else {
            button.classList.remove('active');
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // 카테고리, 장르, 요일 데이터를 모두 로드한 후에 책 목록을 불러옴
    fetchCategories(() => {
        fetchGenres(() => {
            fetchDays(() => {
                // 초기 카테고리, 장르, 요일 선택 후 책 목록 자동 로드
                fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);
                fetchBooksByGenreOrder('views', currentGenreViewsOrder);
                fetchBooksByDayOrder('views', currentDayViewsOrder);
            });
        });
    });
});

// 카테고리 목록을 가져와서 버튼 생성
function fetchCategories(callback) {
    fetch('/api/categories')
        .then(response => response.json())
        .then(categories => {
            const categoryFilter = document.getElementById('categoryFilter');
            categoryFilter.innerHTML = '';

            categories.forEach(category => {
                const button = document.createElement('button');
                button.classList.add('category--btn');
                button.textContent = category.categoryName;
                button.setAttribute('data-id', category.categoryId);
                button.onclick = () => {
                    activeCategoryId = category.categoryId;
                    fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);
                    setActiveButton(categoryFilter, activeCategoryId);
                };
                categoryFilter.appendChild(button);
            });

            setActiveButton(categoryFilter, activeCategoryId);
            if (callback) callback();
        });
}

// 장르 목록을 가져와서 버튼 생성
function fetchGenres(callback) {
    fetch('/api/genres')
        .then(response => response.json())
        .then(genres => {
            const genreFilter = document.getElementById('genreFilter');
            genreFilter.innerHTML = '';

            genres.forEach(genre => {
                const button = document.createElement('button');
                button.classList.add('genre--btn');
                button.textContent = genre.genreName;
                button.setAttribute('data-id', genre.genreId);
                button.onclick = () => {
                    selectedGenreId = genre.genreId;
                    fetchBooksByGenreOrder('views', currentGenreViewsOrder);
                    setActiveButton(genreFilter, selectedGenreId);
                };
                genreFilter.appendChild(button);
            });

            setActiveButton(genreFilter, selectedGenreId);
            if (callback) callback();
        });
}

// 요일 목록을 가져와서 버튼 생성
function fetchDays(callback) {
    fetch('/api/serial')
        .then(response => response.json())
        .then(days => {
            const dayFilter = document.getElementById('dayFilter');
            dayFilter.innerHTML = '';

            days.forEach(day => {
                const button = document.createElement('button');
                button.classList.add('day--btn');
                button.textContent = day;
                button.setAttribute('data-day', day);
                button.onclick = () => {
                    activeSerialDay = day;
                    fetchBooksByDayOrder('views', currentDayViewsOrder);
                    setActiveButton(dayFilter, activeSerialDay);
                };
                dayFilter.appendChild(button);
            });

            setActiveButton(dayFilter, activeSerialDay);
            if (callback) callback();
        });
}
// 카테고리별 책 목록을 가져오고 정렬 후 출력
function fetchBooksByCategoryOrder(filter, order) {
    fetch(`/api/booksByCategoryOrder?categoryId=${activeCategoryId}&filter=${filter}&order=${order}`)
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('categoryContent');
            bookListDiv.innerHTML = ''; // 기존 내용 초기화

            if (books.length === 0) {
                const noBookMessage = document.createElement('div');
                noBookMessage.innerHTML = '<p style="color: black">글이 없습니다.</p>';
				noBookMessage.style.textAlign = 'center';
				noBookMessage.style.color = '#FF4D6D';
				noBookMessage.style.fontWeight = 'bold';
				noBookMessage.style.padding = '20px';

                bookListDiv.appendChild(noBookMessage);
                return; // 리스트가 비어있을 경우 함수 종료
            }

            const sortedBooks = sortBooks(books, filter, order);

            // 각 책에 대해 이미지 경로를 비동기적으로 확인
            const bookPromises = sortedBooks.map(book => {
                return getValidImagePath(book.bookCoverImage).then(validImagePath => {
                    return {
                        ...book,
                        validImagePath: validImagePath // 이미지 경로 포함
                    };
                });
            });

			Promise.all(bookPromises).then(booksWithImages => {
			    booksWithImages.forEach(book => {
			        const bookItem = document.createElement('div');
			        bookItem.classList.add('book--item');
			        bookItem.setAttribute('data-work-id', book.bookId); // 책 ID를 data-work-id에 설정
			        bookItem.innerHTML = `
			            <div class="book--info">
			                <img src="${book.validImagePath}" alt="${book.title}">
			                <h4>${book.title}</h4>
			                <p>저자: ${book.author}</p>
			                <p>조회수: ${book.views}</p>
			                <p>좋아요: ${book.likes}</p>
			            </div>
			        `;
			        bookListDiv.appendChild(bookItem);
			    });

			    // 책 클릭 시 로컬 스토리지에 책 ID 저장 및 페이지 이동 처리
			    document.querySelectorAll('.book--item').forEach(item => {
			        item.addEventListener('click', function() {
			            const workId = this.getAttribute('data-work-id');
			            // 공통의 로컬 스토리지 키로 저장
			            localStorage.setItem('selectedWorkId', workId);
			            // 페이지 이동
			            window.location.href = `write/workList?bookId=${workId}`;
			        });
			    });
            });
        })
        .catch(error => console.error('Error fetching books:', error));
}

// 장르별 책 목록을 가져오고 정렬 후 출력
function fetchBooksByGenreOrder(filter, order) {
    fetch(`/api/booksByGenreOrder?genreId=${selectedGenreId}&filter=${filter}&order=${order}`)
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('genreContent');
            bookListDiv.innerHTML = ''; // 기존 내용 초기화

            if (books.length === 0) {
                const noBookMessage = document.createElement('div');
                noBookMessage.innerHTML = '<p style="color: black">글이 없습니다.</p>';
				noBookMessage.style.textAlign = 'center';
				noBookMessage.style.color = '#FF4D6D';
				noBookMessage.style.fontWeight = 'bold';
				noBookMessage.style.padding = '20px';

                bookListDiv.appendChild(noBookMessage);
                return;
            }

            const sortedBooks = sortBooks(books, filter, order);

            const bookPromises = sortedBooks.map(book => {
                return getValidImagePath(book.bookCoverImage).then(validImagePath => {
                    return {
                        ...book,
                        validImagePath: validImagePath
                    };
                });
            });

            Promise.all(bookPromises).then(booksWithImages => {
                booksWithImages.forEach(book => {
                    const bookItem = document.createElement('div');
                    bookItem.classList.add('book--item');
                    bookItem.setAttribute('data-work-id', book.bookId); // bookId 설정
                    bookItem.innerHTML = `
                        <div class="book--info">
                            <img src="${book.validImagePath}" alt="${book.title}">
                            <h4>${book.title}</h4>
                            <p>저자: ${book.author}</p>
                            <p>조회수: ${book.views}</p>
                            <p>좋아요: ${book.likes}</p>
                        </div>
                    `;
                    bookListDiv.appendChild(bookItem);
                });

				// 로컬 스토리지에 동일한 key 사용
                document.querySelectorAll('.book--item').forEach(item => {
                    item.addEventListener('click', function() {
                        const workId = this.getAttribute('data-work-id');
                        localStorage.setItem('selectedWorkId', workId);
                        window.location.href = `write/workList?bookId=${workId}`;
                    });
                });
            });
        })
        .catch(error => console.error('Error fetching books:', error));
}

// 요일별 책 목록을 비동기적으로 로드 후 DOM을 업데이트하는 함수
function fetchBooksByDayOrder(filter, order) {
    fetch(`/api/booksSerial?filter=${filter}&order=${order}`)
        .then(response => response.json())
        .then(books => {
            const filteredBooks = books.filter(book => book.serialDay === activeSerialDay);
            const sortedBooks = sortBooks(filteredBooks, filter, order);

            // 각 책에 대해 이미지 경로를 비동기적으로 확인
            const bookPromises = sortedBooks.map(book => {
                return getValidImagePath(book.bookCoverImage).then(validImagePath => {
                    return {
                        ...book,
                        validImagePath: validImagePath // 이미지 경로 포함
                    };
                });
            });

            // 모든 이미지가 로드된 후 DOM 업데이트
            Promise.all(bookPromises).then(booksWithImages => {
                const bookListDiv = document.getElementById('dayContent');
                if (bookListDiv) {
                    bookListDiv.innerHTML = ''; // 기존 내용 초기화

                    booksWithImages.forEach(book => {
                        const bookItem = document.createElement('div');
                        bookItem.classList.add('book--item');
                        bookItem.setAttribute('data-work-id', book.bookId); // bookId 설정

                        bookItem.innerHTML = `
                            <div class="book--info">
                                <img src="${book.validImagePath}" alt="${book.title}">
                                <h4>${book.title}</h4>
                                <p>저자: ${book.author}</p>
                                <p>조회수: ${book.views}</p>
                                <p>좋아요: ${book.likes}</p>
                            </div>
                        `;
                        bookListDiv.appendChild(bookItem);
                    });

                    // 책 클릭 시 로컬 스토리지에 책 ID 저장 및 페이지 이동 처리
                    document.querySelectorAll('.book--item').forEach(item => {
                        item.addEventListener('click', function() {
                            const workId = this.getAttribute('data-work-id');
                            // 로컬 스토리지에 선택된 책 ID 저장
                            localStorage.setItem('selectedWorkId', workId);
                            // 페이지 이동
                            window.location.href = `write/workList?bookId=${workId}`;
                        });
                    });

                } else {
                    console.error('dayContent 요소를 찾을 수 없습니다.');
                }
            });
        })
        .catch(error => console.error('Error fetching books:', error));
}


// 조회수와 좋아요 정렬 버튼 (카테고리)
function toggleCategoryViewsOrder() {
    currentCategoryViewsOrder = currentCategoryViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByCategoryOrder('views', currentCategoryViewsOrder);

    // 버튼에 따라 애니메이션 클래스 추가 및 활성화 표시
    const categoryButtonContainer = document.querySelector('.btn--area--category');
    const viewsButton = document.getElementById('categoryViewsButton');
    const likesButton = document.getElementById('categoryLikesButton');

    viewsButton.classList.add('active');
    likesButton.classList.remove('active');

    categoryButtonContainer.classList.add('active-after');
    categoryButtonContainer.classList.remove('active-before');
}

function toggleCategoryLikesOrder() {
    currentCategoryLikesOrder = currentCategoryLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByCategoryOrder('likes', currentCategoryLikesOrder);

    // 버튼에 따라 애니메이션 클래스 추가 및 활성화 표시
    const categoryButtonContainer = document.querySelector('.btn--area--category');
    const viewsButton = document.getElementById('categoryViewsButton');
    const likesButton = document.getElementById('categoryLikesButton');

    likesButton.classList.add('active');
    viewsButton.classList.remove('active');

    categoryButtonContainer.classList.add('active-before');
    categoryButtonContainer.classList.remove('active-after');
}

// 조회수와 좋아요 정렬 버튼 (장르)
function toggleGenreViewsOrder() {
    currentGenreViewsOrder = currentGenreViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByGenreOrder('views', currentGenreViewsOrder);

    const genreButtonContainer = document.querySelector('.btn--area--genre');
    const viewsButton = document.getElementById('genreViewsButton');
    const likesButton = document.getElementById('genreLikesButton');

    viewsButton.classList.add('active');
    likesButton.classList.remove('active');

    genreButtonContainer.classList.add('active-after');
    genreButtonContainer.classList.remove('active-before');
}

function toggleGenreLikesOrder() {
    currentGenreLikesOrder = currentGenreLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByGenreOrder('likes', currentGenreLikesOrder);

    const genreButtonContainer = document.querySelector('.btn--area--genre');
    const viewsButton = document.getElementById('genreViewsButton');
    const likesButton = document.getElementById('genreLikesButton');

    likesButton.classList.add('active');
    viewsButton.classList.remove('active');

    genreButtonContainer.classList.add('active-before');
    genreButtonContainer.classList.remove('active-after');
}

// 조회수와 좋아요 정렬 버튼 (요일)
function toggleDayViewsOrder() {
    currentDayViewsOrder = currentDayViewsOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByDayOrder('views', currentDayViewsOrder);

    const dayButtonContainer = document.querySelector('.btn--area--day');
    const viewsButton = document.getElementById('dayViewsButton');
    const likesButton = document.getElementById('dayLikesButton');

    viewsButton.classList.add('active');
    likesButton.classList.remove('active');

    dayButtonContainer.classList.add('active-after');
    dayButtonContainer.classList.remove('active-before');
}

function toggleDayLikesOrder() {
    currentDayLikesOrder = currentDayLikesOrder === 'ASC' ? 'DESC' : 'ASC';
    fetchBooksByDayOrder('likes', currentDayLikesOrder);

    const dayButtonContainer = document.querySelector('.btn--area--day');
    const viewsButton = document.getElementById('dayViewsButton');
    const likesButton = document.getElementById('dayLikesButton');

    likesButton.classList.add('active');
    viewsButton.classList.remove('active');

    dayButtonContainer.classList.add('active-before');
    dayButtonContainer.classList.remove('active-after');
}



document.addEventListener('DOMContentLoaded', function() {
    let currentPage = 0;
    const size = 1; // 배너 하나씩 가져오기

    const prevBtn = document.querySelector('.prev--btn');
    const nextBtn = document.querySelector('.next--btn');
    const bannerContainer = document.querySelector('.slider');

    // Fetch banners from the server
    function fetchMainBanner(page, size) {
        fetch(`/api/main-banners?page=${page}&size=${size}`)
            .then(response => response.json())
            .then(banners => {
                if (banners.length === 0) {
                    console.error('No banners found.');
                    return;
                }

                // Clear current banner
                bannerContainer.innerHTML = '';

                // Show the new banner
                banners.forEach(banner => {
                    const bannerElement = document.createElement('div');
                    bannerElement.classList.add('slide');
                    bannerElement.innerHTML = `
                        <img src="${banner.imagePath}" alt="${banner.title}">
                        <div class="banner--text--box">
                            <h2>${banner.title}</h2>
                            <p>${banner.content}</p>
                        </div>
                    `;
                    bannerContainer.appendChild(bannerElement);
                });
            })
            .catch(error => console.error('Error fetching banners:', error));
    }

    // Load initial banner
    fetchMainBanner(currentPage, size);

    // Previous banner
    prevBtn.addEventListener('click', function() {
        if (currentPage > 0) {
            currentPage--;
            fetchMainBanner(currentPage, size);
        }
    });

    // Next banner
    nextBtn.addEventListener('click', function() {
        currentPage++;
        fetchMainBanner(currentPage, size);
    });
});

