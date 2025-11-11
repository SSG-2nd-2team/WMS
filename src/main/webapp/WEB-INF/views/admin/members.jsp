<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>              
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="admin-header.jsp" %>

    <div class="container">
        <h1>고객 관리</h1>

        <!-- 검색 조건 컨테이너 -->
        <div class="search-container" >
            <div class="search-title">검색 조건</div>
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/members">
                <div class="form-group">
                    <label for="keyword">검색어 (이름/아이디)</label>
                    <input type="text" id="keyword" name="keyword"
                           placeholder="이름 또는 아이디를 입력하세요"
                           value="${criteria.keyword}">
                </div>

                <div class="form-group">
                    <label for="status">상태</label>
                    <select id="status" name="status">
                        <option value="">전체</option>
                        <option value="ACTIVE" ${criteria.status == 'ACTIVE' ? 'selected' : ''}>활성</option>
                        <option value="INACTIVE" ${criteria.status == 'INACTIVE' ? 'selected' : ''}>비활성</option>
                        <option value="REJECTED" ${criteria.status == 'REJECTED' ? 'selected' : ''}>승인 거절</option>
                        <option value="PENDING" ${criteria.status == 'PENDING' ? 'selected' : ''}>승인 대기</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="startDate">생성일 (시작)</label>
                    <input type="date" id="startDate" name="startDate"
                           value="${criteria.startDate}">
                </div>

                <div class="form-group">
                    <label for="endDate">생성일 (종료)</label>
                    <input type="date" id="endDate" name="endDate"
                           value="${criteria.endDate}">
                </div>

                <div class="button-group">
                    <button type="reset" class="btn btn-reset">초기화</button>
                    <button type="submit" class="btn btn-search">검색</button>
                </div>
            </form>
        </div>

        <!-- 고객 목록 컨테이너 -->
        <div class="list-container">
            <div class="list-header">
                <div class="list-title">고객 목록</div>
                <div class="total-count">전체 <strong>${totalCount != null ? totalCount : 0}</strong>명</div>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>상태</th>
                        <th>생성일</th>
                        <th>수정일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty members}">
                            <tr>
                                <td colspan="7" class="no-data">조회된 고객이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="member" items="${members}" varStatus="status">
                                <tr onclick="viewMemberDetail(${member.memberId})">
                                    <td>${status.count}</td>
                                    <td>${member.memberLoginId}</td>
                                    <td>${member.memberName}</td>
                                    <td>${member.memberEmail}</td>
                                    <td>
                                            <span class="status-badge
                                                ${member.status == 'ACTIVE' ? 'status-active' :
                                                  member.status == 'INACTIVE' ? 'status-inactive' :
                                                  member.status == 'REJECTED' ? 'status-rejected' :
                                                  'status-pending'}">
                                                    ${member.status == 'ACTIVE' ? '활성' :
                                                            member.status == 'INACTIVE' ? '비활성' :
                                                                    member.status == 'REJECTED' ? '정지' :
                                                                            member.status == 'PENDING' ? '승인 대기' : member.status}
                                            </span>
                                    </td>
                                    <td>
                                        ${member.createdAt}
                                    </td>
                                    <td>
                                        ${member.updatedAt}
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 📌 페이지네이션 -->
            <c:if test="${pageDTO.total > 0}">
                <div class="pagination">
                    <c:if test="${pageDTO.prev}">
                        <a href="?pageNum=${pageDTO.startPage - 1}&keyword=${criteria.keyword}&status=${criteria.status}&startDate=${criteria.startDate}&endDate=${criteria.endDate}">이전</a>
                    </c:if>

                    <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="i">
                        <a class="${i == pageDTO.pageNum ? 'active' : ''}"
                           href="?pageNum=${i}&keyword=${criteria.keyword}&status=${criteria.status}&startDate=${criteria.startDate}&endDate=${criteria.endDate}">
                                ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${pageDTO.next}">
                        <a href="?pageNum=${pageDTO.endPage + 1}&keyword=${criteria.keyword}&status=${criteria.status}&startDate=${criteria.startDate}&endDate=${criteria.endDate}">다음</a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

<!-- 🟦 상세 모달 -->
<div id="memberModal" class="modal" style="display:none;">
    <div class="modal-content">
        <div class="modal-header">
            <h2>고객 상세 정보</h2>
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
        <div id="modalBody"></div>
        <div id="modalFooter"></div>
    </div>
</div>


<script>
    // 상세 정보 조회
    function viewMemberDetail(memberId){
        fetch(`/admin/members/${memberId}`)
            .then(resp => resp.json())
            .then(member => {
                document.getElementById('modalBody').innerHTML = `
                <p><strong>아이디:</strong> ${member.loginId}</p>
                <p><strong>이름:</strong> ${member.name}</p>
                <p><strong>이메일:</strong> ${member.email}</p>
                <p><strong>상태:</strong> ${member.status}</p>
                <p><strong>생성일:</strong> ${member.createdAt}</p>
                <p><strong>수정일:</strong> ${member.updatedAt}</p>
            `;

                let footer = document.getElementById('modalFooter');
                footer.innerHTML = "";

                if(member.status === 'PENDING'){
                    footer.innerHTML = `
                    <button onclick="approveMember(${member.memberId})" class="btn btn-approve">승인</button>
                    <button onclick="rejectMember(${member.memberId})" class="btn btn-reject">거절</button>
                `;
                }

                document.getElementById('memberModal').style.display = 'block';
            });
    }

    // 승인 처리
    function approveMember(memberId){
        fetch(`/admin/members/${memberId}/approve`, { method: 'POST' })
            .then(() => { alert("승인 완료되었습니다."); location.reload(); });
    }

    // 거절 처리
    function rejectMember(memberId){
        fetch(`/admin/members/${memberId}/reject`, { method: 'POST' })
            .then(() => { alert("거절 처리하였습니다."); location.reload(); });
    }

    // 모달 닫기
    function closeModal(){
        document.getElementById('memberModal').style.display = 'none';
    }
</script>

<!-- / Content -->
<%@ include file="admin-footer.jsp" %>
