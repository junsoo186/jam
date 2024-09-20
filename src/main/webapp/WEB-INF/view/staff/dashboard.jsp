<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/view/staff/main.jsp"%>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<link rel="stylesheet" href="/css/staff/chart.css">

<body>
	<!-- 메인 콘텐츠 영역 -->
	<div class="main-content">
		<h1>대시보드</h1>

		<!-- 오늘의 현황 박스 -->
		<div class="status-box">
			<h3>오늘의 현황</h3>
			<ul>
				<li>신규 제안: <span>0</span></li>
				<li>환불이슈: <span>0</span></li>
				<li>환불 대기: <span>0</span></li>
				<li>업데이트: <span>0</span></li>
			</ul>
			<div class="chart-container">
				<h3>차트 데이터</h3>
				<canvas id="myChart" width="300" height="300"></canvas>
			</div>

			<script>
    // 서버에서 데이터를 가져오는 함수
    async function fetchGraphData() {
        const response = await fetch('<%=request.getContextPath()%>/getGraphData');  // 서버에서 데이터를 가져옴
        if (!response.ok) {
            throw new Error("Failed to fetch data from /getGraphData");
        }
        const graphData = await response.json();  // JSON 데이터를 JavaScript 객체로 변환
        return graphData;
    }

    // 차트를 그리기 위한 함수
    async function renderChart() {
        try {
            const data = await fetchGraphData();
            console.log("data", data);
            // 데이터에서 필요한 값 추출 (labels와 data에 맞게 처리)
            const labels = data.map(item => item.status);  // status를 라벨로 사용
            const deposits = data.map(item => item.deposit);  // deposit 값을 데이터로 사용
            const points = data.map(item => item.point);  // point 값을 데이터로 사용

            // 차트 그리기
            const ctx = document.getElementById('myChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'bar',  // 차트 유형
                data: {
                    labels: labels,  // X축 레이블 (status 값)
                    datasets: [
                        {
                            label: '자금',
                            data: deposits,  // deposit 데이터를 Y축 값으로 사용
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        },
                        {
                            label: '포인트',
                            data: points,  // point 데이터를 Y축 값으로 사용
                            backgroundColor: 'rgba(255, 206, 86, 0.2)',
                            borderColor: 'rgba(255, 206, 86, 1)',
                            borderWidth: 1
                        }
                    ]
                }
            });
        } catch (error) {
            console.error('Error rendering chart:', error);
        }
    }

    // 페이지 로드 시 차트를 렌더링
    window.onload = renderChart();
</script>

		</div>

		<!-- 프로젝트 현황 테이블 -->
		<div class="project-status">
			<h3>프로젝트 현황</h3>
			<table>
				<thead>
					<tr>
						<th>프로젝트명</th>
						<th>제작자</th>
						<th>기간</th>
						<th>완료율</th>
						<th>예산</th>
						<th>수수료</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>애니메이션 제작 프로젝트</td>
						<td>홍길동</td>
						<td>2023-06-01 ~ 2023-09-01</td>
						<td>100%</td>
						<td>₩5,000,000</td>
						<td>₩500,000</td>
					</tr>
				</tbody>
			</table>
		</div>





	</div>

</body>
</html>