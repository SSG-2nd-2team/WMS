package com.ssg.wms.inbound.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class InboundRequestDTO {

    private int inboundId;
    private int warehouseId;
    private String warehouseName;
    private int memberId;
    private String memberName;
    private String inboundStatus;
    private String inboundRejectReason;
    private LocalDateTime inboundRequestDateTime;
    private LocalDateTime inboundUpdateDateTime;
    private LocalDateTime inboundDateTime;

}

