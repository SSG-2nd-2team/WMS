package com.ssg.wms.product_stock.mappers;

import com.ssg.wms.product_stock.dto.PageRequestDTO;
import com.ssg.wms.product_stock.dto.StockInfoDTO;
import com.ssg.wms.product_stock.dto.StockLogDTO;
import com.ssg.wms.product_stock.dto.StockSummaryDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProductListMapper {
    List<StockInfoDTO> findStockList(PageRequestDTO pageRequestDTO);
    int countStockList(PageRequestDTO pageRequestDTO);

    /** 특정 상품 ID에 대한 상세 정보 (현재 재고, 위치 등)를 조회 */
    StockSummaryDTO getProductSummaryById(String productId);

    /** 특정 상품 ID에 대한 재고 이동 로그 목록을 조회 */
    List<StockLogDTO> getStockMovementLogs(String productId);
}
