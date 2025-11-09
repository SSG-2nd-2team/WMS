package com.ssg.wms.admin.dto;

import com.ssg.wms.common.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StaffDTO {
    private String staffName;
    private String staffPw;
    private String staffPhone;
    private String staffEmail;
    private Role role;

}
