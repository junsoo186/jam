document.addEventListener('DOMContentLoaded', function() {
    // 배너 Swiper 인스턴스 초기화
    let bannerSwiper = new Swiper('.banner-swiper-container', {
        slidesPerView: 1,
        loop: true,
        pagination: {
            el: '.banner-swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.banner-swiper-button-next',
            prevEl: '.banner-swiper-button-prev',
        },
        on: {
            slideChangeTransitionStart: function() {
                const previousSlide = document.querySelector('.swiper-slide-prev .banner-image');
                const previousTextBox = document.querySelector('.swiper-slide-prev .banner--text--box');
                if (previousSlide) {
                    previousSlide.style.opacity = '0';
                    previousSlide.style.visibility = 'hidden';
                }
                const nextSlide = document.querySelector('.swiper-slide-next .banner-image');
                const nextTextBox = document.querySelector('.swiper-slide-next .banner--text--box');
                if (nextSlide) {
                    nextSlide.style.opacity = '0';
                    nextSlide.style.visibility = 'hidden';
                }
                const activeSlide = document.querySelector('.swiper-slide-active .banner-image');
                const activeTextBox = document.querySelector('.swiper-slide-active .banner--text--box');
                if (activeSlide) {
                    activeSlide.style.opacity = '1';
                    activeSlide.style.visibility = 'visible';
                }
                if (activeTextBox) {
                    activeTextBox.style.opacity = '1';
                    activeTextBox.style.visibility = 'visible';
                }
            }
        }
    });

    // 서버에서 배너 데이터를 가져오는 함수
    function fetchMainBanner() {
        fetch('/api/main-banners?page=1&size=3')
            .then(response => response.json())
            .then(data => {
                const banners = data.mainBannerList;

                if (banners.length === 0) {
                    console.error('No banners found.');
                    return;
                }

                // 배너 슬라이드를 동적으로 추가
                banners.forEach(banner => {
                    const slide = document.createElement('div');
                    slide.classList.add('swiper-slide');
                    slide.innerHTML = `
                        <img src="${banner.imagePath}" alt="${banner.title}" class="banner-image" data-url="${banner.link}">
                        <div class="banner--text--box">
                            <h2>${banner.title}</h2>
                            <p>${banner.content}</p>
                        </div>
                    `;
                    bannerSwiper.appendSlide(slide);
                });

                // Swiper 업데이트하여 새 슬라이드를 반영
                bannerSwiper.update();

                // 배너 이미지 클릭 이벤트 추가
                const images = document.querySelectorAll('.banner-image');
                images.forEach(image => {
                    image.addEventListener('click', function() {
                        const url = this.getAttribute('data-url');
                        window.location.href = `event/list`; // 클릭 시 이동할 URL
                    });
                });
            })
            .catch(error => console.error('Error fetching banners:', error));
    }

    // 배너 데이터를 로드
    fetchMainBanner();
});

// 정렬 구간
// 카테고리 정렬을 위한 초기 설정
let currentCategoryViewsOrder = 'DESC';
let currentCategoryLikesOrder = 'DESC';
let activeCategoryId = 3;  // 초기 카테고리 ID (기본 선택할 카테고리 ID)

