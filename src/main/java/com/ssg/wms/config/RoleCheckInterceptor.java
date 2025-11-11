package com.ssg.wms.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Component
public class RoleCheckInterceptor implements HandlerInterceptor {
    private final List<String> allowedRoles;

    // 생성자로 허용할 역할 목록을 주입
    public RoleCheckInterceptor(String... roles) {
        this.allowedRoles = Arrays.asList(roles);
    }

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("/login");
            return false;
        }

        String role = (String) session.getAttribute("role");

        // 허용된 권한에 포함되는지 검사
        if (!allowedRoles.contains(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "권한이 없습니다.");
            return false;
        }

        return true;
    }
}
