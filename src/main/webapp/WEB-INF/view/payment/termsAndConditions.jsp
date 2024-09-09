<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이용 약관</title>
    <style>
        /* 전체 body에 대한 기본 스타일 설정 */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
        }

        /* 약관 내용을 담는 박스 스타일 */
        .terms-container {
            background-color: #fff;
            padding: 20px;
            margin: 0 auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 800px;
        }

        /* 제목 스타일 */
        h1 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        h3 {
            font-size: 18px;
            margin-top: 20px;
            color: #007BFF;
        }

        p {
            font-size: 14px;
            margin: 10px 0;
        }

        /* 스크롤이 필요할 때 사용되는 스타일 */
        .box1 {
            height: 400px;
            overflow-y: scroll;
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 20px;
        }

        /* 동의 버튼 스타일 */
        .agree-button {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .agree-button:hover {
            background-color: #0056b3;
        }
    </style>
    <script type="text/javascript">
        function agreeAndSubmit(paymentKey) {
            // 부모 창의 함수 호출하여 환불 폼 제출
            if (window.opener && !window.opener.closed) {
                window.opener.submitRefundForm(paymentKey);
                window.close(); // 팝업 창 닫기
            } else {
                alert("부모 창을 찾을 수 없습니다.");
            }
        }
    </script>
</head>
<body>
    <div class="terms-container">
       <h1>사이버 몰 약관</h1>
<div class="box1">
    <h3>제1조(목적)</h3>
    <p>이 약관은 (주)JoinAndMaker(전자거래 사업자)이 운영하는 홈페이지(이하 "쇼핑몰"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 (주)JoinAndMaker와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.</p>

    <h3>제2조(정의)</h3>
    <p>① "쇼핑몰" 이란 사업자가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 쇼핑몰을 운영하는 사업자의 의미로도 사용합니다.</p>
    <p>② "이용자"란 "쇼핑몰"에 접속하여 이 약관에 따라 "쇼핑몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</p>
    <p>③ "회원"이라 함은 "쇼핑몰"에 개인정보를 제공하여 회원등록을 한 자로서, "쇼핑몰"의 정보를 지속적으로 제공받으며, "쇼핑몰"이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</p>
    <p>④ "비회원"이라 함은 회원에 가입하지 않고 "쇼핑몰"이 제공하는 서비스를 이용하는 자를 말합니다.</p>

    <h3>제3조(약관의 명시와 개정)</h3>
    <p>① "쇼핑몰"은 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 사이트의 초기 서비스화면(전면)에 게시합니다.</p>
    <p>② "쇼핑몰"은 약관의 규제 등에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망 이용촉진 등에 관한 법률, 방문판매 등에 관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</p>

    <!-- 환불 규정 추가 -->
    <h3>제14조(환불 및 반품 규정)</h3>
    <p>① "쇼핑몰"은 이용자가 구매한 재화 또는 용역에 대해 환불 및 반품을 다음과 같은 조건으로 처리합니다.</p>
    
    <p>② 다음 각 호의 경우에 "쇼핑몰"은 배송된 재화일지라도 재화를 반품 받은 날로부터 영업일 이내에 이용자의 요구에 따라 환불 또는 교환 조치를 합니다. 다만, 그 요구기한은 배송된 날로부터 7일 이내로 합니다.</p>
    <ul>
        <li>1. 배송된 재화가 주문 내용과 상이하거나 "쇼핑몰"이 제공한 정보와 상이할 경우</li>
        <li>2. 배송된 재화가 파손, 손상되었거나 오염되었을 경우</li>
        <li>3. 재화가 광고에 표시된 배송 기간보다 늦게 배송된 경우</li>
        <li>4. 기타 전자상거래 등에서의 소비자 보호에 관한 법률에서 정한 청약 철회가 가능한 경우</li>
    </ul>

    <p>③ 다음 각 호의 경우에는 청약철회 및 환불이 불가능합니다.</p>
    <ul>
        <li>1. 이용자의 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우 (다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외)</li>
        <li>2. 이용자가 재화를 사용하거나 일부 소비하여 재화의 가치가 현저히 감소한 경우</li>
        <li>3. 시간이 경과하여 재판매가 곤란할 정도로 재화의 가치가 현저히 감소한 경우</li>
        <li>4. 복제가 가능한 재화 등의 포장을 훼손한 경우</li>
        <li>5. "쇼핑몰"이 미리 환불 불가를 고지한 경우</li>
    </ul>

    <p>④ 환불 신청 시 "쇼핑몰"은 이용자가 상품을 반환한 후 영업일 기준 3일 이내에 대금 환급 절차를 진행합니다. 환급은 결제 시 이용한 결제 수단으로만 가능합니다.</p>

    <p>⑤ 환불과 관련된 반품 비용은 이용자의 귀책 사유로 인한 반품의 경우 이용자가 부담하며, 제품 하자 또는 잘못된 배송으로 인한 반품의 경우에는 "쇼핑몰"이 부담합니다.</p>

    <p>⑥ 이용자는 환불을 원할 경우 "쇼핑몰"의 고객센터를 통해 신청할 수 있으며, 환불 요청 시 필요한 정보를 기재하고 이를 제출해야 합니다.</p>

    <p>⑦ 결제 취소 및 환불 처리는 결제 수단에 따라 차이가 있을 수 있으며, 결제 수단의 정책에 따라 다소 지연될 수 있습니다.</p>
</div>

        <!-- 동의 버튼 클릭 시 부모 창으로 환불 폼 제출 -->
        <button class="agree-button" onclick="agreeAndSubmit('${param.paymentKey}')">동의</button>
    </div>
</body>
</html>
    