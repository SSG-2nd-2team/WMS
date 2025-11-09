<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/assets/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>대시보드 | WMS</title>

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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/apexcharts@3.41.0/dist/apexcharts.min.css">

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
                <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                    <i class="bx bx-chevron-left bx-sm align-middle"></i>
                </a>
            </div>
            <div class="menu-inner-shadow"></div>
            <ul class="menu-inner py-1">
                <li class="menu-item active">
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
                <li class="menu-item">
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
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold py-3 mb-0"><span class="text-muted fw-light">재무관리 /</span> 대시보드</h4>
                        <select id="yearFilter" class="form-select w-auto cursor-pointer">
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                                        <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                                            <div class="card-title">
                                                <h5 class="text-nowrap mb-2">총 매출</h5>
                                                <span class="badge bg-label-success rounded-pill">Yearly</span>
                                            </div>
                                            <div class="mt-sm-auto">
                                                <h3 class="mb-0" id="totalSales">Loading...</h3>
                                            </div>
                                        </div>
                                        <div id="profileReportChart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                                        <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                                            <div class="card-title">
                                                <h5 class="text-nowrap mb-2">총 지출</h5>
                                                <span class="badge bg-label-danger rounded-pill">Yearly</span>
                                            </div>
                                            <div class="mt-sm-auto">
                                                <h3 class="mb-0" id="totalExpense">Loading...</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                                        <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                                            <div class="card-title">
                                                <h5 class="text-nowrap mb-2">순이익</h5>
                                                <span class="badge bg-label-primary rounded-pill">Yearly</span>
                                            </div>
                                            <div class="mt-sm-auto">
                                                <h3 class="mb-0 text-primary" id="netProfit">Loading...</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h5 class="pb-1 mb-4 text-muted">물류 현황 (이번 달)</h5>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar avatar-md me-2">
                                                <span class="avatar-initial rounded bg-label-info"><i
                                                        class="bx bx-down-arrow-alt fs-4"></i></span>
                                            </div>
                                            <div>
                                                <p class="mb-0 fw-semibold">금월 입고량</p>
                                                <h4 class="my-1" id="monthlyInbound">0 건</h4>
                                            </div>
                                        </div>
                                        <div id="inboundChart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-12 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar avatar-md me-2">
                                                <span class="avatar-initial rounded bg-label-warning"><i
                                                        class="bx bx-up-arrow-alt fs-4"></i></span>
                                            </div>
                                            <div>
                                                <p class="mb-0 fw-semibold">금월 출고량</p>
                                                <h4 class="my-1" id="monthlyOutbound">0 건</h4>
                                            </div>
                                        </div>
                                        <div id="outboundChart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8 col-lg-8 order-1 mb-4">
                            <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="card-title m-0 me-2">월별 재무 현황</h5>
                                </div>
                                <div class="card-body px-0">
                                    <div class="tab-content p-0">
                                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income"
                                             role="tabpanel">
                                            <div class="d-flex p-4 pt-3">
                                                <div id="mainChart" style="width: 100%"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-lg-4 order-2 mb-4">
                            <div class="card h-100">
                                <div class="card-header d-flex align-items-center justify-content-between">
                                    <h5 class="card-title m-0 me-2">순수익률</h5>
                                </div>
                                <div class="card-body">
                                    <div id="growthChart"></div>
                                    <div class="text-center fw-semibold pt-3 mb-2" id="profitMarginText">0% 수익률</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
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

<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts@3.41.0/dist/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
    const API_URL = CONTEXT_PATH + '/dashboard/api'; // API 컨트롤러 경로 확인 필요

    $(document).ready(function () {
        // 연도 필터 초기화 (현재 연도 ~ 5년 전)
        const currentYear = new Date().getFullYear();
        let yearFilter = $('#yearFilter');
        for (let i = 0; i < 5; i++) {
            yearFilter.append(`<option value="\${currentYear - i}">\${currentYear - i}년</option>`);
        }
        yearFilter.val(currentYear);

        loadDashboardData(currentYear);

        $('#yearFilter').change(function () {
            loadDashboardData($(this).val());
        });
    });

    function loadDashboardData(year) {
        $.ajax({
            url: API_URL,
            type: 'GET',
            data: {year: year},
            dataType: 'json',
            success: function (data) {
                updateSummaryCards(data);
                renderMainChart(data.monthlySalesData, data.monthlyExpenseData);
                renderGrowthChart(data.profitMargin);
            },
            error: function (e) {
                console.error("Dashboard load failed", e);
                // 에러 처리 UI (옵션)
            }
        });
    }

    function updateSummaryCards(data) {
        $('#totalSales').text(formatCurrency(data.totalSales));
        $('#totalExpense').text(formatCurrency(data.totalExpense));
        $('#netProfit').text(formatCurrency(data.netProfit));

        // 물류 현황 (백엔드 제공 시 연결)
        $('#monthlyInbound').text((data.monthlyInboundCount || 0) + ' 건');
        $('#monthlyOutbound').text((data.monthlyOutboundCount || 0) + ' 건');
        $('#profitMarginText').text(data.profitMargin.toFixed(1) + '% 수익률');
    }

    function renderMainChart(salesData, expenseData) {
        const options = {
            series: [{name: '매출', data: salesData}, {name: '지출', data: expenseData}],
            chart: {height: 300, type: 'bar', toolbar: {show: false}, fontFamily: 'Public Sans'},
            plotOptions: {bar: {horizontal: false, columnWidth: '40%', borderRadius: 4}},
            dataLabels: {enabled: false},
            stroke: {show: true, width: 2, colors: ['transparent']},
            colors: ['#696cff', '#ff3e1d'], // Sneat Primary & Danger
            xaxis: {categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']},
            fill: {opacity: 1},
            grid: {borderColor: '#f1f1f1', padding: {bottom: 10}},
            legend: {position: 'top', horizontalAlign: 'left', markers: {radius: 12}}
        };
        if (window.mainChart) window.mainChart.destroy();
        window.mainChart = new ApexCharts(document.querySelector("#mainChart"), options);
        window.mainChart.render();
    }

    function renderGrowthChart(profitMargin) {
        const options = {
            series: [profitMargin],
            chart: {height: 200, type: 'radialBar', sparkline: {enabled: true}},
            plotOptions: {
                radialBar: {
                    hollow: {size: '70%'},
                    track: {background: '#f5f5f9'},
                    dataLabels: {
                        name: {show: false},
                        value: {
                            fontSize: '22px',
                            color: '#696cff',
                            offsetY: 10,
                            formatter: (val) => val.toFixed(1) + "%"
                        }
                    }
                }
            },
            colors: ['#696cff']
        };
        if (window.growthChart) window.growthChart.destroy();
        window.growthChart = new ApexCharts(document.querySelector("#growthChart"), options);
        window.growthChart.render();
    }

    // [수정 후] (값이 없으면 0으로 처리)
    function formatCurrency(amount) {
        // amount가 null이나 undefined면 0으로 대체
        let safeAmount = amount || 0;
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(safeAmount);
    }
</script>
</body>
</html>