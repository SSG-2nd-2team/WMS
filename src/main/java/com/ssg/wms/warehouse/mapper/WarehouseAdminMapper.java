package com.ssg.wms.warehouse.mapper;

import com.ssg.wms.warehouse.dto.SectionDTO;
import com.ssg.wms.warehouse.dto.WarehouseSaveDTO;
import com.ssg.wms.warehouse.dto.WarehouseUpdateDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface WarehouseAdminMapper {
    // 1. 창고 등록 (Service: saveWarehouse 지원)
    // DB에서 생성된 PK를 DTO에 다시 담아 Service로 반환함
    int insertWarehouse(WarehouseSaveDTO saveDTO);

    // 2. 창고 수정 (Service: updateWarehouse 지원)
    int updateWarehouse(WarehouseUpdateDTO updateDTO);

    // 3. 창고 삭제 (Service: deleteWarehouse 지원)
    int deleteWarehouse(Long id);

    // 4. 창고 이름 중복 확인 (Service: checkNameDuplication 지원)
    int countWarehouseName(String name);

    // 5. 창고 상태 업데이트 (Service: updateWarehouseStatus 지원)
    int updateWarehouseStatus(@Param("id") Long id, @Param("newStatus") Byte newStatus);

    int insertSection(SectionDTO section);

    // 6. 창고 상세 조회 (관리 기능 수행 전 데이터 확인을 위해 필요할 수 있음)
    // *Member Mapper와 메소드 명칭이 다를 경우 사용*
    // WarehouseDetailDTO selectWarehouseDetailById(Long id);
}