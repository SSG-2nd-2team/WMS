package com.ssg.wms.finance.controller;

// import com.ssg.wms.finance.dto.CategorySummaryDTO; // (제거)
import com.ssg.wms.finance.dto.DashboardSummaryDTO;
import com.ssg.wms.finance.service.DashboardService;
// import com.ssg.wms.finance.service.ExpenseService; // (제거)
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
    // private final ExpenseService expenseService; // (제거)

    @GetMapping
    public String dashboard(Model model) {
        return "dashboard/index";
    }

    @GetMapping("/api")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardDataApi(
            @RequestParam(required = false, defaultValue = "0") int year,
            @RequestParam(required = false, defaultValue = "0") int month) {

        if (year == 0) year = Year.now().getValue();
        int queryMonth = (month == 0) ? LocalDate.now().getMonthValue() : month;

        // 1. 데이터 조회
        List<DashboardSummaryDTO> netProfitSummary = dashboardService.getNetProfitSummary(year);

        // 2. [삭제] 월별 카테고리 지출 조회 로직 삭제

        // 3. 월간 물류
        int inboundCount = dashboardService.getMonthlyInboundCount(year, queryMonth);
        int outboundCount = dashboardService.getMonthlyOutboundCount(year, queryMonth);

        // 4. 연간 총합 계산
        long totalSales = netProfitSummary.stream().mapToLong(DashboardSummaryDTO::getTotalSales).sum();
        long totalExpense = netProfitSummary.stream().mapToLong(DashboardSummaryDTO::getTotalExpenses).sum();
        long netProfit = totalSales - totalExpense;
        double profitMargin = (totalSales == 0) ? 0.0 : ((double) netProfit / totalSales) * 100;

        // 5. 전월/전년 대비 계산
        List<DashboardSummaryDTO> prevYearSummary = dashboardService.getNetProfitSummary(year - 1);
        long prevYearSameMonthProfit = prevYearSummary.get(queryMonth - 1).getNetProfit();
        long prevMonthProfit = (queryMonth == 1) ? prevYearSummary.get(11).getNetProfit() : netProfitSummary.get(queryMonth - 2).getNetProfit();
        long currentMonthProfit = netProfitSummary.get(queryMonth - 1).getNetProfit();
        double profitGrowthMoM = calculateGrowthRate(currentMonthProfit, prevMonthProfit);
        double profitGrowthYoY = calculateGrowthRate(currentMonthProfit, prevYearSameMonthProfit);

        // 6. 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("netProfitSummary", netProfitSummary);

        // response.put("monthlyExpenseSummary", monthlyExpenseSummary); // [삭제]

        response.put("totalSales", totalSales);
        response.put("totalExpense", totalExpense);
        response.put("netProfit", netProfit);
        response.put("profitMargin", profitMargin);
        response.put("monthlyInboundCount", inboundCount);
        response.put("monthlyOutboundCount", outboundCount);
        response.put("selectedYear", year);
        response.put("selectedMonth", queryMonth);
        response.put("profitGrowthMoM", profitGrowthMoM);
        response.put("profitGrowthYoY", profitGrowthYoY);

        return ResponseEntity.ok(response);
    }

    private double calculateGrowthRate(long current, long previous) {
        if (previous == 0) return (current > 0) ? 100.0 : 0.0;
        return ((double) (current - previous) / Math.abs(previous)) * 100;
    }
}