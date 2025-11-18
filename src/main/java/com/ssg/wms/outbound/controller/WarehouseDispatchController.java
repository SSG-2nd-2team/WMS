package com.ssg.wms.outbound.controller;

import com.ssg.wms.warehouse.dto.WarehouseListDTO;
import com.ssg.wms.warehouse.service.WarehouseAdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Log4j2
@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/dispatches")
public class WarehouseDispatchController {
    private final WarehouseAdminService warehouseAdminService;

    /**
     * 출고지시서 배차 등록 시 사용할 창고 목록 조회 API
     * GET → /admin/dispatches/warehouses
     */
    @GetMapping("/warehouses")
    public ResponseEntity<List<WarehouseListDTO>> getWarehouseList() {
        log.info("📦 배차 등록용 창고 목록 조회 요청");

        List<WarehouseListDTO> list = warehouseAdminService.findWarehouses(null);

        return ResponseEntity.ok(list);
    }
}
