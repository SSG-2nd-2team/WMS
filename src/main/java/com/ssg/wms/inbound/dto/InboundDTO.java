package com.ssg.wms.inbound.dto;

import lombok.Data;
import lombok.Getter;
import lombok.ToString;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@ToString
public class InboundDTO {
    // 출력용 DTO

    private int inboundId;
    private int warehouseId;
    private String warehouseName;
    private Long memberId;
    private String memberName;
    private int staffId;
    private String staffName;
    private String inboundStatus; // request, cancelled, approved, rejected
    private String inboundRejectReason;
    private LocalDateTime inboundRequestedAt;
    private LocalDateTime inboundUpdatedAt;
    private LocalDateTime inboundAt;

    private List<InboundItemDTO> inboundItems;

}

@Data
class InboundItemDTO {
    private int inboundItemId;
    private int inboundId;
    private String productId;
    private String productName;
    private int quantity;
}

