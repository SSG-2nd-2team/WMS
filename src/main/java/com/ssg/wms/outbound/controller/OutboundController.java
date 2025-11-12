package com.ssg.wms.outbound.controller;

import com.ssg.wms.outbound.domain.Criteria;
import com.ssg.wms.outbound.domain.dto.OutboundDTO;
import com.ssg.wms.outbound.service.OutboundService;
import com.ssg.wms.product_ehs.dto.ProductDTO;
import com.ssg.wms.product_ehs.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/member/outbound")
@RequiredArgsConstructor
@Log4j2
public class OutboundController {

    private final OutboundService outboundService;
    private final ProductService productService; // 상품 정보 로드용


//     * 출고요청 전체 조회 (사용자)
//     * 예: GET /member/outbound?userId=1&status=승인대기
// ✅ 출고요청 전체 조회 (화면용)
@GetMapping
public String getAllOutboundRequests(
        @RequestParam(value = "memberId", required = false) Long memberId,
        @RequestParam(value = "status", required = false) String status,
        Model model) {

    log.info("========== 출고요청 목록 조회 시작 ==========");
    log.info("📥 파라미터 - memberId: {}, status: {}", memberId, status);

    List<OutboundDTO> outboundList = outboundService.allOutboundRequests(memberId, status);

    log.info("📦 조회된 데이터 개수: {}", outboundList.size());

    // 🔍 각 항목의 ID 확인
    for (int i = 0; i < outboundList.size(); i++) {
        OutboundDTO dto = outboundList.get(i);
        log.info("  [{}] outboundRequestId: {}, brandName: {}, requestUserName: {}",
                i + 1, dto.getOutboundRequestId(), dto.getBrandName(), dto.getRequestUserName());
    }

    log.info("========== 출고요청 목록 조회 끝 ==========");

    model.addAttribute("outboundList", outboundList);
    return "outbound/member/outboundList";
}


    // ======================================================
    // 1️⃣ 출고 요청 목록 조회 (View 반환)
    // ======================================================
    @GetMapping("/list")
    public String getOutboundList(@RequestParam Long memberId,
                                  @RequestParam(required = false) String status,
                                  Criteria criteria,
                                  Model model) {
        if (memberId == null) {
            return "redirect:/login";
        }
        log.info("출고 요청 목록 조회 - memberId: {}, status: {}", memberId, status);
        List<OutboundDTO> outboundList = outboundService.getRequestsByUserId(memberId, status);

        model.addAttribute("outboundList", outboundList);
        model.addAttribute("memberId", memberId);
        return "outbound/member/outboundList"; // 📄 /WEB-INF/views/outbound/member/outboundList.jsp
    }



    // ======================================================
    // 2️⃣ 출고 요청 생성 페이지 (JSP View)
    // ======================================================
    @GetMapping("/request/form")
    public String getOutboundRequestForm(@RequestParam Long memberId, Model model) {

        if (memberId == null) {
            return "redirect:/login";
        }

        log.info("출고 요청 생성 페이지 접근 - memberId: {}", memberId);

        // ✅ 카테고리 목록 로드
        model.addAttribute("categories", productService.getCategory());
        model.addAttribute("memberId", memberId);

        return "outbound/member/request";
    }





    // ======================================================
    // 5️⃣ 출고 요청 수정 (PUT)
    // ======================================================
    @PutMapping("/request/{outboundRequestId}")
    @ResponseBody
    public ResponseEntity<Void> updateOutboundRequest(
            @PathVariable Long outboundRequestId,
            @RequestParam Long memberId,
            @RequestBody OutboundDTO dto) {

        log.info("출고 요청 수정 - outboundRequestId: {}, memberId: {}", outboundRequestId, memberId);
        outboundService.updateRequest(outboundRequestId, memberId, dto);

        return ResponseEntity.ok().build();
    }



    // ======================================================
    // 4️⃣ 출고 요청 등록 (POST)
    // ======================================================
    @PostMapping("/request")
    public String createOutboundRequest(@ModelAttribute OutboundDTO outboundDTO) {

        if (outboundDTO.getMemberId() == null) {
            return "redirect:/login";
        }

        log.info("출고 요청 등록 - memberId: {}, 품목 수: {}",
                outboundDTO.getMemberId(),
                (outboundDTO.getOutboundRequestItems() != null ? outboundDTO.getOutboundRequestItems().size() : 0));

        outboundService.createOutboundRequest(outboundDTO, outboundDTO.getMemberId());

        return "redirect:/member/outbound/list?memberId=" + outboundDTO.getMemberId();
    }



    //http://localhost:8080/member/outbound/list?memberId=1
    // ======================================================
    // 5️⃣ 출고 요청 상세 조회 (JSON)
    // ======================================================
    @GetMapping("/request/{outboundRequestId}")
    @ResponseBody
    public ResponseEntity<OutboundDTO> getOutboundRequestDetail(
            @PathVariable Long outboundRequestId,
            @RequestParam Long memberId) {

        log.info("출고 요청 상세 조회 - outboundRequestId: {}, memberId: {}", outboundRequestId, memberId);
        OutboundDTO outboundDTO = outboundService.getRequestDetailById(outboundRequestId, memberId);
        return ResponseEntity.ok(outboundDTO);
    }



    // ======================================================
    // 6️⃣ 출고 요청 삭제 (DELETE)
    // ======================================================
    @DeleteMapping("/request/{outboundRequestId}")
    @ResponseBody
    public ResponseEntity<Void> deleteOutboundRequest(
            @PathVariable Long outboundRequestId,
            @RequestParam Long memberId) {

        log.info("출고 요청 삭제 - outboundRequestId: {}, memberId: {}", outboundRequestId, memberId);
        outboundService.deleteRequest(outboundRequestId, memberId);

        return ResponseEntity.ok().build();
    }


    @GetMapping("/products/byCategory")
    @ResponseBody
    public List<ProductDTO> getProductsByPartner(
            @RequestParam Integer categoryCd,
            HttpSession session) {

        // 세션에서 partnerId 가져오기
        Integer partnerId = 1; // 예제
        // 실제 구현: session.getAttribute("loginMemberBrandId");

        return productService.getProductsByPartnerAndCategory(partnerId, categoryCd);
    }

}
