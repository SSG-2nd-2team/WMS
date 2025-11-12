package com.ssg.wms.product_stock.mappers;

import com.ssg.wms.product_stock.dto.StockSnapshotDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductStockMapper {

    /**
     * 특정 창고/섹션의 현재 재고 목록을 조회합니다. (실사 등록 시점의 스냅샷)
     */
    List<StockSnapshotDTO> selectStocksForPhysicalInventory(
            @Param("warehouseId") Long warehouseId,
            @Param("sectionId") Long sectionId
    );
}