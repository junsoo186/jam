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
	if (commentBox.style.display === "none" || commentBox.style.display === "") {
		commentBox.style.display = "block";
	} else {
		commentBox.style.display = "none";
	}
}

// 댓글 박스 닫기 함수
function closeComments() {
	var commentBox = document.getElementById("commentBox");
	commentBox.style.display = "none";
}

document.addEventListener("DOMContentLoaded", function() {
	var settingsButton = document.getElementById("settingsButton");
	var settingsMenu = document.getElementById("settingsMenu");

	if (settingsButton) {
		settingsButton.addEventListener("click", function() {
			if (settingsMenu.style.display === "none" || settingsMenu.style.display === "") {
				settingsMenu.style.display = "block";
			} else {
				settingsMenu.style.display = "none";
			}
		});
	}

	// 초기 설정: 댓글 박스를 숨김
	closeComments();
});

// UI (버튼 영역과 제목 영역) 토글 함수
function toggleUI() {
	var btnArea = document.querySelector('.btn-area');
	var titleArea = document.querySelector('.title-area');
	toggleDisplay(btnArea);
	toggleDisplay(titleArea);
}

function textToImage(text, pageNumber) {
	const canvas = document.createElement('canvas');
	const context = canvas.getContext('2d');

	// CSS에서 플립북의 높이를 calc(100% - 120px)로 설정했으므로 그에 맞추어 캔버스 크기를 설정합니다.
	const flipbookHeight = window.innerHeight - 140; // 140px은 상단과 하단 패딩을 고려한 값입니다.
	canvas.width = 700;  // CSS에서 설정한 최대 텍스트 너비에 맞춤
	canvas.height = flipbookHeight; // calc(100% - 140px)

	context.fillStyle = '#fff'; // 배경색 설정
	context.fillRect(0, 0, canvas.width, canvas.height);
	context.fillStyle = '#000'; // 텍스트 색상 설정
	context.font = '16px Arial'; // 폰트 크기를 16px로 줄임
	context.textAlign = 'left';
	context.textBaseline = 'top';

	const maxWidth = 660; // 텍스트 영역의 최대 너비 (padding 고려)
	const lineHeight = 24; // 줄 간격을 24px로 줄임
	const lines = text.split('<br>'); // '<br>'을 줄바꿈으로 처리
	let y = 30; // 첫 번째 줄 y 위치 설정

	lines.forEach(line => {
		const words = line.split(' ');
		let lineText = '';

		words.forEach(word => {
			const testLine = lineText + word + ' ';
			const testWidth = context.measureText(testLine).width;
			if (testWidth > maxWidth) {
				context.fillText(lineText, 20, y); // 20px 패딩 설정
				lineText = word + ' ';
				y += lineHeight;
			} else {
				lineText = testLine;
			}
		});

		context.fillText(lineText, 20, y); // 남아있는 텍스트 출력
		y += lineHeight;
	});

	// 페이지 번호를 추가
	context.textAlign = 'center';
	context.font = 'bold 14px Arial';
	context.fillText("- " + pageNumber + " -", canvas.width / 2, canvas.height - 30); // 하단 중앙에 페이지 번호 표시

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
			currentPage = content.substring(0, maxLength);
			pages.push(currentPage);
			content = content.substring(maxLength);
		}
	}
	return pages;
}

document.addEventListener("DOMContentLoaded", function() {
	const flipbook = $("#flipbook");
	const totalPages = $(".page").length;
	let currentPage = 1;
	let scrolling = false;

	document.body.addEventListener("click", function(event) {
		// 버튼 영역이나 제목 영역 내부가 아닌 곳을 클릭했을 때 UI 토글
		if (!event.target.closest('.btn-area') && !event.target.closest('.title-area')) {
			toggleUI();
		}
	});

	function updatePageOnScroll() {
		const pageHeight = window.innerHeight;
		const scrollPosition = window.scrollY;
		const newPage = Math.ceil(scrollPosition / pageHeight) + 1;

		if (newPage !== currentPage && newPage <= totalPages && !scrolling) {
			scrolling = true;
			flipbook.turn('page', newPage);
			currentPage = newPage;
			setTimeout(() => scrolling = false, 500);  // Prevent rapid firing
		}
	}

	// 페이지 스크롤 이벤트
	window.addEventListener('scroll', updatePageOnScroll);

	// maxLength 값을 줄여 페이지 당 글자수를 줄입니다.
	var content = storyContentContents.replace(/(\r\n|\n|\r)/gm, "<br>"); // JSP 파일에서 전달된 변수 사용
	var pages = splitContentIntoPages(content, 1000);  // 한 페이지에 1000자 제한

	pages.forEach(function(pageContent, index) {
		var imageSrc = textToImage(pageContent, index + 1);
		var pageDiv = $("<div class='page'><img src='" + imageSrc + "' alt='Page'></div>");

		flipbook.append(pageDiv);
	});

	flipbook.turn({
		width: "100%",
		height: "100%",
		autoCenter: true,
		display: 'single',
		elevation: 50,
		duration: 1000
	});
});

document.addEventListener("DOMContentLoaded", function() {
	// 설정 버튼 클릭 시 설정 메뉴 표시/숨기기
	var settingsButton = document.getElementById('settingsButton');
	if (settingsButton) {
		settingsButton.addEventListener('click', function() {
			console.log('Settings button clicked');
			var settingsMenu = document.getElementById('settingsMenu');
			if (settingsMenu.style.display === 'none' || settingsMenu.style.display === '') {
				settingsMenu.style.display = 'block';
				console.log('Settings menu shown');
			} else {
				settingsMenu.style.display = 'none';
				console.log('Settings menu hidden');
			}
		});
	}

	// 설정 메뉴 외부를 클릭하면 메뉴를 숨깁니다.
	document.addEventListener('click', function(event) {
		var settingsMenu = document.getElementById('settingsMenu');
		var settingsButton = document.getElementById('settingsButton');
		if (settingsMenu && settingsButton && !settingsMenu.contains(event.target) && !settingsButton.contains(event.target)) {
			settingsMenu.style.display = 'none';
		}
	});
});

