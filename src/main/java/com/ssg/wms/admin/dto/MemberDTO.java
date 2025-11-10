package com.ssg.wms.admin.dto;

import com.ssg.wms.common.AccountStatus;
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
    private long staffId;
    private String memberLoginId;
    private String memberName;
    private String memberPw;
    private String memberPhone;
    private String memberEmail;
    private Role role;
    private AccountStatus status;
    private String businessNumber;

}
