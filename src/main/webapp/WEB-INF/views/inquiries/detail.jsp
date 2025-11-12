<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${sessionScope.role eq 'ADMIN'}">
        <jsp:include page="/WEB-INF/views/admin/admin-header.jsp" />
    </c:when>
    <c:when test="${sessionScope.role eq 'MANAGER'}">
        <jsp:include page="/WEB-INF/views/manager/manager-header.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/member/member-header.jsp" />
    </c:otherwise>
</c:choose>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<div class="container">
    <h1>문의사항 상세보기</h1>

    <div class="detail-header">
        <div class="detail-title">${inquiry.title}</div>
        <div class="detail-meta">
                <span>
                    <strong>작성자:</strong>
                    ${inquiry.writer}
                </span>
            <span>
                    <strong>작성일:</strong>
                    ${inquiry.createdAt}
                </span>
            <span>
                    <strong>정보수정일:</strong>
                    ${inquiry.updatedAt}
                </span>
        </div>
    </div>

    <div class="detail-content">
        ${inquiry.content}
    </div>

    <div class="button-group">
        <div class="button-left">
            <a href="/inquiries" class="btn btn-secondary">목록으로</a>
        </div>

        <c:if test="${sessionScope.loginId == inquiry.writer}">
            <div class="button-left">
                <a href="/inquiries/${inquiry.inquiryId}/edit"
                   class="btn btn-primary">수정</a>

                <form method="post"
                      action="/inquiries/${inquiry.inquiryId}/delete"
                      class="delete-form"
                      onsubmit="return confirmDelete()">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </div>
        </c:if>
    </div>

    <!-- 답글 섹션 -->
    <div class="reply-section">
        <div class="reply-header">
            <h2>답글 목록 (<span id="replyCount">0</span>)</h2>
            <button class="btn btn-success" onclick="openCreateModal()">답글 작성</button>
        </div>

        <div id="replyList">
            <div class="empty-message">답글을 불러오는 중...</div>
        </div>
    </div>
</div>

<!-- 답글 상세보기 모달 -->
<div id="detailModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">답글 상세보기</h3>
            <button class="close" onclick="closeDetailModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div class="reply-detail-meta">
                <div><strong>작성자:</strong> <span id="detailWriter"></span></div>
                <div><strong>작성일:</strong> <span id="detailCreatedAt"></span></div>
                <div><strong>수정일:</strong> <span id="detailUpdatedAt"></span></div>
            </div>
            <div class="reply-detail-content" id="detailContent"></div>
        </div>
        <div class="modal-footer" id="detailModalFooter">
            <button class="btn btn-secondary" onclick="closeDetailModal()">닫기</button>
        </div>
    </div>
</div>

<!-- 답글 작성/수정 모달 -->
<div id="formModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title" id="formModalTitle">답글 작성</h3>
            <button class="close" onclick="closeFormModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="replyForm">
                <input type="hidden" id="replyId" name="replyId">

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" class="form-control"
                              placeholder="답글 내용을 입력하세요" required></textarea>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeFormModal()">취소</button>
            <button class="btn btn-primary" onclick="submitReply()">저장</button>
        </div>
    </div>
</div>

