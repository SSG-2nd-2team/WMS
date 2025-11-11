<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항 작성</h1>

    <div class="info-box">
        <p>공지사항을 작성해주세요. 모든 사용자가 볼 수 있습니다.</p>
    </div>

    <form:form method="post" action="/announcements/save"
               modelAttribute="announcement">
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
            <a href="/announcements" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-primary">등록</button>
        </div>
    </form:form>
</div>
<%@ include file="../admin/admin-footer.jsp" %>
