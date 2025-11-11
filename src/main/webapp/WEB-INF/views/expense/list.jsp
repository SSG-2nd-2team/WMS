<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- [핵심] 이 페이지가 'expense'임을 알림 --%>
<c:set var="pageActive" value="expense" scope="request"/>

<%@ include file="../admin/admin-header.jsp" %>

<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">재무관리 /</span> 지출 관리</h4>

    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">지출 목록</h5>
            <button type="button" class="btn btn-primary" onclick="openRegisterModal()">
                <i class="bx bx-plus me-1"></i> 지출 등록
            </button>
        </div>
        <div class="card-body">
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <label class="form-label">시작일</label>
                    <input type="date" id="startDate" class="form-control"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">종료일</label>
                    <input type="date" id="endDate" class="form-control"/>
                </div>
                <div class="col-md-4">
                    <label class="form-label">검색어</label>
                    <input type="text" id="keyword" class="form-control" placeholder="창고명, 카테고리 등"/>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-primary w-100" onclick="loadData(1)">
                        <i class="bx bx-search me-1"></i> 검색
                    </button>
                </div>
            </div>

            <div class="table-responsive text-nowrap">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>지출일자</th>
                        <th>창고명</th>
                        <th>카테고리</th>
                        <th class="text-end">금액</th>
                        <th>설명</th>
                    </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="expenseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">지출 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="expenseId">
                <div class="row g-2">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">지출일자 <span class="text-danger">*</span></label>
                        <input type="date" id="modalExpenseDate" class="form-control"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">금액 <span class="text-danger">*</span></label>
                        <input type="number" id="modalAmount" class="form-control" placeholder="숫자만 입력"/>
                    </div>
                </div>
                <div class="row g-2">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">창고명 <span class="text-danger">*</span></label>
                        <input type="text" id="modalWarehouseName" class="form-control" placeholder="예: 서울 제1창고"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">카테고리 <span class="text-danger">*</span></label>
                        <select id="modalCategory" class="form-select">
                            <option value="">선택하세요</option>
                            <option value="임대료">임대료</option>
                            <option value="인건비">인건비</option>
                            <option value="전기세">전기세</option>
                            <option value="수도세">수도세</option>
                            <option value="관리비">관리비</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">설명</label>
                    <textarea id="modalDescription" class="form-control" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-danger" id="btnDelete" style="display:none;"
                        onclick="deleteExpense()">삭제
                </button>
                <button type="button" class="btn btn-primary" id="btnUpdate" style="display:none;"
                        onclick="updateExpense()">수정
                </button>
                <button type="button" class="btn btn-primary" id="btnSave" onclick="saveExpense()">저장</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="../admin/admin-footer.jsp" %>

<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
    const API_BASE_URL = CONTEXT_PATH + '/expense/api';

    $(document).ready(function () {
        loadData(1);
    });

    function loadData(page) {
        $.ajax({
            url: API_BASE_URL + '/list', type: 'GET',
            data: {
                page: page,
                size: 10,
                dateFrom: $('#startDate').val(),
                dateTo: $('#endDate').val(),
                keyword: $('#keyword').val()
            },
            dataType: 'json',
            success: function (res) {
                renderTable(res.expenses);
                renderPagination(res);
            },
            error: function () {
                $('#tableBody').html('<tr><td colspan="6" class="text-center py-3 text-danger">데이터 로드 실패</td></tr>');
            }
        });
    }

    function renderTable(list) {
        let tbody = $('#tableBody').empty();
        if (!list || list.length === 0) {
            tbody.append('<tr><td colspan="6" class="text-center py-3">데이터가 없습니다.</td></tr>');
            return;
        }
        list.forEach(item => {
            let amt = new Intl.NumberFormat('ko-KR').format(item.amount);
            tbody.append(`<tr style="cursor:pointer" onclick="openDetailModal(\${item.id})">
                <td>\${item.id}</td><td>\${item.expenseDate}</td><td><strong>\${item.warehouseName}</strong></td>
                <td><span class="badge bg-label-danger">\${item.category}</span></td>
                <td class="text-end fw-bold text-danger">\${amt}원</td><td>\${item.description || '-'}</td></tr>`);
        });
    }

    const expenseModal = new bootstrap.Modal(document.getElementById('expenseModal'));

    function openRegisterModal() {
        $('#expenseId').val('');
        $('#modalExpenseDate').val(new Date().toISOString().split('T')[0]);
        $('#modalWarehouseName, #modalCategory, #modalAmount, #modalDescription').val('');
        $('#modalCategory').val('');
        $('#modalTitle').text('신규 지출 등록');
        $('#btnSave').show();
        $('#btnUpdate, #btnDelete').hide();
        expenseModal.show();
    }

    function openDetailModal(id) {
        $.get(API_BASE_URL + '/' + id, function (data) {
            $('#expenseId').val(data.id);
            $('#modalExpenseDate').val(data.expenseDate);
            $('#modalWarehouseName').val(data.warehouseName);
            $('#modalCategory').val(data.category);
            $('#modalAmount').val(data.amount);
            $('#modalDescription').val(data.description);
            $('#modalTitle').text('지출 상세 정보');
            $('#btnSave').hide();
            $('#btnUpdate, #btnDelete').show();
            expenseModal.show();
        }).fail(function () {
            alert('데이터 로드 실패');
        });
    }

    function saveExpense() {
        sendRequest('POST', API_BASE_URL, '저장되었습니다.');
    }

    function updateExpense() {
        sendRequest('PUT', API_BASE_URL + '/' + $('#expenseId').val(), '수정되었습니다.');
    }

    function deleteExpense() {
        if (confirm('삭제하시겠습니까?')) sendRequest('DELETE', API_BASE_URL + '/' + $('#expenseId').val(), '삭제되었습니다.');
    }

    function sendRequest(method, url, msg) {
        $.ajax({
            url: url, type: method, contentType: 'application/json',
            data: method === 'DELETE' ? null : JSON.stringify({
                expenseDate: $('#modalExpenseDate').val(),
                warehouseName: $('#modalWarehouseName').val(),
                category: $('#modalCategory').val(),
                amount: $('#modalAmount').val(),
                description: $('#modalDescription').val()
            }),
            success: function () {
                alert(msg);
                expenseModal.hide();
                loadData(1);
            },
            error: function (e) {
                alert('요청 실패: ' + e.status);
            }
        });
    }

    function renderPagination(res) {
        let $ul = $('#pagination').empty();
        let totalPages = Math.ceil(res.total / res.size);
        let startPage = Math.floor((res.page - 1) / 10) * 10 + 1;
        let endPage = Math.min(startPage + 9, totalPages);
        if (res.page > 1) $ul.append(`<li class="page-item"><a class="page-link" href="javascript:loadData(\${res.page - 1})"><i class="bx bx-chevron-left"></i></a></li>`);
        for (let i = startPage; i <= endPage; i++) $ul.append(`<li class="page-item \${i === res.page ? 'active' : ''}"><a class="page-link" href="javascript:loadData(\${i})">\${i}</a></li>`);
        if (res.page < totalPages) $ul.append(`<li class="page-item"><a class="page-link" href="javascript:loadData(\${res.page + 1})"><i class="bx bx-chevron-right"></i></a></li>`);
    }
</script>