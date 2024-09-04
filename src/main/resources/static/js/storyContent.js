// 요소의 표시 상태를 토글하는 함수
function toggleDisplay(element) {
    if (element.style.display === "none" || element.style.opacity === "0") {
        element.style.display = "block";
        setTimeout(function() {
            element.style.opacity = 1;
        }, 10);
    } else {
        element.style.opacity = 0;
        setTimeout(function() {
            element.style.display = "none";
        }, 500);
    }
}

// 댓글 박스 토글 함수
function toggleComments() {
    var commentBox = document.getElementById("commentBox");
    toggleDisplay(commentBox);
}

// 댓글 박스 닫기 함수
function closeComments() {
    var commentBox = document.getElementById("commentBox");
    commentBox.style.opacity = 0;
    setTimeout(function() {
        commentBox.style.display = "none";
    }, 500);
}

// UI (버튼 영역과 제목 영역) 토글 함수
function toggleUI() {
    var btnArea = document.querySelector('.btn-area');
    var titleArea = document.querySelector('.title-area');
    toggleDisplay(btnArea);
    toggleDisplay(titleArea);
}

// 텍스트를 이미지로 변환하는 함수
function textToImage(text, pageNumber) {
    const canvas = document.createElement('canvas');
    const context = canvas.getContext('2d');

    // 플립북 높이에 맞게 캔버스 크기 설정
    const flipbookWidth = window.innerWidth * 0.8; // 양 옆의 패딩을 고려하여 80%로 설정
    const flipbookHeight = window.innerHeight - 140;
    canvas.width = flipbookWidth;
    canvas.height = flipbookHeight;

    context.fillStyle = '#fff'; // 배경색 설정
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.fillStyle = '#000'; // 텍스트 색상 설정
    context.font = '16px Arial'; // 폰트 크기 설정
    context.textAlign = 'left';
    context.textBaseline = 'top';

    const maxWidth = flipbookWidth - 40; // 패딩을 고려하여 텍스트 최대 너비 설정
    const lineHeight = 24;

    // <br><br> 태그를 실제 줄바꿈으로 변환
    const lines = text.split(/<br\s*\/?>\s*<br\s*\/?>/g);

    let y = 30; // 첫 번째 줄의 y 위치 설정

    lines.forEach((line, index) => {
        const words = line.split(' ');
        let lineText = '';

        words.forEach(word => {
            const testLine = lineText + word + ' ';
            const testWidth = context.measureText(testLine).width;

            if (testWidth > maxWidth) {
                context.fillText(lineText, 20, y); // 현재 줄 출력
                lineText = word + ' ';
                y += lineHeight;

                // 페이지 높이를 초과하는 경우
                if (y + lineHeight > canvas.height - 60) {
                    return; // 텍스트가 캔버스 높이를 초과하면 중단
                }
            } else {
                lineText = testLine;
            }
        });

        context.fillText(lineText, 20, y); // 줄 출력
        y += lineHeight; // 다음 줄로 이동

        // 문단 간 간격을 위해 추가적인 줄바꿈
        if (index < lines.length - 1) {
            y += lineHeight; // 두 줄 간격 추가
        }
    });

    // 페이지 번호 추가
    context.textAlign = 'center';
    context.font = 'bold 14px Arial';
    context.fillText("- " + pageNumber + " -", canvas.width / 2, canvas.height - 30);

    return canvas.toDataURL("image/png");
}

function splitContentIntoPages(content, maxLength) {
    let pages = [];
    let currentPage = '';

    while (content.length > 0) {
        if (content.length <= maxLength) {
            pages.push(content);
            break;
        } else {
            let breakPoint = content.lastIndexOf(' ', maxLength); // 단어 단위로 자르기
            if (breakPoint === -1) breakPoint = maxLength;
            currentPage = content.substring(0, breakPoint);
            pages.push(currentPage);
            content = content.substring(breakPoint).trim();
        }
    }
    return pages;
}

