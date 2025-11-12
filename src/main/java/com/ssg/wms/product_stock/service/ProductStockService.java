package com.ssg.wms.product_stock.service;

import com.ssg.wms.product_stock.dto.*;

import java.util.List;

public interface ProductStockService {

    List<DropdownDTO> categoryDropDown();
    List<DropdownDTO> brandDropDown();
    List<DropdownDTO> warehouseDropDown();
    List<DropdownDTO> sectionDropDown();

    PageResponseDTO<StockInfoDTO> getStockList(PageRequestDTO pageRequestDTO);

    // --- 💡 새로 추가할 메서드 ---
    /** 상품 ID를 기반으로 상세 요약 정보를 가져옵니다. (화면 상단 정보) */
    StockSummaryDTO getProductSummary(String productId);

    /** 특정 상품 ID에 대한 재고 이동 로그 목록을 가져옵니다. (화면 하단 테이블) */
    List<StockLogDTO> getStockMovementLogs(String productId);
}
