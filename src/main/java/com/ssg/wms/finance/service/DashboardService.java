package com.ssg.wms.finance.service;

import com.ssg.wms.finance.dto.DashboardSummaryDTO;

import java.util.List;

public interface DashboardService {
    List<DashboardSummaryDTO> getNetProfitSummary(int year);
}