<script>
    const inquiryId = ${inquiry.inquiryId};
    const loginId = '${sessionScope.loginId}';
    let currentReply = null;

    // 페이지 로드 시 답글 목록 조회
    document.addEventListener('DOMContentLoaded', function() {
        loadReplies();
    });

    // 답글 목록 조회
    async function loadReplies() {
        try {
            const response = await axios.get('/api/inquiries/' + inquiryId + '/replies');
            const replies = Array.isArray(response.data) ? response.data : [];

            document.getElementById('replyCount').textContent = replies.length;

            const replyList = document.getElementById('replyList');

            if (replies.length === 0) {
                replyList.innerHTML = '<div class="empty-message">등록된 답글이 없습니다.</div>';
                return;
            }

            replyList.innerHTML = replies.map(reply => {
                const safeContent = escapeHtml(reply.content || '');
                const safeWriter = escapeHtml(reply.writer || '');
                const safeDate = reply.createdAt || '';

                return `
                <div class="reply-item" onclick="showReplyDetail(${reply.replyId})">
                    <div class="reply-item-header">
                        <span class="reply-writer">${safeWriter}</span>
                        <span class="reply-date">${safeDate}</span>
                    </div>
                    <div class="reply-content-preview">${safeContent}</div>
                </div>
            `;
            }).join('');
        } catch (error) {
            console.error('답글 목록 조회 실패:', error);
            alert('답글 목록을 불러오는데 실패했습니다.');
        }
    }

    // 답글 상세보기
    async function showReplyDetail(replyId) {
        console.log("replyId: ", replyId);
        try {
            const response = await axios.get('/api/inquiries/' + inquiryId + '/reply/' + replyId);
            currentReply = response.data;

            const writerEl = document.getElementById('detailWriter');
            const createdEl = document.getElementById('detailCreatedAt');
            const updatedEl = document.getElementById('detailUpdatedAt');
            const contentEl = document.getElementById('detailContent');

            if (writerEl) writerEl.textContent = currentReply.writer || '';
            if (createdEl) createdEl.textContent = currentReply.createdAt || '';
            if (updatedEl) updatedEl.textContent = currentReply.updatedAt || '';
            if (contentEl) contentEl.textContent = currentReply.content || '';

            const footer = document.getElementById('detailModalFooter');
            if (footer) {
                if (loginId === currentReply.writer) {
                    footer.innerHTML = `
                    <button class="btn btn-secondary" onclick="closeDetailModal()">닫기</button>
                    <button class="btn btn-primary" onclick="openEditModal()">수정</button>
                    <button class="btn btn-danger" onclick="deleteReply()">삭제</button>
                `;
                } else {
                    footer.innerHTML = `
                    <button class="btn btn-secondary" onclick="closeDetailModal()">닫기</button>
                `;
                }
            }

            document.getElementById('detailModal').classList.add('show');
        } catch (error) {
            console.error('답글 상세 조회 실패:', error);
            alert('답글을 불러오는데 실패했습니다.');
        }
    }

    // 답글 작성 모달 열기
    function openCreateModal() {
        document.getElementById('formModalTitle').textContent = '답글 작성';
        document.getElementById('replyForm').reset();
        document.getElementById('replyId').value = '';
        document.getElementById('formModal').classList.add('show');
    }

    // 답글 수정 모달 열기
    function openEditModal() {
        closeDetailModal();
        document.getElementById('formModalTitle').textContent = '답글 수정';
        document.getElementById('replyId').value = currentReply.replyId;
        document.getElementById('content').value = currentReply.content;
        document.getElementById('formModal').classList.add('show');
    }

    // 답글 저장 (작성/수정)
    async function submitReply() {
        const replyId = document.getElementById('replyId').value;
        const content = document.getElementById('content').value.trim();

        if (!content) {
            alert('내용을 입력해주세요.');
            return;
        }

        const replyDTO = {
            content: content,
            writer: loginId
        };

        try {
            if (replyId) {
                // 수정
                await axios.put('/api/inquiries/' + inquiryId + '/reply/' + replyId, replyDTO);
                alert('답글이 수정되었습니다.');
            } else {
                // 작성
                await axios.post('/api/inquiries/' + inquiryId + '/reply', replyDTO);
                alert('답글이 등록되었습니다.');
            }

            closeFormModal();
            loadReplies();
        } catch (error) {
            console.error('답글 저장 실패:', error);
            alert('답글 저장에 실패했습니다.');
        }
    }

    // 답글 삭제
    async function deleteReply() {
        if (!confirm('정말 삭제하시겠습니까?')) {
            return;
        }

        try {
            await axios.delete('/api/inquiries/' + inquiryId + '/reply/' + currentReply.replyId);
            alert('답글이 삭제되었습니다.');
            closeDetailModal();
            loadReplies();
        } catch (error) {
            console.error('답글 삭제 실패:', error);
            alert('답글 삭제에 실패했습니다.');
        }
    }

    // 모달 닫기
    function closeDetailModal() {
        document.getElementById('detailModal').classList.remove('show');
        currentReply = null;
    }

    function closeFormModal() {
        document.getElementById('formModal').classList.remove('show');
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        const detailModal = document.getElementById('detailModal');
        const formModal = document.getElementById('formModal');

        if (event.target === detailModal) {
            closeDetailModal();
        }
        if (event.target === formModal) {
            closeFormModal();
        }
    }

    // HTML 이스케이프 함수
    function escapeHtml(text) {
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.toString().replace(/[&<>"']/g, function(m) { return map[m]; });
    }

    // 문의글 삭제 확인
    function confirmDelete() {
        return confirm('정말 삭제하시겠습니까?');
    }
</script>

<c:choose>
    <c:when test="${sessionScope.role eq 'ADMIN'}">
        <jsp:include page="/WEB-INF/views/admin/admin-footer.jsp" />
    </c:when>
    <c:when test="${sessionScope.role eq 'MANAGER'}">
        <jsp:include page="/WEB-INF/views/manager/manager-footer.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/member/member-footer.jsp" />
    </c:otherwise>
</c:choose>