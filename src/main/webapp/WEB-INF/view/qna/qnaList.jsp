<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ include file="/WEB-INF/view/layout/header.jsp" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <link rel="stylesheet" href="/css/qnaList.css">
                <link rel="stylesheet" href="/css/qnaList.css">
                <link rel="stylesheet" href="/css/layout/page.css">
                <link rel="stylesheet" href="/css/banner.css">
                
                <main>
                    <section class="top--banner--area">
                        <c:forEach items="${banner}" var="bannerItem" varStatus="status">
                            <div class="banner--content" style="display: ${status.index == 0 ? 'block' : 'none'};">
                                <img src="${bannerItem.imagePath}" alt="배너 이미지" class="banner-img" />
                            </div>
                        </c:forEach>
                    </section>

                    <div class="container mt-5">
                        <div class="titlle"><p>Q&A</p></div>
                        <button type="submit" class="btn btn-danger" onclick="window.location.href='write';">문의
                            남기기</button>
                        <table class="table table-striped mt-3">
                            <thead>
                           
                                <tr>
                            
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                        
                                </tr>
                            
                            </thead>
                            <tbody>
                                <c:forEach var="qna" items="${qnaList}" varStatus="status">
                              
                                        <tr>
                                            
                                            <td><a href="/qna/detail/${qna.qnaId}">${qna.title}</a></td>
                                            <td>${qna.userName}</td>
                                            <td>
                                                <fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                            </td>
                                            <td>
                                                <%-- <form action="/notice/delete" method="post" class="d-inline">
                                                    <input type="hidden" name="staffId" value="${qna.staffId}">
                                                    <button type="submit" class="btn btn-danger">삭제</button>
                                                    </form> --%>
                                            </td>
                                        </tr>
                                    </a>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                   


                    <div class="flex--page">
						<div class="pagination">
							<!-- 이전 페이지 버튼 -->
							<c:if test="${currentPage > 1}">
								<a href="?type=${type}&page=${currentPage - 1}&size=${size}">&laquo; 이전</a>
							</c:if>
					
							<!-- 페이지 번호 링크 -->
							<c:forEach var="i" begin="1" end="${totalPages}">
								<a href="?type=${type}&page=${page}&size=${size}" class="${i == currentPage ? 'active' : ''}">${i}</a>
							</c:forEach>
					
							<!-- 다음 페이지 버튼 -->
							<c:if test="${currentPage < totalPages}">
								<a href="?type=${type}&page=${currentPage + 1}&size=${size}">다음 &raquo;</a>
							</c:if>
						</div>
					</div>


                </main>
                <script type="text/javascript" src="/js/banner.js"></script>
                <script type="text/javascript" src="/js/page.js"></script>
                <%@ include file="/WEB-INF/view/layout/footer.jsp" %>