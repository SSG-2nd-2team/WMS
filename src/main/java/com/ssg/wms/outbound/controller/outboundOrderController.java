package com.ssg.wms.outbound.controller;

import com.ssg.wms.outbound.domain.Criteria;
import com.ssg.wms.outbound.domain.dto.OutboundOrderDTO;
import com.ssg.wms.outbound.service.OutboundOrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

        if (dto.getLoadedBox() > dto.getMaximumBOX()) {
            log.warn("❌ 적재량 초과: {}박스 > {}박스",
                    dto.getLoadedBox(),
                    dto.getMaximumBOX());
            return ResponseEntity.badRequest()
                    .body("출고 박스 수가 최대 적재량을 초과했습니다.");
        }

        try {
            dto.setApprovedOrderID(instructionId);
            outboundOrderService.updateOrderStatus(dto);

            log.info("✅ 배차 등록 성공");
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            log.error("❌ 배차 등록 실패", e);
            return ResponseEntity.status(500).body("error: " + e.getMessage());
        }
    }
}

