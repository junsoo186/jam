<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Firebase 인증</title>
</head>
<body>
    <button id="googleLogin">구글 아이디로 로그인</button>

    <form>
        핸드폰 번호 : <input id="phoneNumber" />
        <button id="phoneNumberButton">핸드폰 번호 전송</button>
    </form>

    <form>
        확인 코드 : <input id="confirmCode" />
        <button id="confirmCodeButton">확인 코드 전송</button>
    </form>

    <script type="module">
        import { initializeApp } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-app.js";
        import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-analytics.js";
        import { getAuth, signInWithPopup, GoogleAuthProvider, signInWithPhoneNumber, RecaptchaVerifier } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-auth.js";

        // Firebase 설정
        const firebaseConfig = {
            apiKey: "AIzaSyDzGxfuE1OABJffD96bSHX69wMMKz7GNTc",
            authDomain: "jamproject-d6279.firebaseapp.com",
            projectId: "jamproject-d6279",
            storageBucket: "jamproject-d6279.appspot.com",
            messagingSenderId: "1032516710742",
            appId: "1:1032516710742:web:d0b7d5daa295f03d1b26f7",
            measurementId: "G-J5GPBN3J29"
        };

        // Firebase 초기화
        const app = initializeApp(firebaseConfig);
        const analytics = getAnalytics(app);
        const auth = getAuth(app); // Firebase 인증 인스턴스 초기화
        auth.languageCode = 'ko'; // 인증 언어 설정 (예: 한국어)

        // 구글 로그인 버튼 클릭 이벤트
        document.getElementById("googleLogin").addEventListener("click", () => {
            signInWithPopup(auth, new GoogleAuthProvider())
                .then((result) => {
                    const credential = GoogleAuthProvider.credentialFromResult(result);
                    const token = credential.accessToken;
                    const user = result.user;
                    console.log(result);
                }).catch((error) => {
                    console.log(error);
                });
        });

        // 핸드폰 번호 전송 버튼 클릭 이벤트
        document.getElementById("phoneNumberButton").addEventListener("click", (event) => {
            event.preventDefault();

            // RecaptchaVerifier 초기화
            if (!window.recaptchaVerifier) {
                window.recaptchaVerifier = new RecaptchaVerifier('phoneNumberButton', {
                    'size': 'invisible',
                    'callback': (response) => {
                        // reCAPTCHA 완료 시 콜백
                        onSignInSubmit();
                    }
                }, auth);
            }

            const phoneNumber = document.getElementById('phoneNumber').value;
            const appVerifier = window.recaptchaVerifier;

            signInWithPhoneNumber(auth, '+82' + phoneNumber, appVerifier)
                .then((confirmationResult) => {
                    window.confirmationResult = confirmationResult;
                    console.log(confirmationResult);
                }).catch((error) => {
                    console.log(error);
                });
        });

        // 확인 코드 전송 버튼 클릭 이벤트
        document.getElementById("confirmCodeButton").addEventListener("click", (event) => {
            event.preventDefault();
            const code = document.getElementById('confirmCode').value;
            window.confirmationResult.confirm(code).then((result) => {
                const user = result.user;
                console.log(result);
            }).catch((error) => {
                console.log(error);
            });
        });
    </script>

</body>
</html>