package com.ssg.wms.warehouse.dto;

/// 창고 구역정보 DTO입니다.

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class SectionDTO {
    ///창고 구역 ID
    private Long sectionId;

    /// 창고 구역이름 (A/B/C/D 구역)
    private String sectionName;

    ///창고 구역의 종류 보관구역,검수구역
    private String sectionType;

    /// 창고 구역의 목적 ( 창고 구역에 해당하는 목적 설명.)
    private String sectionPurpose;

    ///  창고 구역에 할당된 면적
    private Integer allocatedArea;
    
    private Long warehouseId;

/// 오류를 위해 추가됨 확인..
    private List<LocationDTO> locations;
}
