/**
 * 
 */
function sortStories(order) {
    const container = document.getElementById('storyListContainer');
    const stories = Array.from(container.getElementsByClassName('story-container'));

    stories.sort((a, b) => {
        const epA = parseInt(a.getAttribute('data-ep'), 10);
        const epB = parseInt(b.getAttribute('data-ep'), 10);

        if (order === 'asc') {
            return epA - epB;
        } else {
            return epB - epA;
        }
    });

    // 정렬된 요소를 다시 container에 추가
    stories.forEach(story => container.appendChild(story));
}
