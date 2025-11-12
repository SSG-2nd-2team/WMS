<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항 상세보기</h1>

    <div class="detail-header">
        <div class="detail-title">${announcement.title}</div>
        <div class="detail-meta">
            <span>
                <strong>작성자:</strong> ${announcement.writer}
            </span>
            <span>
                <strong>작성일:</strong>
                ${announcement.createdAt}
            </span>
                <strong>정보수정일:</strong>
                ${announcement.updatedAt}
            <span>
                    <strong>중요공지여부:</strong> ${announcement.important}
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

        <c:if test="${sessionScope.role == 'ADMIN' and sessionScope.loginId == announcement.writer}">
            <div class="button-left">
                <a href="/announcements/${announcement.announcementId}/edit"
                   class="btn btn-primary">수정</a>

                <form method="post"
                      action="/announcements/${announcement.announcementId}/delete"
                      class="delete-form"
                      onsubmit="return confirmDelete()">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="../admin/admin-footer.jsp" %>