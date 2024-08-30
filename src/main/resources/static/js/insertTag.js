function addTagOnEnter(event) {
	if (event.key === "Enter") {
		event.preventDefault(); // 엔터키의 기본 동작을 막음
		appendCustomTag();
	}
}

function appendCustomTag(value = null) {
	var customTag = value || document.getElementById("customTag").value.trim();
	if (customTag) {
		var tagList = document.getElementById("tagList");

		// 새로운 태그 요소 생성
		var tagItem = document.createElement("div");
		tagItem.className = "tag";
		tagItem.textContent = customTag;

		// 삭제 버튼 생성
		var removeButton = document.createElement("span");
		removeButton.className = "remove-tag";
		removeButton.textContent = "x";
		removeButton.onclick = function() {
			tagList.removeChild(tagItem);
		};

		// 태그 요소에 삭제 버튼 추가
		tagItem.appendChild(removeButton);
		tagList.appendChild(tagItem);

		// 숨겨진 input 필드에 태그 값 추가
		var hiddenInput = document.createElement("input");
		hiddenInput.type = "hidden";
		hiddenInput.name = "tagNames";
		hiddenInput.value = customTag;
		tagItem.appendChild(hiddenInput);

		// 입력 필드 초기화
		document.getElementById("customTag").value = '';
	}
}

function addSelectedOption() {
	var select = document.getElementById("presetTags");
	var selectedOption = select.options[select.selectedIndex].value;
	appendCustomTag(selectedOption);
	select.selectedIndex = 0; // Reset the select box
}

function prepareFormForSubmit() {
	// 태그 추가 버튼으로 생성된 숨겨진 태그들이 포함된 상태로 폼을 제출하게 함
	return true;
}