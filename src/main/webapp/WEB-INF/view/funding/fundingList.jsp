<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <link rel="stylesheet" href="/css/funding/fundingList.css">

                <body>
                    <main>
                        <!-- 프로젝트 컨테이너 (동적으로 프로젝트를 여기에 추가) -->
                        <div class="project-container"></div>

                        <!-- 스크롤 감지용 로딩 인디케이터 -->
                        <div class="loading-indicator" style="text-align: center; padding: 20px;">
                            Loading...
                        </div>
                    </main>

                    <!-- 프로젝트 리스트 로딩을 위한 JavaScript 파일 -->
                    <script src="/js/funding/fundingList.js"></script>
                </body>
<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/funding.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<h2>펀딩페이지 입니다</h2>
<Style>
 
    </style>
</head>
<body>
<div class="container">
    <div class="main--section">
        <div class="left--panel">
            <div class="book--cover">책 커버</div>
            <div class="info--box">
                <p>목표 금액: <strong>10,000,000원</strong></p>
                <p>펀딩 인원: <strong>100명</strong></p>
                <p>남은 기간: <strong>30일</strong></p>
            </div>
            <div class="description">
                <p>소개글: 이 프로젝트는 훌륭한 웹소설을 제작하기 위한 펀딩 프로젝트입니다.</p>
                

            </div>
        </div>
        <div class="right--panel">
            <div class="funding--title">펀딩 선택</div>
            <div class="product--box">상품 1</div>
            <div class="product--box">상품 2</div>
            <div class="product--box">상품 3</div>
            <div class="product--box">상품 4</div>
        </div>
    </div>
</div>


<h2>Funding, User, Reward ID 차트</h2>

<!-- JSP에서 자바스크립트 배열로 변환 -->
<script>
    var fundingIdList = [];
    var userIdList = [];
    var rewardIdList = [];

    <c:forEach var="funding" items="${fundingList}">
        fundingIdList.push(${funding.fundingId});  // fundingId 배열에 추가
        userIdList.push(${funding.userId});        // userId 배열에 추가
        rewardIdList.push(${funding.rewardId});    // rewardId 배열에 추가
    </c:forEach>
</script>

<!-- 차트를 담을 div를 반복적으로 생성 -->
<c:forEach var="funding" items="${fundingList}" varStatus="status">
    <div>
        <!-- 각 차트마다 다른 id를 주어야 함 -->
        <canvas id="chart_${status.index}" width="400" height="200"></canvas>
    </div>
</c:forEach>

<script>
    // Session에서 가져온 userId 값을 자바스크립트 변수로 저장
    var sessionUserId = '${principal.userId}';  // 세션에서 userId 값을 가져옴

    <c:forEach var="funding" items="${fundingList}" varStatus="status">
        // JSP에서 넘어온 데이터를 자바스크립트 배열에 넣는 작업
        var fundingId = ${funding.fundingId};
        var userId = ${funding.userId};
        var rewardId = ${funding.rewardId};

        // 각 차트의 캔버스에 대해 차트를 생성
        var ctx = document.getElementById('chart_${status.index}').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',  // 차트 종류: 막대(bar)형 차트
            data: {
                labels: ['Funding ID', 'User ID', 'Reward ID', 'Session User ID'],  // X축 레이블 이름
                datasets: [{
                    label: 'ID Values',  // 데이터의 이름
                    data: [fundingId, userId, rewardId, sessionUserId],  // 각 항목의 값을 배열로 넣음 (세션의 userId 포함)
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',  // Funding ID 배경색
                        'rgba(54, 162, 235, 0.2)',  // User ID 배경색
                        'rgba(255, 206, 86, 0.2)',  // Reward ID 배경색
                        'rgba(75, 192, 192, 0.2)'   // Session User ID 배경색
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',    // Funding ID 테두리색
                        'rgba(54, 162, 235, 1)',    // User ID 테두리색
                        'rgba(255, 206, 86, 1)',    // Reward ID 테두리색
                        'rgba(75, 192, 192, 1)'     // Session User ID 테두리색
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true  // y축을 0부터 시작하게 설정
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'ID Types'  // X축 하단에 표시할 제목
                        }
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Comparison of IDs'  // 차트의 제목 설정
                    }
                }
            }
        });
    </c:forEach>
</script>

</body>
</html>
=======

                </html>
>>>>>>> sub-dev
