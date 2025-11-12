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

<div class="container">
    <div class="header">
        <h1>거래처 관리</h1>
    </div>

    <div class="content">
        <!-- 거래처 목록 -->
        <div class="partner-list">
            <c:forEach items="${partners}" var="partner">
                <div class="partner-item" onclick="loadPartnerDetail(${partner.partnerId})">
                    <div class="partner-name">${partner.partnerName}</div>
                    <div class="partner-info">
                        사업자번호: ${partner.businessNumber}<br>
                        <fmt:formatDate value="${partner.createdAt}" pattern="yyyy-MM-dd" />
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty partners}">
                <div class="empty-state">
                    <div class="empty-state-icon">📋</div>
                    <div>등록된 거래처가 없습니다</div>
                </div>
            </c:if>
        </div>

        <!-- 거래처 상세 정보 -->
        <div class="partner-detail" id="partnerDetail">
            <div class="empty-state">
                <div class="empty-state-icon">👈</div>
                <div>거래처를 선택해주세요</div>
            </div>
        </div>
    </div>
</div>

<script>
    function loadPartnerDetail(partnerId) {
        // 활성화 상태 변경
        document.querySelectorAll('.partner-item').forEach(item => {
            item.classList.remove('active');
        });
        event.currentTarget.classList.add('active');

        // 로딩 표시
        document.getElementById('partnerDetail').innerHTML = '<div class="loading">로딩 중...</div>';

        // AJAX 요청
        fetch('/partner/detail/' + partnerId)
            .then(response => response.json())
            .then(data => {
                displayPartnerDetail(data);
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('partnerDetail').innerHTML =
                    '<div class="empty-state"><div>데이터를 불러오는데 실패했습니다</div></div>';
            });
    }

    function displayPartnerDetail(data) {
        const partner = data.partner;
        const fees = data.fees || [];
        const contracts = data.contracts || [];

        let html = '';

        // 기본 정보
        html += '<div class="detail-section">';
        html += '<h2 class="section-title">기본 정보</h2>';
        html += '<div class="info-grid">';
        html += '<div class="info-item"><div class="info-label">거래처명</div><div class="info-value">' + partner.partnerName + '</div></div>';
        html += '<div class="info-item"><div class="info-label">사업자번호</div><div class="info-value">' + (partner.businessNumber || '-') + '</div></div>';
        html += '<div class="info-item" style="grid-column: 1 / -1;"><div class="info-label">주소</div><div class="info-value">' + (partner.address || '-') + '</div></div>';
        html += '<div class="info-item"><div class="info-label">등록일</div><div class="info-value">' + formatDateTime(partner.createdAt) + '</div></div>';
        html += '<div class="info-item"><div class="info-label">수정일</div><div class="info-value">' + formatDateTime(partner.updatedAt) + '</div></div>';
        html += '</div>';
        html += '</div>';

        // 요금 정책
        html += '<div class="detail-section">';
        html += '<h2 class="section-title">요금 정책</h2>';
        if (fees.length > 0) {
            html += '<table><thead><tr>';
            html += '<th>요금 ID</th><th>요금 유형</th><th>가격</th><th>적용일</th>';
            html += '</tr></thead><tbody>';
            fees.forEach(fee => {
                html += '<tr>';
                html += '<td>' + fee.feeId + '</td>';
                html += '<td>' + fee.feeType + '</td>';
                html += '<td>' + (fee.price ? fee.price.toLocaleString() + '원' : '-') + '</td>';
                html += '<td>' + formatDateTime(fee.applyDate) + '</td>';
                html += '</tr>';
            });
            html += '</tbody></table>';
        } else {
            html += '<div class="empty-state" style="padding: 30px;"><div>등록된 요금 정책이 없습니다</div></div>';
        }
        html += '</div>';

        // 계약 정보
        html += '<div class="detail-section">';
        html += '<h2 class="section-title">계약 정보</h2>';
        if (contracts.length > 0) {
            html += '<table><thead><tr>';
            html += '<th>계약 ID</th><th>계약 시작일</th><th>계약 면적 (㎡)</th><th>상태</th>';
            html += '</tr></thead><tbody>';
            contracts.forEach(contract => {
                html += '<tr>';
                html += '<td>' + contract.contractId + '</td>';
                html += '<td>' + (contract.contractStart || '-') + '</td>';
                html += '<td>' + (contract.contractArea ? contract.contractArea.toLocaleString() : '-') + '</td>';
                html += '<td>';
                if (contract.status === 'ACTIVE') {
                    html += '<span class="badge badge-active">활성</span>';
                } else if (contract.status === 'PENDING') {
                    html += '<span class="badge badge-pending">대기</span>';
                } else if (contract.status === 'COMPLETED') {
                    html += '<span class="badge badge-inactive">완료</span>';
                } else {
                    html += '<span class="badge badge-inactive">' + contract.status + '</span>';
                }
                html += '</td>';
                html += '</tr>';
            });
            html += '</tbody></table>';
        } else {
            html += '<div class="empty-state" style="padding: 30px;"><div>등록된 계약 정보가 없습니다</div></div>';
        }
        html += '</div>';

        document.getElementById('partnerDetail').innerHTML = html;
    }

    function formatDateTime(dateTime) {
        if (!dateTime) return '-';
        const date = new Date(dateTime);
        return date.getFullYear() + '-' +
            String(date.getMonth() + 1).padStart(2, '0') + '-' +
            String(date.getDate()).padStart(2, '0') + ' ' +
            String(date.getHours()).padStart(2, '0') + ':' +
            String(date.getMinutes()).padStart(2, '0');
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


