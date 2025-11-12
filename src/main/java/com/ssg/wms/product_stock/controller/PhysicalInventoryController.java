package com.ssg.wms.product_stock.controller;

import com.ssg.wms.product_stock.dto.*;
import com.ssg.wms.product_stock.mappers.dropDownMapper;
import com.ssg.wms.product_stock.service.PhysicalInventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;


@Controller
@RequestMapping("/physical_inventory")
@RequiredArgsConstructor
@Log4j2
public class PhysicalInventoryController {

    private final PhysicalInventoryService physicalInventoryService;
    private final dropDownMapper dropDownMapper; // 드롭다운 목록 제공용 매퍼

    @GetMapping
    public String physicalInventoryPage(Model model) {
            List<DropdownDTO> warehouseList = dropDownMapper.warehouseDropDown();
            List<DropdownDTO> sectionList = dropDownMapper.sectionDropDown();
            model.addAttribute("warehouseList", warehouseList);
            model.addAttribute("sectionList", sectionList);

        return "stock/physical_inventory"; // JSP 경로
    }

    @GetMapping("/list") // 기존 @GetMapping("/list")를 데이터 전용으로 수정
    @ResponseBody // 🛑 이 어노테이션이 객체를 JSON으로 변환하여 반환하도록 지시함
    public PageResponseDTO<PhysicalInventoryDTO> getPhysicalInventoryData(PageRequestDTO pageRequestDTO) {
        // 기존 searchList 메서드와 동일한 역할 수행
        return physicalInventoryService.getPhysicalInventoryList(pageRequestDTO);
    }

    @GetMapping("/search") // AJAX 리스트 조회
    @ResponseBody
    public PageResponseDTO<PhysicalInventoryDTO> searchList(PageRequestDTO pageRequestDTO) {
        return physicalInventoryService.getPhysicalInventoryList(pageRequestDTO);
    }

//    @PostMapping("/register") // 실사 등록
//    public ResponseEntity<Map<String, Object>> registerPhysicalInventory(@RequestBody PhysicalInventoryRequest request) {
//        try {
//            int registeredCount = physicalInventoryService.registerPhysicalInventory(request);
//            return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
//                    "message", "등록 성공",
//                    "count", registeredCount
//            ));
//        } catch (IllegalArgumentException e) {
//            log.error("실사 등록 실패:", e.getMessage());
//            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
//        }
//    }

//    @PostMapping("/update") // 실제 수량 수정 및 조정
//    public ResponseEntity<Map<String, String>> updatePhysicalInventory(@RequestBody PhysicalInventoryUpdateDTO updateDTO) {
//        try {
//            physicalInventoryService.updatePhysicalInventory(updateDTO);
//            String action = "조정 완료".equals(updateDTO.getUpdateState()) ? "재고 조정 및 완료" : "저장 예약";
//            return ResponseEntity.ok(Map.of("message", action + " 처리 성공"));
//        } catch (Exception e) {
//            log.error("실사 업데이트 실패:", e);
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "처리 실패: " + e.getMessage()));
//        }
//    }
}