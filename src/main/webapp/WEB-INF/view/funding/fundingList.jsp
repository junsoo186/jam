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

                </html>