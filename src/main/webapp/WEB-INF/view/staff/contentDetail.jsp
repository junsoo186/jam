<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <div id="projectModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>프로젝트 상세</h2>
                    <table>
                        <tr>
                            <th>프로젝트명</th>
                            <td>${project.title}</td>
                        </tr>
                        <tr>
                            <th>제작자</th>
                            <td>${project.author}</td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td>
                                <fmt:formatDate value="${project.createdAt}" pattern="yyyy-MM-dd" /> ~
                                <fmt:formatDate value="${project.dateEnd}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                        <tr>
                            <th>목표 금액</th>
                            <td>₩${project.goal}</td>
                        </tr>
                    </table>
                    <div class="modal-actions">
                        <c:if test="${project.staffAgree != 'Y'}">
                            <button class="modal-btn approve">승인</button>
                            <button class="modal-btn reject">거부</button>
                        </c:if>
                    </div>
                </div>
            </div>