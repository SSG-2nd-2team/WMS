package com.ssg.wms.warehouse.dto;

///창고 검색 조건 DTO!!!!!!
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data/// getter, setter equals, toStrig을 자동 생성 어노테이션.
@AllArgsConstructor
@NoArgsConstructor


public class WarehouseSearchDTO {

    /// 창고 이름.
    private String warehouseName;

    /// 창고 주소 검색어
    private String warehouseAddress;

    /// 창고 종류 필터 조건
     private String warehouseType;

}
