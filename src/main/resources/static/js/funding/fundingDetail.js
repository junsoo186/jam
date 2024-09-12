document.addEventListener('DOMContentLoaded', function () {
    const cartItemsContainer = document.getElementById('rewardDetail');
    const cartTotalElement = document.getElementById('cartTotal');
    const checkoutButton = document.getElementById('checkoutButton');
    const userId = parseInt(document.getElementById('userInfo').getAttribute('data-user-id'), 10); // 로그인 여부 확인
    const userPoint = parseInt(document.getElementById('userInfo').getAttribute('data-user-point'), 10); // 사용자의 보유 포인트 확인
    let cartTotal = 0;

    console.log("User ID:", userId);

    // 리워드 섹션 숨기기 함수
    function hideCartIfEmpty() {
        if (cartItemsContainer.querySelectorAll('.cart-item').length === 0) {
            cartItemsContainer.classList.add('hidden');
        }
    }

    // 리워드 섹션 보이기 함수
    function showCartIfNotEmpty() {
        if (cartItemsContainer.querySelectorAll('.cart-item').length > 0) {
            cartItemsContainer.classList.remove('hidden');
        }
    }

    // 총액 업데이트 함수
    function updateCartTotal(amount) {
        cartTotal += amount;
        cartTotalElement.textContent = `${cartTotal.toLocaleString()} 원`;
    }

    // 장바구니 항목 추가 함수
    function addCartItem(rewardContent, rewardPoint, rewardId) {
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
                <span class="quantity">1</span>
                <button class="quantity-btn plus">+</button>
            </div>
            <span class="remove-btn" data-reward-id="${rewardId}">&times;</span>`;

        cartItemsContainer.appendChild(cartItem);
        showCartIfNotEmpty();

        // 수량 조절 및 삭제 버튼 기능 추가
        setupCartItemEvents(cartItem, rewardPoint);
        updateCartTotal(rewardPoint); // 최초 추가 시 총액에 반영
    }

    // 수량 조절 및 삭제 기능 추가 함수
    function setupCartItemEvents(cartItem, rewardPoint) {
        // 수량 증가
        cartItem.querySelector('.plus').addEventListener('click', function () {
            const quantityElement = cartItem.querySelector('.quantity');
            let quantity = parseInt(quantityElement.textContent);
            quantity++;
            quantityElement.textContent = quantity;
            updateCartTotal(rewardPoint);
        });

        // 수량 감소
        cartItem.querySelector('.minus').addEventListener('click', function () {
            const quantityElement = cartItem.querySelector('.quantity');
            let quantity = parseInt(quantityElement.textContent);
            if (quantity > 1) {
                quantity--;
                quantityElement.textContent = quantity;
                updateCartTotal(-rewardPoint);
            }
        });

        // 항목 삭제
        cartItem.querySelector('.remove-btn').addEventListener('click', function () {
            const rewardIdToRemove = this.getAttribute('data-reward-id');
            const rewardItem = document.querySelector(`.cart-item[data-reward-id="${rewardIdToRemove}"]`);
            const quantity = parseInt(rewardItem.querySelector('.quantity').textContent);
            cartItemsContainer.removeChild(rewardItem);
            updateCartTotal(-rewardPoint * quantity);
            hideCartIfEmpty();
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
            const existingCartItem = document.querySelector(`.cart-item[data-reward-id="${rewardId}"]`);

            if (existingCartItem) {
                // 이미 장바구니에 존재하면 수량만 증가
                const quantityElement = existingCartItem.querySelector('.quantity');
                let quantity = parseInt(quantityElement.textContent);
                quantity++;
                quantityElement.textContent = quantity;
                updateCartTotal(rewardPoint);
            } else {
                // 새 리워드 항목 추가
                addCartItem(rewardContent, rewardPoint, rewardId);
            }
        });
    });

    // 결제 버튼 클릭 시
    checkoutButton.addEventListener('click', function () {
        if (cartTotal > 0) {
            if (cartTotal > userPoint) {
                alert('보유 포인트가 부족하여 결제할 수 없습니다.');
                return;
            }

            const cartItems = [];
            document.querySelectorAll('.cart-item').forEach(item => {
                const rewardId = item.getAttribute('data-reward-id');
                const rewardContent = item.querySelector('.reward-content').textContent;
                const rewardPoint = parseInt(item.querySelector('.reward-point').textContent, 10);
                const quantity = parseInt(item.querySelector('.quantity').textContent, 10);
                cartItems.push({
                    rewardId: rewardId,
                    rewardContent: rewardContent,
                    rewardPoint: rewardPoint,
                    quantity: quantity
                });
            });

            // URL로 결제 정보 전달 (GET 요청으로 페이지 이동)
            const cartItemsEncoded = encodeURIComponent(JSON.stringify(cartItems));
            window.location.href = `/funding/checkoutPage?totalAmount=${cartTotal}&cartItems=${cartItemsEncoded}`;
        } else {
            alert('장바구니가 비어 있습니다.');
        }
    });

    // 장바구니가 비어있으면 초기에는 숨김 처리
    hideCartIfEmpty();
});
