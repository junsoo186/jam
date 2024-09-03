<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문서</title>
</head>
<body>
    <button id="googleLogin">구글 아이디로 로그인</button>

    <form>
        핸드폰 번호 : <input id="phoneNumber" />
        <button id="phoneNumberButton">핸드폰 번호 전송</button>
    </form>
  
    <form>
        확인 코드 : <input id="confirmCode" />
        <button id="confrimCodeButton">확인 코드 전송</button>
    </form>
    
    <script type="module">
        // 필요한 SDK 함수들을 가져옵니다.
        import { initializeApp } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-app.js";
        import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-analytics.js";
        import { getAuth, signInWithPopup, GoogleAuthProvider, signInWithPhoneNumber, RecaptchaVerifier } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-auth.js";

        // Firebase 제품을 사용하려면 필요한 SDK를 추가하세요.
        // https://firebase.google.com/docs/web/setup#available-libraries
      
        // 웹 앱의 Firebase 설정
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

        const provider = new GoogleAuthProvider();
        const auth = getAuth();
        auth.languageCode = 'ko'; // 언어 설정을 한국어로

        document.getElementById("googleLogin").addEventListener("click", () => {
            signInWithPopup(auth, provider)
                .then((result) => {
                    // Google 액세스 토큰을 가져옵니다. 이를 사용하여 Google API에 액세스할 수 있습니다.
                    const credential = GoogleAuthProvider.credentialFromResult(result);
                    const token = credential.accessToken;
                    // 로그인한 사용자 정보.
                    const user = result.user;
                    console.log(result);
                }).catch((error) => {
                    // 오류 처리
                    const errorCode = error.code;
                    const errorMessage = error.message;
                    const email = error.customData.email;
                    const credential = GoogleAuthProvider.credentialFromError(error);
                    console.log(error);
                });
        });

        window.recaptchaVerifier = new RecaptchaVerifier(auth, 'phoneNumberButton', {
            'size': 'invisible',
            'callback': (response) => {
                // reCAPTCHA 해결됨, signInWithPhoneNumber를 허용합니다.
                onSignInSubmit();
            }
        });

        document.getElementById("phoneNumberButton").addEventListener("click", (event) => {
            event.preventDefault();

            const phoneNumber = document.getElementById('phoneNumber').value;
            const appVerifier = window.recaptchaVerifier;

            signInWithPhoneNumber(auth, '+82' + phoneNumber, appVerifier)
                .then((confirmationResult) => {
                    // SMS가 전송되었습니다. 사용자가 메시지에서 코드를 입력하고, 그 다음 confirmationResult.confirm(code)를 사용하여 사용자 로그인.
                    window.confirmationResult = confirmationResult;
                    console.log(confirmationResult);
                }).catch((error) => {
                    console.log(error);
                });
        });

        document.getElementById("confrimCodeButton").addEventListener("click", (event) => {
            event.preventDefault();
            const code = document.getElementById('confirmCode').value;
            confirmationResult.confirm(code).then((result) => {
                // 사용자 로그인 성공
                const user = result.user;
                console.log('result');
            }).catch((error) => {
                console.log(error);
                // 사용자가 로그인할 수 없음(잘못된 인증 코드?)
            });
        });

    </script>
</body>
</html>