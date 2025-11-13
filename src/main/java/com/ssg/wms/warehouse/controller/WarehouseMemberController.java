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



        Long loggedInUserId = null;
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj != null) {
            try {
                loggedInUserId = (Long) userIdObj;
            } catch (ClassCastException e) {
                // 세션에 String으로 저장되었을 경우 (예외 처리 후 String으로 변환 시도)
                try {
                    loggedInUserId = Long.valueOf(userIdObj.toString());
                } catch (NumberFormatException nfe) {
                    System.err.println("세션 ID를 Long 타입으로 변환할 수 없습니다: " + userIdObj);
                }
            }
        }


        if (loggedInUserId == null) {

            redirectAttributes.addFlashAttribute("error", "로그인 정보가 유효하지 않습니다.");
            return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
        }

        try {
            List<WarehouseListDTO> list = memberService.findWarehouses(searchForm);

            model.addAttribute("tableWarehouseList", list);


            String jsonList = objectMapper.writeValueAsString(list);

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

            return "redirect:/mbr/warehouses";
        }


        return "warehouse/detail";
    }

    // 창고 목록 데이터 조회
    @GetMapping("/api/warehouses")
    @ResponseBody
    public List<WarehouseListDTO> getWarehouseList(@ModelAttribute WarehouseSearchDTO searchForm) {

        return memberService.findWarehouses(searchForm);
    }


    @GetMapping("/api/warehouses/{whid}")
    @ResponseBody
    public WarehouseDetailDTO getWarehouseDetail(@PathVariable("whid") Long warehouseId) {
        return memberService.findWarehouseDetailById(warehouseId);
    }
}