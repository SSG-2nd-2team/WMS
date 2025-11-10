<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>지출 관리 | WMS</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"
          class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="${pageContext.request.contextPath}/dashboard" class="app-brand-link">
                    <span class="app-brand-logo demo">
                        <svg width="25" viewBox="0 0 25 42" version="1.1" xmlns="http://www.w3.org/2000/svg"
                             xmlns:xlink="http://www.w3.org/1999/xlink">
                            <defs>
                                <path d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z"
                                      id="path-1"></path>
                            </defs>
                            <g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
                                    <g id="Icon" transform="translate(27.000000, 15.000000)">
                                        <use fill="#696cff" xlink:href="#path-1"></use>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </span>
                    <span class="app-brand-text demo menu-text fw-bolder ms-2">WMS</span>
                </a>
            </div>
            <div class="menu-inner-shadow"></div>
            <ul class="menu-inner py-1">
                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/dashboard" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-home-circle"></i>
                        <div data-i18n="Analytics">대시보드</div>
                    </a>
                </li>
                <li class="menu-header small text-uppercase"><span class="menu-header-text">재무관리</span></li>
                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/sales/list" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-trending-up"></i>
                        <div data-i18n="Sales">매출 관리</div>
                    </a>
                </li>
                <li class="menu-item active">
                    <a href="${pageContext.request.contextPath}/expense/list" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-trending-down"></i>
                        <div data-i18n="Expense">지출 관리</div>
                    </a>
                </li>
            </ul>
        </aside>

        <div class="layout-page">
            <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                 id="layout-navbar">
                <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                    <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)"><i class="bx bx-menu bx-sm"></i></a>
                </div>
                <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                    <div class="navbar-nav align-items-center">
                        <div class="nav-item d-flex align-items-center">
                            <i class="bx bx-search fs-4 lh-0"></i>
                            <input type="text" class="form-control border-0 shadow-none" placeholder="Search..."
                                   aria-label="Search..."/>
                        </div>
                    </div>
                    <ul class="navbar-nav flex-row align-items-center ms-auto">
                        <li class="nav-item navbar-dropdown dropdown-user dropdown">
                            <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);"
                               data-bs-toggle="dropdown">
                                <div class="avatar avatar-online">
                                    <img src="${pageContext.request.contextPath}/assets/img/avatars/1.png" alt
                                         class="w-px-40 h-auto rounded-circle"/>
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><span class="align-middle">내 프로필</span></a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i
                                        class="bx bx-power-off me-2"></i><span class="align-middle">로그아웃</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>

            <div class="content-wrapper">
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
                                    <button type="button" class="btn btn-outline-primary w-100" onclick="loadData(1)">
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

                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">©
                            <script>document.write(new Date().getFullYear());</script>
                            , made with ❤️ by WMS Team
                        </div>
                    </div>
                </footer>
                <div class="content-backdrop fade"></div>
            </div>
        </div>
    </div>
    <div class="layout-overlay layout-menu-toggle"></div>
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

<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
    const API_BASE_URL = CONTEXT_PATH + '/expense/api';

    $(document).ready(function () {
        loadData(1);
    });

    function loadData(page) {
        $.ajax({
            url: API_BASE_URL + '/list',
            type: 'GET',
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
            error: function (e) {
                console.error("Error loading expense data:", e);
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
            // [중요] 500 에러 방지를 위한 이스케이프 (\$) 처리됨
            let amt = new Intl.NumberFormat('ko-KR').format(item.amount);
            tbody.append(`<tr style="cursor:pointer" onclick="openDetailModal(\${item.id})">
                <td>\${item.id}</td>
                <td>\${item.expenseDate}</td>
                <td><strong>\${item.warehouseName}</strong></td>
                <td><span class="badge bg-label-primary">\${item.category}</span></td>
                <td class="text-end fw-bold text-danger">\${amt}원</td>
                <td>\${item.description || '-'}</td>
            </tr>`);
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
        }).fail(function (e) {
            console.error("Error fetching detail:", e);
            alert('지출 상세 정보를 불러오지 못했습니다.');
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
            url: url,
            type: method,
            contentType: 'application/json',
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

        if (res.page > 1) {
            $ul.append(`<li class="page-item"><a class="page-link" href="javascript:loadData(\${res.page - 1})"><i class="bx bx-chevron-left"></i></a></li>`);
        }
        for (let i = startPage; i <= endPage; i++) {
            $ul.append(`<li class="page-item \${i === res.page ? 'active' : ''}"><a class="page-link" href="javascript:loadData(\${i})">\${i}</a></li>`);
        }
        if (res.page < totalPages) {
            $ul.append(`<li class="page-item"><a class="page-link" href="javascript:loadData(\${res.page + 1})"><i class="bx bx-chevron-right"></i></a></li>`);
        }
    }
</script>
</body>
</html>