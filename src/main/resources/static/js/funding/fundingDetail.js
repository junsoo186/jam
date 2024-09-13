document.addEventListener('DOMContentLoaded', function () {
    const rewardDetail = document.getElementById('rewardDetail'); // 장바구니 전체 컨테이너
    const cartItemsContainer = document.getElementById('cartItems'); // 리워드 항목이 추가되는 컨테이너
    const cartTotalElement = document.getElementById('cartTotal');
    const checkoutButton = document.getElementById('checkoutButton');
    const checkoutForm = document.getElementById('checkoutForm');
    const totalAmountInput = document.getElementById('totalAmountInput');
    const cartItemsInputs = document.getElementById('cartItemsInputs');
    const userInfo = document.getElementById('userInfo');
    const percentageElement = document.getElementById('percentage'); // 퍼센트 표시 요소
    const remainingTimeElement = document.getElementById('remainingTime'); // 남은 시간 표시 요소

    let userId = 0;
    let userPoint = 0;

    if (userInfo) {
        userId = parseInt(userInfo.getAttribute('data-user-id'), 10) || 0;
        userPoint = parseInt(userInfo.getAttribute('data-user-point'), 10) || 0;
    } else {
        console.warn('userInfo 요소를 찾을 수 없습니다.');
    }

    let cartTotal = 0;
    let cart = {}; // 장바구니 객체

    // 목표 금액과 모인 금액 가져오기
    const goalAmount = parseInt(document.getElementById('goalAmount').dataset.goal, 10);
    const totalAmount = parseInt(document.getElementById('totalAmount').dataset.total, 10);

    // 남은 시간 계산
    const dateEnd = new Date(document.querySelector('.remaining-time').dataset.dateend);

    function calculateRemainingTime(endDate, currentDate) {
        const timeDiff = endDate - currentDate;
        const daysLeft = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
        const hoursLeft = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutesLeft = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
        const secondsLeft = Math.floor((timeDiff % (1000 * 60)) / 1000);
        return { days: daysLeft, hours: hoursLeft, minutes: minutesLeft, seconds: secondsLeft };
    }

    function displayRemainingTime() {
        const now = new Date();
        const remainingTime = calculateRemainingTime(dateEnd, now);
        if (remainingTime.days > 0) {
            remainingTimeElement.textContent = `${remainingTime.days}일 ${remainingTime.hours}시간 ${remainingTime.minutes}분 ${remainingTime.seconds}초`;
        } else if (remainingTime.hours > 0) {
            remainingTimeElement.textContent = `${remainingTime.hours}시간 ${remainingTime.minutes}분 ${remainingTime.seconds}초`;
        } else if (remainingTime.minutes > 0) {
            remainingTimeElement.textContent = `${remainingTime.minutes}분 ${remainingTime.seconds}초`;
        } else {
            remainingTimeElement.textContent = `${remainingTime.seconds}초`;
        }

        if (remainingTime.days <= 0 && remainingTime.hours <= 0 && remainingTime.minutes <= 0 && remainingTime.seconds <= 0) {
            remainingTimeElement.textContent = '펀딩 종료';
            clearInterval(timerInterval); // 시간이 다되면 타이머 종료
        }
    }

    // 퍼센트 계산 및 표시 함수
    function calculatePercentage(total, goal) {
        if (goal === 0) return 0;
        return Math.min((total / goal) * 100, 100);
    }

    function displayPercentage() {
        const percentage = calculatePercentage(totalAmount, goalAmount);
        percentageElement.textContent = `(${Math.floor(percentage)}%)`;
    }

    // checkoutButton 클릭 시 이벤트 리스너 추가
    checkoutButton.addEventListener('click', function (event) {
        event.preventDefault(); // 폼 자동 제출 방지 (디버그 목적)

        console.log("Checkout Button Clicked!");

        // 총 결제 금액 확인
        if (cartTotal === 0) {
            alert('장바구니가 비어 있습니다.');
            return;
        }

        // 사용자가 보유한 포인트와 비교하여 결제가 가능한지 확인
        if (cartTotal > userPoint) {
            alert('보유 포인트가 부족하여 결제할 수 없습니다.');
            return;
        }

        // 총 결제 금액을 히든 필드에 설정
        totalAmountInput.value = cartTotal;
        console.log(`Submitting checkout form with totalAmount=${cartTotal}`);

        // 히든 필드 값 출력
        console.log("Total Amount:", totalAmountInput.value);

        // 히든 필드에 있는 rewardIds[]와 quantities[] 값도 출력
        const rewardIdsInputs = document.querySelectorAll('input[name="rewardIds"]');
        const quantitiesInputs = document.querySelectorAll('input[name="quantities"]');

        const rewardIds = Array.from(rewardIdsInputs).map(input => input.value);
        const quantities = Array.from(quantitiesInputs).map(input => input.value);

        console.log("Reward IDs:", rewardIds);
        console.log("Quantities:", quantities);

        // 폼을 제출하여 POST 요청 전송
        checkoutForm.submit(); // 실제 폼 전송
    });

    // 리워드 섹션 숨기기 함수
    function hideCartIfEmpty() {
        if (Object.keys(cart).length === 0) {
            rewardDetail.classList.add('hidden');
            console.log("Cart is empty. Hiding cartDetail.");
        }
    }

    // 리워드 섹션 보이기 함수
    function showCartIfNotEmpty() {
        if (Object.keys(cart).length > 0) {
            rewardDetail.classList.remove('hidden');
            console.log("Cart has items. Showing cartDetail.");
        }
    }

    // 총액 업데이트 함수
    function updateCartTotal(amount) {
        cartTotal += amount;
        cartTotalElement.textContent = `${cartTotal.toLocaleString()} 원`;
        totalAmountInput.value = cartTotal; // 폼의 총 금액 업데이트
        console.log("Updated cart total:", cartTotal);
    }

    // 장바구니 항목 추가 함수
    function addCartItem(rewardContent, rewardPoint, rewardId, quantity = 1) {
        console.log(`Adding/updating cart item: ID=${rewardId}, Quantity=${quantity}`);
        // 이미 장바구니에 있는 경우 수량만 증가
        if (cart.hasOwnProperty(rewardId)) {
            cart[rewardId].quantity += quantity;
            const existingCartItem = document.querySelector(`.cart-item[data-reward-id="${rewardId}"]`);
            if (existingCartItem) {
                const quantityElement = existingCartItem.querySelector('.quantity');
                quantityElement.textContent = cart[rewardId].quantity;
                console.log(`Updated existing cart item: ID=${rewardId}, New Quantity=${cart[rewardId].quantity}`);
            }
            updateFormInput(rewardId, cart[rewardId].quantity);
        } else {
            // 새로운 장바구니 항목 추가
            cart[rewardId] = {
                rewardContent: rewardContent,
                rewardPoint: rewardPoint,
                quantity: quantity
            };

            const cartItem = document.createElement('div');
            cartItem.classList.add('cart-item');
            cartItem.setAttribute('data-reward-id', rewardId);
            cartItem.innerHTML = `
                <p>
                    <span class="reward-content">${rewardContent}</span> 
                    - 
                    <span class="reward-point">${rewardPoint}</span>원
                </p>
                <div class="quantity-control">
                    <button class="quantity-btn minus">-</button>
                    <span class="quantity">${quantity}</span>
                    <button class="quantity-btn plus">+</button>
                </div>
                <span class="remove-btn" data-reward-id="${rewardId}">&times;</span>`;

            cartItemsContainer.appendChild(cartItem);
            setupCartItemEvents(cartItem, rewardPoint);
            addFormInput(rewardId, quantity);
            console.log(`Added new cart item: ID=${rewardId}, Quantity=${quantity}`);
        }

        updateCartTotal(rewardPoint * quantity);
        showCartIfNotEmpty();
    }

    // 폼의 숨겨진 입력 필드 업데이트 함수
    function updateFormInput(rewardId, newQuantity) {
        const inputGroup = cartItemsInputs.querySelector(`.form-input-group[data-reward-id="${rewardId}"]`);
        if (inputGroup) {
            const quantityInput = inputGroup.querySelector('input[name="quantities"]');
            quantityInput.value = newQuantity;
            console.log(`Updated form input for reward ID=${rewardId}, New Quantity=${newQuantity}`);
        } else {
            addFormInput(rewardId, newQuantity);
        }
    }

    // 폼에 숨겨진 입력 필드 추가 함수
    function addFormInput(rewardId, quantity) {
        const inputGroup = document.createElement('div');
        inputGroup.classList.add('form-input-group');
        inputGroup.setAttribute('data-reward-id', rewardId);
        inputGroup.innerHTML = `
            <input type="hidden" name="rewardIds" value="${rewardId}" />
            <input type="hidden" name="quantities" value="${quantity}" />
        `;
        cartItemsInputs.appendChild(inputGroup);
        console.log(`Added form input for reward ID=${rewardId}, Quantity=${quantity}`);
    }

    // 수량 조절 및 삭제 기능 추가 함수
    function setupCartItemEvents(cartItem, rewardPoint) {
        // 수량 증가
        cartItem.querySelector('.plus').addEventListener('click', function () {
            const quantityElement = cartItem.querySelector('.quantity');
            let quantity = parseInt(quantityElement.textContent);
            quantity++;
            quantityElement.textContent = quantity;
            const rewardId = cartItem.getAttribute('data-reward-id');
            cart[rewardId].quantity = quantity;
            updateCartTotal(rewardPoint);
            updateFormInput(rewardId, quantity);
            console.log(`Increased quantity for reward ID=${rewardId} to ${quantity}`);
        });

        // 수량 감소
        cartItem.querySelector('.minus').addEventListener('click', function () {
            const quantityElement = cartItem.querySelector('.quantity');
            let quantity = parseInt(quantityElement.textContent);
            if (quantity > 1) {
                quantity--;
                quantityElement.textContent = quantity;
                const rewardId = cartItem.getAttribute('data-reward-id');
                cart[rewardId].quantity = quantity;
                updateCartTotal(-rewardPoint);
                updateFormInput(rewardId, quantity);
                console.log(`Decreased quantity for reward ID=${rewardId} to ${quantity}`);
            }
        });

        // 항목 삭제
        cartItem.querySelector('.remove-btn').addEventListener('click', function () {
            const rewardIdToRemove = this.getAttribute('data-reward-id');
            const rewardItem = document.querySelector(`.cart-item[data-reward-id="${rewardIdToRemove}"]`);
            const quantity = parseInt(rewardItem.querySelector('.quantity').textContent);
            cartItemsContainer.removeChild(rewardItem);
            updateCartTotal(-rewardPoint * quantity);
            delete cart[rewardIdToRemove];
            console.log(`Removed cart item: ID=${rewardIdToRemove}, Quantity=${quantity}`);
        });
    }

    // 리워드 버튼 클릭 시 장바구니에 추가
    document.querySelectorAll('.reward-button').forEach(button => {
        button.addEventListener('click', function () {
            // 로그인 여부 확인
            if (!userId) {
                alert('로그인 후 이용 가능합니다.');
                return; // 로그인하지 않으면 리워드 선택 불가
            }

            const rewardContent = this.getAttribute('data-reward-content');
            const rewardPoint = parseInt(this.getAttribute('data-reward-point'), 10);
            const rewardId = this.getAttribute('data-reward-id');

            console.log(`Reward button clicked: ID=${rewardId}, Content=${rewardContent}, Point=${rewardPoint}`);

            // 리워드 항목을 장바구니에 추가
            addCartItem(rewardContent, rewardPoint, rewardId);
        });
    });

    // 1초마다 남은 시간을 갱신
    const timerInterval = setInterval(displayRemainingTime, 1000);

    // 페이지 로드 시 퍼센트 및 남은 시간 표시
    displayPercentage();
    displayRemainingTime();

    // 페이지 로드 시 장바구니가 비어있으면 숨김 처리
    hideCartIfEmpty();
});
