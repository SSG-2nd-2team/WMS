<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항 작성</h1>

    <div class="info-box">
        <p>공지사항을 작성해주세요. 모든 사용자가 볼 수 있습니다.</p>
    </div>

    <form method="post" action="/announcements/save">
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
                   value="${announcement.title}"
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
                      required>${announcement.content}</textarea>
            <c:if test="${not empty errors.content}">
                <span class="error">${errors.content}</span>
            </c:if>
        </div>

        <div class="checkbox-group">
            <input type="checkbox" id="important" name="important"
                   value="true" ${announcement.important ? 'checked' : ''}/>
            <label for="important">⭐ 중요 공지로 설정</label>
        </div>

        <div class="button-group">
            <a href="/announcements" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-primary">등록</button>
        </div>
    </form>
</div>
<%@ include file="../admin/admin-footer.jsp" %>
