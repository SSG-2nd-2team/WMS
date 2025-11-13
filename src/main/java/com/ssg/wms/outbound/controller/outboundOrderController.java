package com.ssg.wms.outbound.controller;

import com.ssg.wms.outbound.domain.Criteria;
import com.ssg.wms.outbound.domain.dto.OutboundOrderDTO;
import com.ssg.wms.outbound.service.OutboundOrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/outbound")
@RequiredArgsConstructor
@Log4j2
public class outboundOrderController {

    private final OutboundOrderService outboundOrderService;

    @GetMapping
    public String getOutboundOrderList(Criteria criteria,
                                       @RequestParam(required = false) String filterType,
                                       Model model) {
        List<OutboundOrderDTO> list = outboundOrderService.getAllRequests(criteria, filterType);
        model.addAttribute("outboundOrders", list);
        return "/outbound/admin/outboundOrderList";
    }




    @GetMapping("/{instructionId}/dispatch-form")
    public String getDispatchForm(@PathVariable("instructionId") Long instructionId, Model model) {
        log.info("🚚 [모달폼 요청] instructionId={}", instructionId);

        OutboundOrderDTO detail = outboundOrderService.getRequestDetailById(instructionId);
        log.info("✅ 조회된 데이터: {}", detail);

        model.addAttribute("dispatch", detail);

        return "outbound/admin/dispatchForm";
    }



    @PostMapping("/{instructionId}/register")
    @ResponseBody
    public ResponseEntity<String> registerDispatch(
            @PathVariable("instructionId") Long instructionId,
            @RequestBody OutboundOrderDTO dto) {

        log.info("✅ 배차 등록 요청: instructionId={}, dto={}", instructionId, dto);

        try {
            // ✅ 1. 중복 승인 체크
            OutboundOrderDTO existingOrder = outboundOrderService.getRequestDetailById(instructionId);

            if ("승인".equals(existingOrder.getApprovedStatus())) {
                log.warn("⚠️ 이미 승인된 출고지시서: instructionId={}", instructionId);
                return ResponseEntity.status(HttpStatus.CONFLICT)
                        .body("이미 승인된 건입니다.");
            }

            // ✅ 2. 적재량 초과 체크
            if (dto.getLoadedBox() > dto.getMaximumBOX()) {
                log.warn("❌ 적재량 초과: {}박스 > {}박스",
                        dto.getLoadedBox(),
                        dto.getMaximumBOX());
                return ResponseEntity.badRequest()
                        .body("출고 박스 수가 최대 적재량을 초과했습니다.");
            }

            // ✅ 3. 배차 등록 진행
            dto.setApprovedOrderID(instructionId);
            outboundOrderService.updateOrderStatus(dto);

            log.info("✅ 배차 등록 성공: instructionId={}", instructionId);
            return ResponseEntity.ok("success");

        } catch (Exception e) {
            log.error("❌ 배차 등록 실패: instructionId={}", instructionId, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("error: " + e.getMessage());
        }
    }


//  출고지시서 승인 상태 조회 (중복 승인 방지)
@GetMapping("/{instructionId}/status")
@ResponseBody
public ResponseEntity<Map<String, String>> checkApprovalStatus(
        @PathVariable("instructionId") Long instructionId) {

    log.info("✅ 승인 상태 조회: instructionId={}", instructionId);

    try {
        OutboundOrderDTO order = outboundOrderService.getRequestDetailById(instructionId);

        Map<String, String> response = new HashMap<>();
        response.put("approvedStatus", order.getApprovedStatus());
        response.put("approvedOrderId", String.valueOf(instructionId));

        log.info("✅ 현재 승인 상태: {}", order.getApprovedStatus());
        return ResponseEntity.ok(response);

    } catch (Exception e) {
        log.error("❌ 승인 상태 조회 실패", e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Collections.singletonMap("error", "상태 조회 실패"));
    }
}
}

