package com.ssg.wms.admin.service;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.dto.MemberCriteria;
import com.ssg.wms.admin.dto.StaffDTO;
import com.ssg.wms.common.AccountStatus;

import java.util.List;

public interface AdminService {
    StaffDTO getStaffDetails(long staffId);
    List<Member> getMembersByCriteria(MemberCriteria criteria);
    Member getMemberDetails(long memberId);
    long findStaffIdByStaffLoginId(String staffLoginId);
    int getMemberTotalCount(MemberCriteria cri);
    void changeMemberStatus(long memberId, AccountStatus status);
}
