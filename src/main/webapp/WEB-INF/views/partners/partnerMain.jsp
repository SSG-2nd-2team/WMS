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
    <div class="header">
        <h1>🏢 거래처 관리</h1>
        <p>거래처 정보 및 계약 현황을 확인하세요</p>
    </div>

    <div class="content-wrapper">
        <!-- 사이드바 -->
        <div class="sidebar">
            <div class="search-box">
                <input type="text"
                       class="search-input"
                       placeholder="🔍 거래처명 또는 사업자번호 검색..."
                       onkeyup="filterPartners(this.value)">
            </div>

            <div class="partner-list" id="partnerList">
                <c:forEach items="${partners}" var="partner">
                    <div class="partner-card"
                         data-partner-id="${partner.partnerId}"
                         data-partner-name="${partner.partnerName}"
                         data-business-number="${partner.businessNumber}"
                         onclick="loadPartnerDetail(${partner.partnerId})">
                        <div class="partner-name">${partner.partnerName}</div>
                        <div class="partner-meta">
                            <div class="meta-item">
                                <span class="meta-icon">📋</span>
                                    ${partner.businessNumber}
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <c:choose>
                                    <c:when test="${not empty partner.address}">
                                        ${partner.address}
                                    </c:when>
                                    <c:otherwise>
                                        주소 미등록
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty partners}">
                    <div class="no-data">
                        <div class="no-data-icon">📦</div>
                        <div>등록된 거래처가 없습니다</div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="main-content" id="mainContent">
            <div class="empty-state">
                <div class="empty-icon">👈</div>
                <div class="empty-text">거래처를 선택해주세요</div>
            </div>
        </div>
    </div>
</div>

