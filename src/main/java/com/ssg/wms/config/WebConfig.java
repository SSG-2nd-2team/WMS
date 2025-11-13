package com.ssg.wms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // 관리자와 창고관리자 둘 다 허용 (ADMIN, MANAGER)
        registry.addInterceptor(new RoleCheckInterceptor("ADMIN", "MANAGER"))
                .addPathPatterns(

                );

        // 관리자만 허용 (ADMIN)
        registry.addInterceptor(new RoleCheckInterceptor("ADMIN"))
                .addPathPatterns(
                        "/announcements/save",
                        "/announcements/*/edit",
                        "/announcements/*/delete",
                        "/admin/**",
                        "*/admin/**"
                );
    }
}
