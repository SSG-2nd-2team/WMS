package com.ssg.wms.warehouse.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/// 창고 등록 수정 DTO입니다.
@Data
@AllArgsConstructor
@NoArgsConstructor
public class WarehouseSaveDTO {

    /// 창고등록 페이지에서 SectionDTO를 받기 위해서 설정.
    private List<SectionDTO> sections;
    
    private Long warehouseId;

    /// 창고 이름
    @NotBlank(message = "창고 이름은 필수 입력 항목입니다.")
    private String name;

    /// 창고 주소
    @NotBlank(message = "주소는 필수 입력 항목, 위치 확인이 필요합니다.")
    private String address;

    ///창고 담당자 ID
    @NotNull(message = "담당자 ID는 필수입니다.")
    private Long adminId;

    /// 창고 종류  -> 허브인지 스포크인지
    @NotBlank(message = "창고 종류는 필수 선택 항목입니다.")
    private String warehouseType;

    /// 창고 총 수용 용량
    @NotNull(message = "수용량은 필수 입력 항목입니다.")
    private Integer warehouseCapacity;

    /// 창고 현재 운영 현황 코드
    private Integer warehouseStatus;

    ///  Service Geocoding 후 설정할 필드
    private Double latitude;
    private Double longitude;


}