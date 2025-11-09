package com.ssg.wms.admin.controller;

import com.ssg.wms.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Log4j2
public class AdminController {
//    private final AdminService adminService;

    @GetMapping("/")
    public String getAdminMain() {
        return "admin/connect";
    }

    @GetMapping("/login")
    public String getAdminLogin() {
        return "admin/login";
    }

}
