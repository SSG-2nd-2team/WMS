package com.ssg.wms.admin.dto;

import com.ssg.wms.common.AccountStatus;
import com.ssg.wms.common.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberSearchCriteriaDTO {
    private AccountStatus status;
    private String keyword;
    private LocalDate startDate;
    private LocalDate endDate;

    // 페이징 추가
    private int pageNum = 1;
    private int amount = 10;

    public int getSkip() {
        return (pageNum - 1) * amount;
    }

}
