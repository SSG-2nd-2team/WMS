<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../admin/admin-header.jsp" %>

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
        <div class="col-lg-6 col-md-12 mb-4">
            <div class="card h-100">
                <div class="card-header d-flex align-items-center justify-content-between pb-0">
                    <div class="card-title mb-0">
                        <h5 class="m-0 me-2">금월 입고량</h5>
                    </div>
                    <div class="avatar">
                        <span class="avatar-initial rounded bg-label-info"><i
                                class="bx bx-down-arrow-alt fs-4"></i></span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="mb-2" id="monthlyInbound">0 건</h2>
                    </div>
                    <ul class="p-0 m-0" id="recentInboundList">
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12 mb-4">
            <div class="card h-100">
                <div class="card-header d-flex align-items-center justify-content-between pb-0">
                    <div class="card-title mb-0">
                        <h5 class="m-0 me-2">금월 출고량</h5>
                    </div>
                    <div class="avatar">
                        <span class="avatar-initial rounded bg-label-warning"><i
                                class="bx bx-up-arrow-alt fs-4"></i></span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="mb-2" id="monthlyOutbound">0 건</h2>
                    </div>
                    <ul class="p-0 m-0" id="recentOutboundList">
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 col-lg-8 order-1 mb-4">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between">
                    <h5 class="card-title m-0 me-2">월별 재무 현황</h5>
                    <small class="text-muted">(단위: 만원)</small>
                </div>
                <div class="card-body px-0">
                    <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
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
<%@ include file="../admin/admin-footer.jsp" %>

<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
    const API_URL = CONTEXT_PATH + '/dashboard/api';

    let mainChart, growthChart;

    $(document).ready(function () {
        initEmptyCharts();

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

    function initEmptyCharts() {
        // 메인 차트 (막대)
        const mainChartEl = document.querySelector("#mainChart");
        if (mainChartEl) {
            const mainChartOptions = {
                series: [],
                chart: {height: 300, type: 'bar', toolbar: {show: false}, fontFamily: 'Public Sans'},
                plotOptions: {bar: {horizontal: false, columnWidth: '40%', borderRadius: 4}},
                dataLabels: {enabled: false},
                stroke: {show: true, width: 2, colors: ['transparent']},
                colors: ['#696cff', '#ff3e1d'],
                xaxis: {categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']},
                yaxis: {
                    labels: {
                        // [수정] Y축 눈금: 만 단위로 나누고 콤마 포맷팅
                        formatter: function (val) {
                            return new Intl.NumberFormat('ko-KR').format(Math.round(val / 10000));
                        }
                    }
                },
                fill: {opacity: 1},
                grid: {borderColor: '#f1f1f1', padding: {bottom: 10}},
                legend: {position: 'top', horizontalAlign: 'left', markers: {radius: 12}},
                tooltip: {
                    y: {
                        // [수정] 툴팁: 전체 금액(원 단위) 표시
                        formatter: function (val) {
                            return new Intl.NumberFormat('ko-KR').format(val) + " 원";
                        }
                    }
                },
                noData: {text: '데이터 로딩 중...'}
            };
            mainChart = new ApexCharts(mainChartEl, mainChartOptions);
            mainChart.render();
        }

        // 수익률 차트 (원형)
        const growthChartEl = document.querySelector("#growthChart");
        if (growthChartEl) {
            const growthChartOptions = {
                series: [0],
                chart: {height: 240, type: 'radialBar', sparkline: {enabled: true}},
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
            growthChart = new ApexCharts(growthChartEl, growthChartOptions);
            growthChart.render();
        }
    }

    function loadDashboardData(year) {
        $.ajax({
            url: API_URL, type: 'GET', data: {year: year}, dataType: 'json',
            success: function (data) {
                updateSummaryCards(data);

                const monthlySales = Array(12).fill(0);
                const monthlyExpenses = Array(12).fill(0);
                if (data.netProfitSummary) {
                    data.netProfitSummary.forEach(item => {
                        if (item.month >= 1 && item.month <= 12) {
                            monthlySales[item.month - 1] = item.totalSales;
                            monthlyExpenses[item.month - 1] = item.totalExpenses;
                        }
                    });
                }
                if (mainChart) mainChart.updateSeries([{name: '매출', data: monthlySales}, {
                    name: '지출',
                    data: monthlyExpenses
                }]);
                if (growthChart) growthChart.updateSeries([data.profitMargin || 0]);
            },
            error: function (e) {
                console.error("Dashboard load failed", e);
            }
        });
    }

    function updateSummaryCards(data) {
        $('#totalSales').text(formatCurrency(data.totalSales));
        $('#totalExpense').text(formatCurrency(data.totalExpense));
        $('#netProfit').text(formatCurrency(data.netProfit));
        $('#monthlyInbound').text((data.monthlyInboundCount || 0) + ' 건');
        $('#monthlyOutbound').text((data.monthlyOutboundCount || 0) + ' 건');
        $('#profitMarginText').text((data.profitMargin || 0).toFixed(1) + '% 수익률');
    }

    function formatCurrency(amount) {
        let safeAmount = amount || 0;
        return new Intl.NumberFormat('ko-KR', {style: 'currency', currency: 'KRW'}).format(safeAmount);
    }
</script>