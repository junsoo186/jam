<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/user/myPage.css">
	<%@ include file="/WEB-INF/view/layout/header.jsp"%>


	<main>
		
		<section class="top--nav--area-menu">
			<div class="navbar">
				<a href="#">회원 관리</a>
				<a href="/pay/paylist">결제 내역</a>
				<a href="#">차단 관리</a>
				<a href="/write/workList">내 작품</a>
				<a href="/user/profileSetting">회원 정보 수정</a>
			</div>
		</section>

		<!-- 프로필 정보 섹션 -->
		<section class="profile-section">
			<div class="profile-info">

				<div class="profile-image">
					<img alt="Profile Image" src="${principal.profileImg}">
				</div>
				<div class="text--area">
					<p style="margin-top: 70px;">닉네임<div class="info-item"> ${principal.nickName}</div></p>
					<p>이메일<div class="info-item"> ${principal.email}</div></p>
					<p>전화번호
					<div class="info-item">
						<c:if test="${principal.phoneNumber eq null}">
                	정보없음
                </c:if>

						<c:if test="${principal.phoneNumber ne null}">
                	${principal.phoneNumber}
                </c:if>


					</div>
				</p>
					<p>주소
					<div class="info-item">
						<c:if test="${principal.address eq null}">
                        정보없음
                    </c:if>
						<c:if test="${principal.address ne null}">
                        ${principal.address}
                    </c:if>
					</div>
				</p>
				<p>생일
					<div class="info-item">
						<c:if test="${principal.birthDate eq null}">
                        정보없음
                    </c:if>
						<c:if test="${principal.birthDate ne null}">
                        ${principal.birthDate}
                    </c:if>
					</div>
				</p>
				<p>포인트
					<div class="info-item">
						<c:if test="${principal.point eq null}">
                        정보없음
                    </c:if>
						<c:if test="${principal.point ne null}">
                        ${principal.point}
                    </c:if>
					</div>
				</p>
				</div>
			</div>
			<div class="action-buttons">
			</div>
			<div>
				<div class="toggle-container">
					<div class="toggle-button" id="supporterButton" onclick="toggleButton('supporter')">
						<span>유저</span>
					</div>
					<div class="toggle-button" id="makerButton" onclick="toggleButton('maker')">
						<span>작가</span>
					</div>
				</div>
			</div>
			<!-- 펀딩 구분 섹션 -->
		<div class="info-section">
			<div class="info-item">
				<a href="#">펀딩 사업자 등록</a>

			</div>
		</div>
		</section>

		
		

	</main>
	<script type="text/javascript">
		var principalEmail = "<c:out value='${principal != null ? principal.email : "
		"}' />";

		function toggleButton(selected) {
			const supporterButton = document.getElementById('supporterButton');
			const makerButton = document.getElementById('makerButton');

			if (selected === 'supporter') {
				supporterButton.classList.add('active');
				makerButton.classList.remove('active');

				// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
				window.location.href = '/user/myPage'; // 컨트롤러 경로로 리다이렉트

				// 선택된 상태를 로컬 스토리지에 저장
				localStorage.setItem('selectedButton', 'supporter');

			} else {
				makerButton.classList.add('active');
				supporterButton.classList.remove('active');

				// 서포터(작가) 버튼 클릭 시 서버의 컨트롤러 경로로 이동
				window.location.href = '/write/workList'; // 컨트롤러 경로로 리다이렉트

				// 선택된 상태를 로컬 스토리지에 저장
				localStorage.setItem('selectedButton', 'maker');

			}
		}

		// 페이지 로드 시 로컬 스토리지에서 선택된 버튼 상태를 불러와 유지
		window.onload = function() {
			const selectedButton = localStorage.getItem('selectedButton');
			const supporterButton = document.getElementById('supporterButton');
			const makerButton = document.getElementById('makerButton');

			// 로그인된 사용자의 email이 있을 경우 "유저" 버튼을 활성화
			if (!selectedButton && principalEmail !== "") {
				supporterButton.classList.add('active');
				makerButton.classList.remove('active');
				sessionStorage.setItem('selectedButton', 'supporter'); // 기본값으로 저장
			} else if (selectedButton === 'supporter') {
				supporterButton.classList.add('active');
				makerButton.classList.remove('active');
			} else if (selectedButton === 'maker') {
				makerButton.classList.add('active');
				supporterButton.classList.remove('active');
			}
		}
	</script>