package com.ssg.wms.warehouse.mappers;

import com.ssg.wms.warehouse.dto.SectionDTO;
import com.ssg.wms.warehouse.dto.WarehouseSaveDTO;
import com.ssg.wms.warehouse.dto.WarehouseUpdateDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface WarehousesManagerMapper { // MANAGER 전용 Mapper (WarehousesManagerController에서 사용)

    // ADMIN과 동일한 기능 리팩토링
    int insertWarehouse(WarehouseSaveDTO saveDTO);

    int updateWarehouse(WarehouseUpdateDTO updateDTO);

    int deleteWarehouse(Long id);

    int countWarehouseName(String name);

    int updateWarehouseStatus(@Param("id") Long id, @Param("newStatus") Byte newStatus);

    int insertSection(SectionDTO section);

    // NOTE: 필요하다면 XML 쿼리 파일은 동일한 쿼리를 참조하거나, Admin과 동일한 XML 파일을 사용하도록 설정할 수 있습니다.
}