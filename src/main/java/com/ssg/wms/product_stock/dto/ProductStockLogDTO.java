package com.ssg.wms.product_stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductStockLogDTO {
    private Long logId;
    private LocalDateTime eventTime; // 일자
    private Integer moveQuantity;   // 이동 수량 (+입고, -출고)
    private String eventType;       // 입/출고 구분 (IN, OUT, MOVE)
    private String productStatus;   // 재고 상태
    private String destination;     // 출발/도착 장소
    private String sectionName;     // 로그 당시 섹션 이름
}
