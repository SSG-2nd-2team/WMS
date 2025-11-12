package com.ssg.wms.warehouse.controller;

import com.ssg.wms.warehouse.dto.WarehouseSearchDTO;
import com.ssg.wms.warehouse.service.WarehouseMemberService;

import com.ssg.wms.warehouse.dto.WarehouseListDTO;
import com.ssg.wms.warehouse.dto.WarehouseDetailDTO;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// 🚨 [추가] HttpSession import
import javax.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/member/warehouses")
public class WarehouseMemberController {

    private final WarehouseMemberService memberService;
    private final ObjectMapper objectMapper;

    @Autowired
    public WarehouseMemberController(
            @Qualifier("warehousesMemberServiceImpl")
            WarehouseMemberService memberService,
            ObjectMapper objectMapper) {
        this.memberService = memberService;
        this.objectMapper = objectMapper;
    }


    /// 1. View Controller
    /// 창고 위치 조회
    @GetMapping({"/location", ""})
    public String getWarehouseListView(
            @ModelAttribute WarehouseSearchDTO searchForm,
            Model model,
            RedirectAttributes redirectAttributes,
            HttpSession session) { //

        /// 세션에서 사용자 ID를 가져오는 로직
        Long loggedInUserId = null;
        Object userIdObj = session.getAttribute("userId"); // 세션 키가 "userId"라고 가정

        if (userIdObj != null) {
            try {loggedInUserId = (Long) userIdObj;
            } catch (ClassCastException e) {
                // 세션에 String으로 저장되었을 경우 (예외 처리 후 String으로 변환 시도)
                try {
                    loggedInUserId = Long.valueOf(userIdObj.toString());
                } catch (NumberFormatException nfe) {
                    System.err.println("세션 ID를 Long 타입으로 변환할 수 없습니다: " + userIdObj);
                }
            }
        }



        try {
            List<WarehouseListDTO> list = memberService.findWarehouses(searchForm);

            // 1. 테이블 출력용: DTO List 그대로 Model에 담기
            model.addAttribute("tableWarehouseList", list);

            // 2. JavaScript 지도용: DTO 목록을 JSON 문자열로 변환
            String jsonList = objectMapper.writeValueAsString(list);

            // 3. JavaScript용 데이터는 별도의 이름으로 Model에 담기
            model.addAttribute("jsWarehouseData", jsonList);

        } catch (JsonProcessingException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "데이터 처리 중 오류가 발생했습니다.");
            return "redirect:/error";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "창고 목록을 불러오는 데 실패했습니다.");
            return "redirect:/error";
        }

        return "warehouse/list";
    }

    
    // 창고 상세 화면 로드 (MEMBER는 조회만 가능)
    @GetMapping("/{whid}")
    public String getWarehouseDetailView(@PathVariable("whid") Long warehouseId, Model model, RedirectAttributes redirectAttributes) {

        try {
            WarehouseDetailDTO detail = memberService.findWarehouseDetailById(warehouseId);
            model.addAttribute("detail", detail);
            model.addAttribute("userRole", "MEMBER");
        } catch (IllegalArgumentException e) {
            // 창고 ID를 찾지 못했을 때
            redirectAttributes.addFlashAttribute("error", "요청하신 창고 정보를 찾을 수 없습니다.");

            return "redirect:/member/warehouses";
        }


        return "warehouse/detail";
    }

    // 창고 목록 데이터 조회 (JSON 제공)
    @GetMapping("/api/warehouses")
    @ResponseBody
    public List<WarehouseListDTO> getWarehouseList(@ModelAttribute WarehouseSearchDTO searchForm) {
        return memberService.findWarehouses(searchForm);
    }

    // 창고 상세 데이터 조회 (JSON 제공)
    @GetMapping("/api/warehouses/{whid}")
    @ResponseBody
    public WarehouseDetailDTO getWarehouseDetail(@PathVariable("whid") Long warehouseId) {
        return memberService.findWarehouseDetailById(warehouseId);
    }
}