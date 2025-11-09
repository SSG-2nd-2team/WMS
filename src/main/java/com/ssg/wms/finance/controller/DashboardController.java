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

    // JSP 렌더링
    @GetMapping
    public String dashboard(Model model, @RequestParam(required = false, defaultValue = "0") int year) {
        // 초기 로딩 시에도 데이터를 계산해서 보내줄 수 있지만,
        // 현재 구조에서는 JSP가 로딩 직후 AJAX를 호출하므로 껍데기만 리턴해도 충분.
        return "dashboard/index";
    }

    // 대시보드 데이터 통합 조회 (AJAX용 API)
    @GetMapping("/api")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardDataApi(
            @RequestParam(required = false, defaultValue = "0") int year) {

        if (year == 0) {
            year = Year.now().getValue();
        }

        // 1. 월별 데이터 & 카테고리별 지출 데이터 조회
        List<DashboardSummaryDTO> netProfitSummary = dashboardService.getNetProfitSummary(year);
        List<CategorySummaryDTO> expenseSummary = expenseService.getAnnualExpenseSummary(year);

        // 2. [핵심 추가] 1년치 총합 계산
        long totalSales = netProfitSummary.stream()
                .mapToLong(DashboardSummaryDTO::getTotalSales)
                .sum();

        long totalExpense = netProfitSummary.stream()
                .mapToLong(DashboardSummaryDTO::getTotalExpenses)
                .sum();

        long netProfit = totalSales - totalExpense;

        // 3. 수익률 계산 (매출이 0일 경우 0.0% 처리하여 에러 방지)
        double profitMargin = (totalSales == 0) ? 0.0 : ((double) netProfit / totalSales) * 100;

        // 4. 응답 데이터 구성 (Map에 모두 담아서 반환)
        Map<String, Object> response = new HashMap<>();
        response.put("netProfitSummary", netProfitSummary); // 차트용 월별 데이터
        response.put("expenseSummary", expenseSummary);     // 차트용 카테고리 데이터

        // 상단 요약 카드용 합계 데이터
        response.put("totalSales", totalSales);
        response.put("totalExpense", totalExpense);
        response.put("netProfit", netProfit);
        response.put("profitMargin", profitMargin);

        response.put("selectedYear", year); // 현재 선택된 연도

        return ResponseEntity.ok(response);
    }
}