<script>
    let currentPartnerId = null;

    // 거래처 필터링
    function filterPartners(searchText) {
        const cards = document.querySelectorAll('.partner-card');
        const search = searchText.toLowerCase().trim();

        cards.forEach(card => {
            const name = card.dataset.partnerName.toLowerCase();
            const businessNumber = card.dataset.businessNumber.toLowerCase();

            if (name.includes(search) || businessNumber.includes(search)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // 거래처 상세 정보 로드
    function loadPartnerDetail(partnerId) {
        if (currentPartnerId === partnerId) return;
        currentPartnerId = partnerId;

        // 활성화 상태 변경
        document.querySelectorAll('.partner-card').forEach(card => {
            card.classList.remove('active');
            if (parseInt(card.dataset.partnerId) === partnerId) {
                card.classList.add('active');
            }
        });

        // 로딩 표시
        document.getElementById('mainContent').innerHTML = `
                <div class="loading">
                    <div class="loading-spinner"></div>
                    <div class="loading-text">데이터를 불러오는 중...</div>
                </div>
            `;

        // AJAX 요청
        fetch('/partner/detail/' + partnerId)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                displayPartnerDetail(data);
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('mainContent').innerHTML = `
                        <div class="empty-state">
                            <div class="empty-icon">❌</div>
                            <div class="empty-text">데이터를 불러오는데 실패했습니다</div>
                        </div>
                    `;
            });
    }

    // 거래처 상세 정보 표시
    function displayPartnerDetail(data) {
        const partner = data.partner;
        const fees = data.fees || [];
        const contracts = data.contracts || [];

        if (!partner) {
            document.getElementById('mainContent').innerHTML = `
                    <div class="empty-state">
                        <div class="empty-icon">❌</div>
                        <div class="empty-text">거래처 정보를 찾을 수 없습니다</div>
                    </div>
                `;
            return;
        }

        let html = '';

        // 헤더
        html += '<div class="detail-header">';
        html += '<div>';
        html += '<div class="detail-title">' + escapeHtml(partner.partnerName) + '</div>';
        html += '<div class="detail-subtitle">사업자번호: ' + escapeHtml(partner.businessNumber) + '</div>';
        html += '</div>';
        html += '</div>';

        // 기본 정보 섹션
        html += '<div class="section">';
        html += '<h2 class="section-title">기본 정보</h2>';
        html += '<div class="info-grid">';

        html += '<div class="info-card">';
        html += '<div class="info-label">거래처 ID</div>';
        html += '<div class="info-value">' + partner.partnerId + '</div>';
        html += '</div>';

        html += '<div class="info-card">';
        html += '<div class="info-label">거래처명</div>';
        html += '<div class="info-value">' + escapeHtml(partner.partnerName) + '</div>';
        html += '</div>';

        html += '<div class="info-card">';
        html += '<div class="info-label">사업자번호</div>';
        html += '<div class="info-value">' + escapeHtml(partner.businessNumber) + '</div>';
        html += '</div>';

        html += '<div class="info-card">';
        html += '<div class="info-label">주소</div>';
        html += '<div class="info-value">' + (partner.address ? escapeHtml(partner.address) : '-') + '</div>';
        html += '</div>';

        html += '<div class="info-card">';
        html += '<div class="info-label">등록일시</div>';
        html += '<div class="info-value">' + formatDateTime(partner.createdAt) + '</div>';
        html += '</div>';

        html += '<div class="info-card">';
        html += '<div class="info-label">수정일시</div>';
        html += '<div class="info-value">' + formatDateTime(partner.updatedAt) + '</div>';
        html += '</div>';

        html += '</div>';
        html += '</div>';

        // 요금 정책 섹션
        html += '<div class="section">';
        html += '<h2 class="section-title">요금 정책</h2>';

        if (fees.length > 0) {
            html += '<table class="data-table">';
            html += '<thead><tr>';
            html += '<th>요금 ID</th>';
            html += '<th>요금 유형</th>';
            html += '<th>가격</th>';
            html += '<th>적용일</th>';
            html += '</tr></thead>';
            html += '<tbody>';

            fees.forEach(fee => {
                html += '<tr>';
                html += '<td>' + fee.feeId + '</td>';
                html += '<td>' + escapeHtml(fee.feeType) + '</td>';
                html += '<td>' + (fee.price ? formatNumber(fee.price) + '원' : '-') + '</td>';
                html += '<td>' + formatDateTime(fee.applyDate) + '</td>';
                html += '</tr>';
            });

            html += '</tbody></table>';
        } else {
            html += '<div class="no-data">';
            html += '<div class="no-data-icon">💰</div>';
            html += '<div>등록된 요금 정책이 없습니다</div>';
            html += '</div>';
        }

        html += '</div>';

        // 계약 정보 섹션
        html += '<div class="section">';
        html += '<h2 class="section-title">계약 정보</h2>';

        if (contracts.length > 0) {
            html += '<table class="data-table">';
            html += '<thead><tr>';
            html += '<th>계약 ID</th>';
            html += '<th>계약 시작일</th>';
            html += '<th>계약 면적</th>';
            html += '<th>상태</th>';
            html += '</tr></thead>';
            html += '<tbody>';

            contracts.forEach(contract => {
                html += '<tr>';
                html += '<td>' + contract.contractId + '</td>';
                html += '<td>' + formatDate(contract.contractStart) + '</td>';
                html += '<td>' + (contract.contractArea ? formatNumber(contract.contractArea) + ' ㎡' : '-') + '</td>';
                html += '<td>' + getStatusBadge(contract.status) + '</td>';
                html += '</tr>';
            });

            html += '</tbody></table>';
        } else {
            html += '<div class="no-data">';
            html += '<div class="no-data-icon">📄</div>';
            html += '<div>등록된 계약 정보가 없습니다</div>';
            html += '</div>';
        }

        html += '</div>';

        document.getElementById('mainContent').innerHTML = html;
    }

    // 상태 배지 생성
    function getStatusBadge(status) {
        if (!status) return '<span class="badge badge-inactive">미정</span>';

        const statusUpper = status.toUpperCase();

        if (statusUpper === 'ACTIVE') {
            return '<span class="badge badge-active">활성</span>';
        } else if (statusUpper === 'PENDING') {
            return '<span class="badge badge-pending">대기</span>';
        } else if (statusUpper === 'COMPLETED') {
            return '<span class="badge badge-completed">완료</span>';
        } else {
            return '<span class="badge badge-inactive">' + escapeHtml(status) + '</span>';
        }
    }

    // 날짜/시간 포맷
    function formatDateTime(dateTime) {
        if (!dateTime) return '-';

        const date = new Date(dateTime);
        if (isNaN(date.getTime())) return '-';

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');

        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
    }

    // 날짜 포맷
    function formatDate(date) {
        if (!date) return '-';

        // 이미 문자열 형태로 날짜가 오면 그대로 반환
        if (typeof date === 'string') {
            return date;
        }

        const d = new Date(date);
        if (isNaN(d.getTime())) return '-';

        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');

        return year + '-' + month + '-' + day;
    }

    // 숫자 포맷 (천단위 구분)
    function formatNumber(num) {
        if (!num && num !== 0) return '-';
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    // XSS 방지
    function escapeHtml(text) {
        if (!text) return '';

        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };

        return text.toString().replace(/[&<>"']/g, m => map[m]);
    }
</script>

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


