<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항 상세보기</h1>

    <div class="detail-header">
        <div class="detail-title">${announcement.title}</div>
        <div class="detail-meta">
                <span>
                    <strong>작성자:</strong> ${announcement.authorName}
                </span>
            <span>
                    <strong>작성일:</strong>
                    <fmt:formatDate value="${announcement.createdAt}"
                                    pattern="yyyy-MM-dd HH:mm"/>
                </span>
            <span>
                    <strong>조회수:</strong> ${announcement.viewCount}
                </span>
        </div>
    </div>

    <div class="detail-content">
        ${announcement.content}
    </div>

    <div class="button-group">
        <div class="button-left">
            <a href="/announcements" class="btn btn-secondary">목록으로</a>
        </div>

        <c:if test="${sessionScope.userRole == 'ADMIN'}">
            <div class="button-left">
                <a href="/announcements/${announcement.id}/edit"
                   class="btn btn-primary">수정</a>

                <form method="post"
                      action="/announcements/${announcement.id}/delete"
                      class="delete-form"
                      onsubmit="return confirmDelete()">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="../admin/admin-footer.jsp" %>