package com.ssg.wms.warehouse.dto;

/// 위치 정보 DTO입니다!!!
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor /// 생성자 자동 생성..//
@NoArgsConstructor
public class LocationDTO {
    /// 위치의 고유 식별 위치 ID
    private Long locationId;

    ///창고  속한 섹션  ID
    private Long sectionId;

    ///위치DB 물품
    private String locationCode;

    /// 위치가 있는 층수  1층 , 2층 (최대 2층입니다)
    private Integer floorNum;

    ///위치의 유형 코드 (렉, 팔레트 등)
    private String locationTypeCode;

    /// 해당 위치의 최대 적재 가능 부피
    private Double maxVolume;
}
