<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../admin/admin-header.jsp" %>
<div class="container">
    <h1>공지사항</h1>

    <div class="header-actions">
        <form method="get" action="/announcements" class="search-box">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요"
                   value="${keyword}">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>

        <c:if test="${sessionScope.role == 'ADMIN'}">
            <a href="/announcements/save" class="btn btn-success">글쓰기</a>
        </c:if>
    </div>

    <table>
        <thead>
        <tr>
            <th style="width: 10%;">번호</th>
            <th style="width: 50%;">제목</th>
            <th style="width: 15%;">작성자</th>
            <th style="width: 15%;">작성일</th>
            <th style="width: 10%;">중요</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${empty announcements}">
                <tr>
                    <td colspan="5" class="no-data">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="announcement" items="${announcements}">
                    <tr>
                        <td>${announcement.announcementId}</td>
                        <td>
                            <a href="/announcements/${announcement.announcementId}" class="announcement-title">
                                    ${announcement.title}
                            </a>
                        </td>
                        <td>${announcement.writer}</td>
                        <td>
                            ${announcement.createdAt}
                        </td>
                        <td>${announcement.important}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- 페이징 -->
    <c:if test="${not empty announcements}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&keyword=${keyword}"
                   class="page-link">이전</a>
            </c:if>

            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <a href="?page=${i}&keyword=${keyword}"
                   class="page-link ${i == currentPage ? 'active' : ''}">
                        ${i}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&keyword=${keyword}"
                   class="page-link">다음</a>
            </c:if>
        </div>
    </c:if>
</div>
<%@ include file="../admin/admin-footer.jsp" %>