package com.ssg.wms.common;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
@RequiredArgsConstructor
@Log4j2
public class CommonController {
    // 전역 컨트롤러
    @GetMapping("/login")
    public String getMemberLogin() {
        // 로그인 화면(권한별로 분기 시작)
        return "/login";
    }
}
