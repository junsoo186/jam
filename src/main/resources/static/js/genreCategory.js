
function selectGenre(button) {
    // 모든 버튼의 'active' 클래스 제거
      console.log("selectGenre 함수 호출됨"); // 함수 호출 확인용
    const buttons = document.querySelectorAll('.genre-button');
    buttons.forEach(btn => btn.classList.remove('active'));

    // 클릭된 버튼에 'active' 클래스 추가
    button.classList.add('active');

    // 선택된 장르를 숨겨진 입력 필드에 저장
    const selectedGenre = button.getAttribute('data-genre');
    document.getElementById('selectedGenre').value = selectedGenre;
}
