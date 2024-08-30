// 태그 중복 확인을 위한 Set 생성
let tagSet = new Set();

function addTagOnEnter(event) {
    if (event.key === "Enter") {
        event.preventDefault(); // 엔터키의 기본 동작을 막음
        appendCustomTag();
    }
}

function appendCustomTag(value = null) {
    var customTagInput = document.getElementById("customTag");
    var customTag = value || customTagInput.value.trim();

    if (customTag === "") {
        alert("태그를 입력해주세요.");
        return;
    }

    if (tagSet.has(customTag)) {
        alert("이미 추가된 태그입니다.");
        customTagInput.value = '';
        return;
    }

    // 태그 세트에 추가
    tagSet.add(customTag);

    var tagList = document.getElementById("tagList");

    // 새로운 태그 요소 생성
    var tagItem = document.createElement("div");
    tagItem.className = "tag-item";

    var tagNameSpan = document.createElement("span");
    tagNameSpan.className = "tag-name";
    tagNameSpan.textContent = customTag;

    // 삭제 버튼 생성
    var removeButton = document.createElement("span");
    removeButton.className = "remove-tag";
    removeButton.textContent = "x";
    removeButton.onclick = function() {
        tagList.removeChild(tagItem);
        tagSet.delete(customTag);
    };

    // 태그 요소 구성
    tagItem.appendChild(tagNameSpan);
    tagItem.appendChild(removeButton);
    tagList.appendChild(tagItem);

    // 숨겨진 input 필드에 태그 값 추가
    var hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "customTag"; // BookDTO와 매핑되는 필드 이름
    hiddenInput.value = customTag;
    tagItem.appendChild(hiddenInput);

    // 입력 필드 초기화
    customTagInput.value = '';
}

function addSelectedOption() {
    var select = document.getElementById("presetTags");
    var selectedOption = select.value.trim();
    if (selectedOption !== "") {
        appendCustomTag(selectedOption);
    }
    select.selectedIndex = 0; // Reset the select box
}

function prepareFormForSubmit() {
    if (tagSet.size < 3) {
        alert("태그는 최소 3개 이상이어야 합니다.");
        return false;
    }
    return true;
}
