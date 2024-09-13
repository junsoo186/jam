<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ include file="/WEB-INF/view/layout/header.jsp" %>
                <link rel="stylesheet" href="/css/funding/fundingList.css">

                <body>
                    <main>
                        <c:choose>
                            <c:when test="${project.staffAgree eq Y}">
                                <div class="project-container">
                                    <c:forEach items="${projectList}" var="project" varStatus="status">
                                        <form action="/funding/fundingDetail" method="get" class="project-form">
                                            <div class="project-card" data-goal="${project.goal}"
                                                data-current="${project.totalAmount}"
                                                data-end-date="${project.dateEnd}">
                                                <div class="project-image">
                                                    <img alt="프로젝트 이미지" src="${project.mainImg}" class="project-img">
                                                </div>
                                                <div class="project-info">
                                                    <div class="project-title">${project.title}</div>
                                                    <div class="project-author">${project.author}</div>
                                                    <div class="project-comment">${project.onelineComment}</div>
                                                    <div class="progress-info">
                                                        <span class="progress-percentage"
                                                            id="progress-percentage-${status.index}"></span>
                                                        <span class="progress-funding"
                                                            id="progress-funding-${status.index}"></span>
                                                    </div>
                                                    <div class="progress-bar-container">
                                                        <div class="progress-bar" id="progress-bar-${status.index}">
                                                        </div>
                                                    </div>
                                                    <div class="progress-days" id="progress-days-${status.index}"></div>
                                                </div>
                                                <input type="hidden" name="projectId" value="${project.projectId}">
                                            </div>
                                        </form>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <h3>진행 중인 프로젝트가 없습니다 !</h3>
                            </c:otherwise>
                        </c:choose>
                    </main>
                    <script src="/js/funding/fundingList.js"></script>
                </body>