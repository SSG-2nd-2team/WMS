package com.ssg.wms.warehouse.service;

import com.ssg.wms.warehouse.dto.WarehouseDetailDTO;
import com.ssg.wms.warehouse.dto.WarehouseListDTO;
import com.ssg.wms.warehouse.dto.WarehouseSearchDTO;
import com.ssg.wms.warehouse.mappers.WarehouseMemberMapper; // DB 접근을 위한 Mapper 가정
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j2
@Service
// Member Service는 주로 조회를 수행하므로 readOnly = true로 설정합니다.
@Transactional(readOnly = true)
public class WarehousesMemberServiceImpl implements WarehouseMemberService {

    private final WarehouseMemberMapper warehouseMemberMapper;

    @Autowired
    public WarehousesMemberServiceImpl(WarehouseMemberMapper warehouseMemberMapper) {
        this.warehouseMemberMapper = warehouseMemberMapper;
    }

    /// 창고 목록 조회 창고 목록 조회 및 창고 위치 조회 메뉴,
    @Override
    public List<WarehouseListDTO> findWarehouses(WarehouseSearchDTO warehouseSearch) {
        log.info("창고 목록 조회 시작 (Member). 검색 조건: {}", warehouseSearch);

        // Mapper를 사용하여 검색 조건에 맞는 창고 목록을 조회합니다.
        List<WarehouseListDTO> list = warehouseMemberMapper.selectWarehouses(warehouseSearch);

        log.info("창고 목록 조회 성공 (Member). 조회된 항목 수: {}", list.size());
        return list;
    }

    ///창고 상세 조회 MEMBER는 단순 데이터 조회
    @Override
    public WarehouseDetailDTO findWarehouseDetailById(Long id) {
        log.info("창고 상세 조회 시작 (Member). ID: {}", id);

        // Mapper를 사용하여 특정 ID의 창고 상세 정보를 조회합니다.
        WarehouseDetailDTO detail = warehouseMemberMapper.selectWarehouseDetailById(id);

        if (detail == null) {
            log.warn("창고 상세 조회 실패 (Member): ID({})에 해당하는 창고를 찾을 수 없습니다.", id);
            // 요청된 ID에 해당하는 데이터가 없을 경우 예외 처리
            throw new IllegalArgumentException("요청하신 창고를 찾을 수 없습니다.");
        }

        log.info("창고 상세 조회 성공 (Member). ID: {}", id);
        return detail;
    }
}