function initialize() {
    const flipbook = $("#flipbook");
    let currentPage = 1;
    let scrolling = false;

    // UI 토글
    document.body.addEventListener("click", function(event) {
        if (!event.target.closest('.btn-area') && !event.target.closest('.title-area')) {
            toggleUI();
        }
    });

    // 페이지 전환을 마우스 휠 이벤트로 처리
    window.addEventListener('wheel', function(event) {
        if (scrolling) return; // 스크롤 중이라면 중복 이벤트 방지

        scrolling = true;

        if (event.deltaY > 0) {
            // 휠을 아래로 돌렸을 때 (다음 페이지로)
            if (flipbook.turn("hasPage", currentPage + 1)) {
                flipbook.turn('page', currentPage + 1);
            }
        } else if (event.deltaY < 0) {
            // 휠을 위로 돌렸을 때 (이전 페이지로)
            if (flipbook.turn("hasPage", currentPage - 1)) {
                flipbook.turn('page', currentPage - 1);
            }
        }

        setTimeout(() => {
            scrolling = false;
        }, 1000); // turn.js의 애니메이션 시간과 맞춤
    });

    // 키보드 방향키 이벤트 처리
    document.addEventListener('keydown', function(event) {
        if (scrolling) return; // 스크롤 중이라면 중복 이벤트 방지

        scrolling = true;

        if (event.key === 'ArrowRight') {
            if (flipbook.turn("hasPage", currentPage + 1)) {
                flipbook.turn('page', currentPage + 1);
            }
        } else if (event.key === 'ArrowLeft') {
            if (flipbook.turn("hasPage", currentPage - 1)) {
                flipbook.turn('page', currentPage - 1);
            }
        }

        setTimeout(() => {
            scrolling = false;
        }, 1000); // turn.js의 애니메이션 시간과 맞춤
    });

    // 텍스트를 이미지로 변환 후 페이지 추가
    var content = storyContentContents.replace(/(\r\n|\n|\r)/gm, "<br>"); // JSP 파일에서 전달된 변수 사용
    var pages = splitContentIntoPages(content, 1000);

    pages.forEach(function(pageContent, index) {
        var imageSrc = textToImage(pageContent, index + 1);
        var pageDiv = $("<div class='page'><img src='" + imageSrc + "' alt='Page'></div>");
        flipbook.append(pageDiv);
    });

    // 플립북 초기화
    if (flipbook.turn) {
        flipbook.turn({
            width: "100%",
            height: "100%",
            autoCenter: true,
            display: 'single',
            elevation: 50,
            duration: 1000,
            when: {
                turning: function(event, page, view) {
                    currentPage = page;
                },
                turned: function(event, page, view) {
                    scrolling = false; // 페이지가 완전히 넘어간 후에 scrolling 플래그 해제
                }
            }
        });
    } else {
        console.error("turn.js is not loaded or initialized correctly.");
    }
}

// 설정 메뉴 토글 함수
function initializeSettingsMenu() {
    var settingsButton = document.getElementById('settingsButton');
    if (settingsButton) {
        settingsButton.addEventListener('click', function() {
            var settingsMenu = document.getElementById('settingsMenu');
            toggleDisplay(settingsMenu);
        });
    }

    // 설정 메뉴 외부를 클릭하면 메뉴를 숨깁니다.
    document.addEventListener('click', function(event) {
        var settingsMenu = document.getElementById('settingsMenu');
        var settingsButton = document.getElementById('settingsButton');
        if (settingsMenu && settingsButton && !settingsMenu.contains(event.target) && !settingsButton.contains(event.target)) {
            settingsMenu.style.opacity = 0;
            setTimeout(function() {
                settingsMenu.style.display = "none";
            }, 500);
        }
    });
}

// 모든 초기화 함수 호출
document.addEventListener("DOMContentLoaded", function() {
    initialize(); // 플립북 및 이벤트 초기화
    initializeSettingsMenu(); // 설정 메뉴 초기화
    closeComments(); // 댓글 박스 숨김 처리
});