package com.ssg.wms.outbound.controller;

import com.ssg.wms.common.Role;
import com.ssg.wms.outbound.domain.Criteria;
import com.ssg.wms.outbound.domain.dto.WaybillDTO;
import com.ssg.wms.outbound.service.WaybillService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/admin/waybills")
@RequiredArgsConstructor
@Log4j2
public class WaybillController {


    private final WaybillService waybillService;

    private boolean isAdmin(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && role.equals(Role.ADMIN);
    }

    /** 운송장 리스트 조회 */
    @GetMapping
    public ResponseEntity<List<WaybillDTO>> getWaybillList(
            HttpSession session,
            Criteria criteria,
            @RequestParam(required = false) String search) {

        if (!isAdmin(session)) return ResponseEntity.status(403).build();

        log.info("운송장 리스트 조회: search={}", search);
        List<WaybillDTO> list = waybillService.getWaybillList(criteria, search);
        return ResponseEntity.ok(list);
    }

    /** 운송장 정보 수정 */
    @PutMapping("/{waybillId}")
    public ResponseEntity<Void> updateWaybill(
            @PathVariable Long waybillId,
            @RequestBody WaybillDTO dto,
            HttpSession session) {

        if (!isAdmin(session)) return ResponseEntity.status(403).build();

        log.info("운송장 정보 수정 요청 - ID: {}", waybillId);
        dto.setWaybillId(waybillId);
        waybillService.updateWaybill(dto);
        return ResponseEntity.ok().build();
    }


    /** 운송장 상세 조회 */
    @GetMapping("/{waybillNumber}")
    public ResponseEntity<WaybillDTO> getWaybillDetail(
            @PathVariable String waybillNumber,
            HttpSession session) {

        if (!isAdmin(session)) return ResponseEntity.status(403).build();

        log.info("운송장 상세 조회 요청: Waybill Number={}", waybillNumber);
        WaybillDTO dto = waybillService.getWaybillByNumber(waybillNumber);

        if (dto == null) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(dto);
    }
}