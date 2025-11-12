package com.ssg.wms.inbound.controller;

import com.ssg.wms.inbound.dto.InboundDTO;
import com.ssg.wms.inbound.dto.InboundDetailDTO;
import com.ssg.wms.inbound.dto.InboundListDTO;
import com.ssg.wms.inbound.dto.InboundRequestDTO;
import com.ssg.wms.product_ehs.dto.CategoryDTO;
import com.ssg.wms.product_ehs.dto.ProductDTO;
import com.ssg.wms.inbound.service.InboundMemberService;
import com.ssg.wms.product_ehs.service.ProductService;
import com.ssg.wms.product_ehs.service.ProductServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/inbound/member")
public class InboundMemberController {

    private final InboundMemberService inboundMemberService;
    private final ProductService productService;

    // 관리자가 승인시에 창고 위치 지정할때 창고 리스트 보려고 사용
//    private final WarehouseService warehouseService

    // 입고 요청 화면 이동
    @GetMapping("/request")
    public String getInboundRequestForm(
//            HttpSession session,
            Model model) {
        // 로그인한 사용자의 user_id를 자동으로 가져오도록
        Long memberId = 1L;  // Integer → Long으로 변경!
//        Long memberId = (Long) session.getAttribute("loginMemberId");
//        String memberName = (String) session.getAttribute("loginMemberName");
        String memberName = "엄홍길";
        model.addAttribute("memberId", memberId);
        model.addAttribute("memberName", memberName);

        // 로그인한 사용자가 속한 거래처를 자동으로 가져오도록
        int partnerId = 1;
//        int partnerId = (Integer) session.getAttribute("loginMemberBrandId");
//        String partnerName = (String) session.getAttribute("loginMemberBrandId");
        String partnerName = "아디다스";
        model.addAttribute("partnerId", partnerId);
        model.addAttribute("partnerName", partnerName);

        // 카테고리 데이터 로드
        List<CategoryDTO> categories = productService.getCategory();
        model.addAttribute("categories", categories);
        log.info(categories);

        return "inbound/member/request";
    }

    @GetMapping("/products/byCategory")
    @ResponseBody
    public ResponseEntity<List<ProductDTO>> getProductsByPartner(
            @RequestParam Integer categoryCd,
            HttpSession session) {

        // 세션에서 partnerId 가져오기
        Integer partnerId = 1; // 예제
        // 실제 구현: session.getAttribute("loginMemberBrandId");

        try {
            List<ProductDTO> products = productService.getProductsByPartnerAndCategory(partnerId, categoryCd);

            if (products == null || products.isEmpty()) {
                return ResponseEntity.ok(Collections.emptyList());
            }

            return ResponseEntity.ok(products);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 입고 요청
    @PostMapping("/request")
    public String inboundRequest(HttpSession session,
                                 @Valid @ModelAttribute InboundRequestDTO inboundRequestDTO) {

        // 로그인한 사용자의 memberId 가져오기
        Long memberId = 1L;
//        Long memberId = (Long) session.getAttribute("loginMemberId");
        inboundRequestDTO.setMemberId(memberId);

        log.info("=== 입고 요청 디버깅 ===");
        log.info("memberId: {}", memberId);
        log.info("DTO: {}", inboundRequestDTO);

        // 서비스 호출하여 DB 저장
        inboundMemberService.createInbound(inboundRequestDTO);

        // 요청 완료 후 이동할 페이지
        return "redirect:/inbound/member/list";
    }

    // 입고 요청 목록 조회 (관리자용 - 브랜드, 상태 파라미터로 받아서 검색)
    @GetMapping("/list")
    public String inboundList(HttpSession session, Model model,
                              @RequestParam(value = "status", required = false) String status) {

        Long memberId = 1L;
//        Long memberId = (Long)session.getAttribute("memberId");
        List<InboundListDTO> list = inboundMemberService.getInboundListByPartner(memberId, status);
        model.addAttribute("list", list);

        return "inbound/member/list";
    }

    // 입고 요청 단건 조회
    @GetMapping("/{inboundId}")
    public ResponseEntity<InboundDetailDTO> getInboundById(@PathVariable int inboundId,
                                                           Model model,
                                                           HttpSession session) {
        InboundDetailDTO inboundDetailDTO = inboundMemberService.getInboundById(inboundId);

        // 테스트용 하드코딩
        if (inboundDetailDTO.getPartnerId() == null) {
            inboundDetailDTO.setPartnerId(1); // 원하는 partnerId 값
        }

        if(inboundDetailDTO == null) {
            return ResponseEntity.notFound().build();
        }


        Long partnerId = 1L;
        // 세션에서 로그인 사용자의 거래처 정보 가져오기
//        Long partnerId = (Long) session.getAttribute("partnerId");
        if (partnerId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        // 거래처 권한 체크
        if (partnerId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        return ResponseEntity.ok(inboundDetailDTO);
    }

    // 입고 요청 수정
    @PutMapping("/{inboundId}")
    public ResponseEntity<InboundDTO> editInboundRequest(
            HttpSession session,
            @PathVariable int inboundId,
            @RequestBody InboundRequestDTO inboundRequestDTO) {

        Long memberId = (Long) session.getAttribute("memberId");
        if(memberId == null) {
            memberId = 1L; // 테스트용
        }
        inboundRequestDTO.setMemberId(memberId);
        inboundRequestDTO.setInboundId(inboundId);

        // 서비스에서 수정 후 최신 데이터 반환
        InboundDTO updatedDto = inboundMemberService.updateInbound(inboundRequestDTO);

        System.out.println("InboundRequestDTO: " + inboundRequestDTO);

        return ResponseEntity.ok(updatedDto);
    }

    // 입고 요청 취소

}