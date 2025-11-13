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
    <h1>문의사항 작성</h1>

    <div class="info-box">
        <p>문의사항을 작성해주세요. 모든 사용자가 볼 수 있습니다.</p>
    </div>

    <form method="post" action="/inquiries/save">
        <div class="form-group">
            <label for="writer">
                <strong>작성자:</strong>
                <input type="text" id="writer" name="writer"
                       value="${sessionScope.loginId}"
                        readonly>
            </label>
        </div>

        <div class="form-group">
            <label for="title">
                제목 <span class="required">*</span>
            </label>
            <input type="text" id="title" name="title"
                   value="${inquiry.title}"
                   placeholder="제목을 입력하세요"
                   required/>
            <c:if test="${not empty errors.title}">
                <span class="error">${errors.title}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="content">
                내용 <span class="required">*</span>
            </label>
            <textarea id="content" name="content"
                      placeholder="내용을 입력하세요"
                      required>${inquiry.content}</textarea>
            <c:if test="${not empty errors.content}">
                <span class="error">${errors.content}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="password">
                비밀번호 <span class="required">*</span>
            </label>
            <input type="password" id="password" name="password"
                   value=""
                   placeholder="****"
                   required/>
            <c:if test="${not empty errors.password}">
                <span class="error">${errors.password}</span>
            </c:if>
        </div>

        <div class="button-group">
            <a href="/inquiries" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-primary">등록</button>
        </div>
    </form>
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
