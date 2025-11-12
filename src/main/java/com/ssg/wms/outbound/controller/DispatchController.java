package com.ssg.wms.outbound.controller;

import com.ssg.wms.common.Role;
import com.ssg.wms.outbound.domain.Criteria;
import com.ssg.wms.outbound.domain.dto.DispatchDTO;
import com.ssg.wms.outbound.service.DispatchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

    @RestController
    @RequestMapping("/admin/dispatches") // 기본 경로
    @RequiredArgsConstructor
    @Log4j2
    public class DispatchController {

        private final DispatchService dispatchService;

//        private boolean isAdmin(HttpSession session) {
//            Object role = session.getAttribute("role");
//            return role != null && role.equals(Role.ADMIN);
//        }

        /** 배차 목록 조회 */
        @GetMapping
        public ResponseEntity<List<DispatchDTO>> getDispatchList(
                HttpSession session,
                Criteria criteria,
                @RequestParam(required = false) String driverName) {

//            if (!isAdmin(session)) return ResponseEntity.status(403).build();

            log.info("배차 목록 조회 요청 - driverName: {}", driverName);
            List<DispatchDTO> dispatchList = dispatchService.getDispatchList(criteria, driverName);
            return ResponseEntity.ok(dispatchList);
        }

        /** 배차 상세 조회 */
        @GetMapping("/{dispatchId}")
        public ResponseEntity<DispatchDTO> getDispatchDetail(
                @PathVariable Long dispatchId,
                HttpSession session) {

//            if (!isAdmin(session)) return ResponseEntity.status(403).build();

            log.info("배차 상세 조회 요청 - Dispatch ID: {}", dispatchId);
            DispatchDTO detail = dispatchService.getDispatchDetailById(dispatchId);

            if (detail == null) return ResponseEntity.notFound().build();
            return ResponseEntity.ok(detail);
        }

        /** 배차 수정 */
        @PutMapping("/{dispatchId}")
        public ResponseEntity<Void> updateDispatch(
                @PathVariable Long dispatchId,
                @RequestBody DispatchDTO dispatchDTO,
                HttpSession session) {

//            if (!isAdmin(session)) return ResponseEntity.status(403).build();

            log.info("배차 수정 요청 - ID: {}", dispatchId);
            dispatchDTO.setDispatchId(dispatchId);
            dispatchService.updateDispatchInformation(dispatchDTO);
            return ResponseEntity.ok().build();
        }


        // ✅ 기사 목록 조회 API
        @GetMapping("/drivers")
        public List<DispatchDTO> getDrivers() {
            return dispatchService.getDistinctDrivers();
        }
    }