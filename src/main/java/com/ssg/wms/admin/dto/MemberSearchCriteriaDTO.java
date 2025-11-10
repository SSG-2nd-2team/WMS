package com.ssg.wms.admin.dto;

import com.ssg.wms.common.AccountStatus;
import com.ssg.wms.common.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberSearchCriteriaDTO {
    private Role role;
    private AccountStatus status;
    private String keyword;
    private LocalDateTime createdAt;
}
