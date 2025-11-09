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
public class MemberDTO {
    private String memberLoginId;
    private String memberName;
    private String memberPw;
    private String memberPhone;
    private String memberEmail;
    private Role role;
    private String businessNumber;

}
