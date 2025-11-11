package com.ssg.wms.inbound.controller;

import com.ssg.wms.inbound.dto.InboundDTO;
import com.ssg.wms.inbound.dto.InboundListDTO;
import com.ssg.wms.inbound.service.InboundAdminService;
import com.ssg.wms.inbound.service.InboundMemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/inbound/admin")
public class InboundAdminController {

    private final InboundAdminService inboundAdminService;

    // 입고 요청 목록 조회
    @GetMapping("/list")
    public String inboundList(
//            HttpSession session,
                              Model model,
                              @RequestParam(value = "partnerId", required = false) Long partnerId,
                              @RequestParam(value = "status", required = false) String status) {

        List<InboundListDTO> list = inboundAdminService.getInboundListByPartner(partnerId, status);
        model.addAttribute("list", list);

        return "inbound/admin/list";
    }

    // 입고 요청 단건 조회
    @GetMapping("/{inboundId}")
    public ResponseEntity<InboundDTO> getInbound(@PathVariable int inboundId,
                                                 HttpSession session) {
        InboundDTO inboundDTO = inboundAdminService.getInboundById(inboundId);

        // 테스트용 하드코딩
        if (inboundDTO.getPartnerId() == null) {
            inboundDTO.setPartnerId(1L); // 원하는 partnerId 값
        }

        if(inboundDTO == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(inboundDTO);
    }

    // 입고 요청 수정

    // 입고 요청 취소


}
