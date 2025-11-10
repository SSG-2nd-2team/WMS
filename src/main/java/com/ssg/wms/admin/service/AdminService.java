package com.ssg.wms.admin.service;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.domain.Staff;
import com.ssg.wms.admin.dto.MemberSearchCriteriaDTO;
import com.ssg.wms.admin.dto.StaffDTO;

import java.util.List;

public interface AdminService {
    StaffDTO getStaffDetails(long staffId);
    List<Member> getMembersByCriteria(MemberSearchCriteriaDTO criteria);
    Member getMemberDetails(long memberId);
    long findStaffIdByStaffLoginId(String staffLoginId);
}
