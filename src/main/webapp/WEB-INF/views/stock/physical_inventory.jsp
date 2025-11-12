<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageActive" value="physical_inventory" scope="request"/>

<%-- HEADER 포함 (admin-header.jsp) --%>
<%@ include file="../admin/admin-header.jsp" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">실사 등록</h5>
        </div>
        <div class="card-body">
            <form id="physicalInventoryForm" onsubmit="return false">

                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">실사일자</label>
                        <input type="date" id="piDate" name="piDate" class="form-control" required>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">실사 상태</label>
                        <select id="piState" name="piState" class="form-select" required>
                            <option value="예정">예정</option>
                            <option value="진행중">시작</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">담당자</label>
                        <select id="managerName" name="managerName" class="form-select" required>
                            <option value="1">김관리</option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mt-3">
                    <div class="col-md-3">
                        <label class="form-label">창고 이름</label>
                        <select id="warehouseName" name="warehouseId" class="form-select">
                            <option value="">선택</option>
                            <c:forEach var="item" items="${warehouseList}">
                                <option value="${item.id}">${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">섹션 이름</label>
                        <select id="sectionName" name="sectionId" class="form-select">
                            <option value="">선택</option>
                            <c:forEach var="item" items="${sectionList}">
                                <option value="${item.id}">${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-25" onclick="searchPhysicalInventoryList(1)">등록</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="card2">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">실사 리스트</h5>
        </div>
        <div class="card-body">
            <p class="text-muted">* 실사는 섹션 별로 이루어지며, 실제 수량 입력 후 '조정'이 가능합니다.</p>
            <div class="row g-3 mb-4">
                <div class="col-12 table-responsive">

                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>실사 ID</th>
                            <th>실사 일자</th>
                            <th>상품 ID</th>
                            <th>실사 상태</th>
                            <th>전산 수량</th>
                            <th>실제 수량</th>
                            <th>차이 수량</th>
                            <th>창고 이름</th>
                            <th>실사 섹션 이름</th>
                            <th>조정 여부</th>
                        </tr>
                        </thead>
                        <tbody id="pi-tbody">

                        <tr>
                            <td colspan="11" class="text-center">실사 정보를 불러오는 중입니다...</td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="card-footer">
            <div class="float-end">
                <ul class="pagination flex-wrap" id="pi-pagination-ul">
                </ul>
            </div>
        </div>
    </div>
</div>

<%-- FOOTER 포함 --%>
<%@ include file="../admin/admin-footer.jsp" %>

<script>
    <%--/**--%>
    <%-- * 드롭다운 선택 값을 수집하여 쿼리스트링을 생성 (실사 목록 조회용)--%>
    <%-- */--%>
    function getPhysicalInventorySearchParams(page) {
        // 실사 등록 폼에 있는 창고/섹션 정보만 목록 조회 필터로 사용 (검색 필터가 없다고 하셨으므로)
        const warehouseId = document.querySelector('#warehouseName').value;
        const sectionId = document.querySelector('#sectionName').value;

        const params = {
            page: page || 1,
            size: 10,
            warehouseId: warehouseId,
            sectionId: sectionId
        };

        const urlParams = new URLSearchParams();
        Object.keys(params).forEach(key => {
            if (params[key] !== '') urlParams.append(key, params[key]);
        });

        return urlParams.toString();
    }

    <%--/**--%>
    <%-- * 2. 실사 목록 조회 (등록 후 또는 페이지네이션 클릭 시 호출)--%>
    <%-- */--%>
    function searchPhysicalInventoryList(_page) {
        document.getElementById('pi-tbody').innerHTML = '<tr><td colspan="10" class="text-center">실사 목록 검색 중...</td></tr>';

        <%--const queryString = `page=${page || 1}&size=10`; // 기본 페이지 및 사이즈만 전달--%>
        const queryString = getPhysicalInventorySearchParams(_page);
        const apiUrl = '/physical_inventory/search?' + queryString; // 실제 목록 API 경로로 변경

        fetch(apiUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(responseDTO => {
                console.log("실사 목록 검색 성공, 데이터:", responseDTO);
                // 가져온 데이터로 테이블과 페이지네이션을 갱신합니다.
                setTimeout(() => {
                    updatePhysicalInventoryTable(responseDTO.dtoList);
                    updatePagination(responseDTO);
                    console.log("지연 후 실사 목록 화면 갱신 완료");
                }, 100);
            })
            .catch(error => {
                console.error("AJAX 통신 실패:", error);
                document.getElementById('pi-tbody').innerHTML = '<tr><td colspan="10" class="text-center text-danger">실사 목록 조회 실패. 콘솔을 확인하세요.</td></tr>';
                document.getElementById('pi-pagination-ul').innerHTML = ''; // 페이지네이션 초기화
                alert("실사 목록 조회 요청 처리 실패. 콘솔을 확인하세요.");
            });
    }

    <%--/**--%>
    <%-- * 3. 실사 목록 테이블 갱신--%>
    <%-- */--%>
    function updatePhysicalInventoryTable(piList) {
        const tbody = document.getElementById('pi-tbody');

        if (!tbody) {
            console.error("DOM Error: 'pi-tbody' 요소를 찾을 수 없습니다.");
            return;
        }

        let html = '';

        if (piList && piList.length > 0) {
            piList.forEach(pi => {
                // 차이 수량 계산: 실제 수량 - 전산 수량
                const difference = (pi.calculatedQuantity || 0) - (pi.realQuantity || 0);

                // 💡 문자열 결합으로 변경
                html += '<tr>';
                html += '<td>' + pi.piId + '</td>';
                html += '<td>' + pi.piDate + '</td>';
                html += '<td><a href="/stock/detail?productId=' + pi.productId + '" class="text-primary">' + pi.productId + '</a></td>'; // 상세 페이지 링크 필요 시 수정
                html += '<td>' + pi.piState + '</td>';
                html += '<td>' + (pi.calculatedQuantity || 0) + '</td>';
                html += '<td>' + (pi.realQuantity || '-') + '</td>';
                html += '<td>' + difference + '</td>';
                html += '<td>' + pi.warehouseName + '</td>';
                html += '<td>' + pi.sectionName + '</td>';
                html += '<td>' + (pi.adjustmentStatus || '*') + '</td>';
                html += '</tr>';
            });
        } else {
            html = `<tr><td colspan="10" class="text-center">조회된 실사 정보가 없습니다.</td></tr>`;
        }

        tbody.innerHTML = html;
    }

    <%--/**--%>
    <%-- * 4. 페이지네이션 갱신 (재고 조회 페이지와 동일)--%>
    <%-- */--%>
    function updatePagination(responseDTO) {
        const paginationUl = document.getElementById('pi-pagination-ul');
        if (!paginationUl) {
            console.error("pi-pagination-ul 요소를 찾을 수 없습니다.");
            return;
        }

        // 서버 응답에서 숫자를 명확하게 파싱
        const page  = parseInt(responseDTO.page) || 1;
        const start = parseInt(responseDTO.start) || 1;
        const end   = parseInt(responseDTO.end) || 1;
        const total = parseInt(responseDTO.total) || 0;

        // 이전/다음 여부는 boolean으로 직접 사용
        const prev = responseDTO.prev;
        const next = responseDTO.next;

        // 데이터가 없거나 페이지 번호가 유효하지 않으면 반환
        if (total === 0 || isNaN(page)) {
            paginationUl.innerHTML = '';
            return;
        }

        let html = '';

        // 1. 이전 버튼
        if (prev) {
            const prevPage = start - 1;
            html += '<li class="page-item prev">';
            html += '<a class="page-link" onclick="searchPhysicalInventoryList(' + prevPage + ')">';
            html += '<i class="tf-icon bx bx-chevrons-left"></i>';
            html += '</a>';
            html += '</li>';
        }

        // 2. 페이지 번호
        for (let i = Number(start); i <= Number(end); i++) {
            const activeClass = (i === page) ? ' active' : '';
            html += '<li class="page-item' + activeClass + '">';
            html += '<a class="page-link" onclick="searchPhysicalInventoryList(' + i + ')">' + i + '</a>';
            html += '</li>';
        }

        // 3. 다음 버튼
        if (next) {
            const nextPage = end + 1;
            html += '<li class="page-item next">';
            html += '<a class="page-link" onclick="searchPhysicalInventoryList(' + nextPage + ')">';
            html += '<i class="tf-icon bx bx-chevrons-right"></i>';
            html += '</a>';
            html += '</li>';
        }

        paginationUl.innerHTML = html;
    }


    <%--// 💡 페이지 로드 완료 시 초기 실사 목록을 가져오기 위해 searchPhysicalInventoryList(1) 호출--%>
    document.addEventListener('DOMContentLoaded', function() {
        console.log("페이지 로드 완료 이벤트 발생, 초기 실사 목록 검색 시작.");
        // loadManagers(); // 담당자 목록 로드 함수 호출 (필요 시)

        // 재고 실사 등록 버튼의 onclick을 등록 함수로 변경합니다.
        const registerButton = document.querySelector('#physicalInventoryForm button[type="submit"]');
        if (registerButton) {
            // registerButton.onclick = registerPhysicalInventory;
        }

        // 초기 목록 로드
        searchPhysicalInventoryList(1);

        // 현재 날짜로 실사일자 기본값 설정
        const piDateInput = document.getElementById('piDate');
        if (piDateInput) {
            piDateInput.valueAsDate = new Date();
        }
    });

</script>