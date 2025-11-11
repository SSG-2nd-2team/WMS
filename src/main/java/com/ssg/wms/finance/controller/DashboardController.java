package com.ssg.wms.finance.controller;

import com.ssg.wms.finance.dto.CategorySummaryDTO;
import com.ssg.wms.finance.dto.DashboardSummaryDTO;
import com.ssg.wms.finance.service.DashboardService;
import com.ssg.wms.finance.service.ExpenseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.Year;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dashboard")
@RequiredArgsConstructor
@Log4j2
public class DashboardController {

    private final DashboardService dashboardService;
    private final ExpenseService expenseService;

    // 대시보드 페이지 렌더링 (JSP)
    @GetMapping
    public String dashboard(Model model) {
        // 초기 데이터는 AJAX로 불러오므로 껍데기만 반환
        return "dashboard/index";
    }

    // 대시보드 데이터 통합 조회 (AJAX API)
    @GetMapping("/api")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardDataApi(
            @RequestParam(required = false, defaultValue = "0") int year) {

        // 1. 연도 기본값 설정 (파라미터가 0이면 현재 연도)
        if (year == 0) {
            year = Year.now().getValue();
        }

        // 2. 재무 데이터 조회 (월별 순수익, 카테고리별 지출)
        List<DashboardSummaryDTO> netProfitSummary = dashboardService.getNetProfitSummary(year);
        List<CategorySummaryDTO> expenseSummary = expenseService.getAnnualExpenseSummary(year);

        // 3. 재무 총합 계산 (1년치)
        long totalSales = netProfitSummary.stream()
                .mapToLong(DashboardSummaryDTO::getTotalSales)
                .sum();
        long totalExpense = netProfitSummary.stream()
                .mapToLong(DashboardSummaryDTO::getTotalExpenses)
                .sum();
        long netProfit = totalSales - totalExpense;

        // 4. 수익률 계산 (매출 0원일 때 예외 처리)
        double profitMargin = (totalSales == 0) ? 0.0 : ((double) netProfit / totalSales) * 100;

        // 5. 물류 현황 데이터 조회 (선택된 연도의 현재 월 기준)
        int currentMonth = LocalDate.now().getMonthValue();
        int inboundCount = dashboardService.getMonthlyInboundCount(year, currentMonth);
        int outboundCount = dashboardService.getMonthlyOutboundCount(year, currentMonth);

        // 6. 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        // [차트용 데이터]
        response.put("netProfitSummary", netProfitSummary);
        response.put("expenseSummary", expenseSummary);

        // [상단 요약 카드용 재무 데이터]
        response.put("totalSales", totalSales);
        response.put("totalExpense", totalExpense);
        response.put("netProfit", netProfit);
        response.put("profitMargin", profitMargin);

        // [중단 요약 카드용 물류 데이터]
        response.put("monthlyInboundCount", inboundCount);
        response.put("monthlyOutboundCount", outboundCount);

        // [기타 정보]
        response.put("selectedYear", year);

        return ResponseEntity.ok(response);
    }
}