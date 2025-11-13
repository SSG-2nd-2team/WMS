<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${sessionScope.role eq 'ADMIN'}">
        <jsp:include page="/WEB-INF/views/admin/admin-header.jsp" />
    </c:when>
    <c:when test="${sessionScope.role eq 'MANAGER'}">
        <jsp:include page="/WEB-INF/views/warehousemanager/manager-header.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/member/member-header.jsp" />
    </c:otherwise>
</c:choose>
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
<c:choose>
    <c:when test="${sessionScope.role eq 'ADMIN'}">
        <jsp:include page="/WEB-INF/views/admin/admin-footer.jsp" />
    </c:when>
    <c:when test="${sessionScope.role eq 'MANAGER'}">
        <jsp:include page="/WEB-INF/views/warehousemanager/manager-footer.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/member/member-footer.jsp" />
    </c:otherwise>
</c:choose>