// 장르 정렬을 위한 초기 설정
let currentGenreViewsOrder = 'DESC';
let currentGenreLikesOrder = 'DESC';
let selectedGenreId = 5;  // 초기 장르 ID (기본 선택할 장르 ID)

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
			
			const limitedBooks = sortedBooks.slice(0, 9);
            // 각 책에 대해 이미지 경로를 비동기적으로 확인
            const bookPromises = limitedBooks.map(book => {
                return getValidImagePath(book.bookCoverImage).then(validImagePath => {
                    return {
                        ...book,
                        validImagePath: validImagePath // 이미지 경로 포함
                    };
                });
            });

			Promise.all(bookPromises).then(booksWithImages => {
			    booksWithImages.forEach((book,index) => {
			        const bookItem = document.createElement('div');
			        bookItem.classList.add('book--item');
			        bookItem.setAttribute('data-work-id', book.bookId); // 책 ID를 data-work-id에 설정
					        // 추가할 내용 변수
			        let additionalInfo = '';
			        // book.age에 따른 조건문
					if (book.age === '15') {
					    additionalInfo = '<div class="age--mark" style="background-color: blue; color: white;">15</div>';
					} else if (book.age === '19') {
					    additionalInfo = '<div  class="age--mark" style="background-color: red; color: white;">19</div>';
					}
			        bookItem.innerHTML = `
			            <div class="book--info">
			                <div class="book--cover">
			                    <img src="${book.validImagePath}" alt="${book.title}">
			                        ${additionalInfo} <!-- 추가 정보 삽입 -->
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
			        bookListDiv.appendChild(bookItem);
			    });

			    // 책 클릭 시 로컬 스토리지에 책 ID 저장 및 페이지 이동 처리
			    document.querySelectorAll('.book--item').forEach(item => {
			        item.addEventListener('click', function() {
			            const workId = this.getAttribute('data-work-id');
			            // 공통의 로컬 스토리지 키로 저장
			            localStorage.setItem('selectedWorkId', workId);
			            // 페이지 이동
			            window.location.href = `write/workDetail?bookId=${workId}`;
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

            // 최대 10개의 책만 선택
            const limitedBooks = sortedBooks.slice(0, 9);
            
            const bookPromises = limitedBooks.map(book => {
                return getValidImagePath(book.bookCoverImage).then(validImagePath => {
                    return {
                        ...book,
                        validImagePath: validImagePath
                    };
                });
            });

            Promise.all(bookPromises).then(booksWithImages => {
                booksWithImages.forEach((book,index) => {
                    const bookItem = document.createElement('div');
                    bookItem.classList.add('book--item');
                    bookItem.setAttribute('data-work-id', book.bookId); // bookId 설정
                let additionalInfo = '';
		        // book.age에 따른 조건문
				if (book.age === '15') {
				    additionalInfo = '<div class="age--mark" style="background-color: blue; color: white;">15</div>';
				} else if (book.age === '19') {
				    additionalInfo = '<div  class="age--mark" style="background-color: red; color: white;">19</div>';
				}
                    bookItem.innerHTML = `
 			            <div class="book--info">
			            	<div class="book--cover">
			                <img src="${book.validImagePath}" alt="${book.title}">
			                ${additionalInfo} <!-- 추가 정보 삽입 -->
			                </div>
			                <div class="book--text">
			                	<div class="text--number">${index + 1}</div>
			                	<div>
				                <p class="text--title"> ${book.title}</p>
				                <p class="text--writer">저자: ${book.author}</p>
				                <p class="text--view">조회수: ${book.views}</p>
				                <p class="text--view">좋아요: ${book.likes}</p>
				                </div>
			                </div>
			            </div>
			        `;
                    bookListDiv.appendChild(bookItem);
                });

				// 로컬 스토리지에 동일한 key 사용
                document.querySelectorAll('.book--item').forEach(item => {
                    item.addEventListener('click', function() {
                        const workId = this.getAttribute('data-work-id');
                        localStorage.setItem('selectedWorkId', workId);
                        window.location.href = `write/workDetail?bookId=${workId}`;
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

			const limitedBooks = sortedBooks.slice(0, 9);
            // 각 책에 대해 이미지 경로를 비동기적으로 확인
            const bookPromises = limitedBooks.map(book => {
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

                    booksWithImages.forEach((book,index) => {
                        const bookItem = document.createElement('div');
                        bookItem.classList.add('book--item');
                        bookItem.setAttribute('data-work-id', book.bookId); // bookId 설정
	                let additionalInfo = '';
			        // book.age에 따른 조건문
					if (book.age === '15') {
					    additionalInfo = '<div class="age--mark" style="background-color: blue; color: white;">15</div>';
					} else if (book.age === '19') {
					    additionalInfo = '<div  class="age--mark" style="background-color: red; color: white;">19</div>';
					}
                        bookItem.innerHTML = `
			            <div class="book--info">
			            	<div class="book--cover">
			                <img src="${book.validImagePath}" alt="${book.title}">
			                 ${additionalInfo} <!-- 추가 정보 삽입 -->
			                </div>
			                <div class="book--text">
			                	<div class="text--number">${index + 1}</div>
			                	<div>
				                <p class="text--title"> ${book.title}</p>
				                <p class="text--writer">저자: ${book.author}</p>
				                <p class="text--view">조회수: ${book.views}</p>
				                <p class="text--view">좋아요: ${book.likes}</p>
				                </div>
			                </div>
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
                            window.location.href = `write/workDetail?bookId=${workId}`;
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


// 조회수 정렬을 위한 변수 (초기값은 내림차순)
let newViewsOrder = 'DESC';

// 당일 책 목록을 비동기적으로 로드 후 DOM을 업데이트하는 함수
function fetchBooksByNewDayOrder(order) {
    fetch(`/api/bookDayViews?order=${order}`)  // 서버 API 호출 (기존 API 사용)
        .then(response => response.json())
        .then(books => {
            const bookListDiv = document.getElementById('newDayContent');  // 새로운 책 목록 표시 영역
            if (bookListDiv) {
                bookListDiv.innerHTML = '';  // 기존 내용 초기화

                books.forEach((book,index) => {
                    const bookItem = document.createElement('div');
                        bookItem.classList.add('book--item');
                        bookItem.setAttribute('data-work-id', book.bookId); // bookId 설정
					        // 추가할 내용 변수
			        let additionalInfo = '';
			        // book.age에 따른 조건문
					if (book.age === '15') {
					    additionalInfo = '<div class="age--mark" style="background-color: blue; color: white;">15</div>';
					} else if (book.age === '19') {
					   additionalInfo = '<div class="age--mark" style="color: white;">19</div>';
					}
                        bookItem.innerHTML =`
                        <div class="book--info">
                        	<div class="book--cover">
                            	<img src="${book.bookCoverImage}" alt="${book.title}" width="100">
                            	 ${additionalInfo} <!-- 추가 정보 삽입 -->
                             </div>
 							<div class="book--text">
			                	<div class="text--number">${index + 1}</div>
			                	<div>
					                <p class="text--title"> ${book.title}</p>
					                <p class="text--writer">저자: ${book.author}</p>
				                </div>
			                </div>
                        </div>
                    `;
                    bookListDiv.appendChild(bookItem);
                });

                // 책 클릭 시 로컬 스토리지에 책 ID 저장 및 페이지 이동 처리
                document.querySelectorAll('.new-book--item').forEach(item => {
                    item.addEventListener('click', function() {
                        const workId = this.getAttribute('data-work-id');
                        localStorage.setItem('newSelectedWorkId', workId);  // 로컬 스토리지에 선택된 책 ID 저장
                        window.location.href = `write/workDetail?bookId=${workId}`;  // 페이지 이동
                    });
                });
            } else {
                console.error('newDayContent 요소를 찾을 수 없습니다.');
            }
        })
        .catch(error => console.error('Error fetching books:', error));
}

// 조회수 정렬을 토글하는 함수
function toggleNewViewsOrder() {
    newViewsOrder = newViewsOrder === 'ASC' ? 'DESC' : 'ASC';  // 오름차순 ↔ 내림차순 토글
    fetchBooksByNewDayOrder(newViewsOrder);  // 책 목록을 정렬 후 다시 가져옴

    const viewsButton = document.getElementById('newViewsButton');  // 새로운 버튼
    viewsButton.classList.toggle('active');  // 버튼 스타일 토글 (활성화 상태 표시)
}

// 페이지가 로드될 때 기본 조회수 내림차순으로 책 목록을 불러옴
document.addEventListener('DOMContentLoaded', function() {
    fetchBooksByNewDayOrder(newViewsOrder);
});


