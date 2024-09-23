<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <title>Q&A 상세보기</title>
                <link rel="stylesheet" href="/css/noticeInsert.css">
            </head>

            <body>

                <main>
                    <div class="container p-5">
                        <div class="card">
                            <div class="card-header">
                                <b>Q&A 상세보기</b>
                            </div>

                            <!-- QnA 질문 내용 -->
                            <div class="mb-3"><strong>제목:</strong> ${qna.title}</div>
                            <div class="mb-3"><strong>작성자:</strong> ${qna.userName}</div>
                            <div class="mb-3"><strong>내용:</strong> ${qna.questionContent}</div>
                            <div class="mb-3">
                                <strong>작성일:</strong>
                                <fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                            </div>


                            <!-- QnA 답변 부분 -->
                            <c:choose>
                                <c:when test="${qna.answerContent != null}">
                                    <div class="mb-3"><strong>답변:</strong> ${qna.answerContent}</div>
                                    <form action="/staff/deleteAnswer/${qna.qnaId}" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-danger">답변 삭제</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="mb-3"><strong>답변:</strong> 아직 답변이 없습니다.</div>

                                    <!-- 답변 남기기 폼 -->
                                    <form action="/staff/qnaAnswer" method="post">
                                        <input type="hidden" name="qnaId" value="${qna.qnaId}">
                                        <div class="form-group">
                                            <label for="answerContent">답변 작성</label>
                                            <textarea id="answerContent" name="answerContent" rows="5"
                                                class="form-control" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary mt-3">답변 남기기</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </main>

            </body>

            </html>