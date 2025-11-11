<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항 수정</h1>

    <div class="info-box">
        <p>공지사항을 수정하시겠습니까? 수정된 내용은 즉시 반영됩니다.</p>
    </div>

    <form:form method="post" action="/announcements/${announcement.id}/edit"
               modelAttribute="announcement">
        <form:hidden path="id"/>

        <div class="form-group">
            <label for="title">
                제목 <span class="required">*</span>
            </label>
            <form:input path="title" id="title"
                        cssClass="${bindingResult.hasFieldErrors('title') ? 'error-field' : ''}"
                        placeholder="제목을 입력하세요"/>
            <form:errors path="title" cssClass="error"/>
        </div>

        <div class="form-group">
            <label for="content">
                내용 <span class="required">*</span>
            </label>
            <form:textarea path="content" id="content"
                           cssClass="${bindingResult.hasFieldErrors('content') ? 'error-field' : ''}"
                           placeholder="내용을 입력하세요"/>
            <form:errors path="content" cssClass="error"/>
        </div>

        <div class="button-group">
            <a href="/announcements/${announcement.id}" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-primary">수정완료</button>
        </div>
    </form:form>
</div>
<%@ include file="../admin/admin-footer.jsp" %>

