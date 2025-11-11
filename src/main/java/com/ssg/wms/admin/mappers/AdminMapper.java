package com.ssg.wms.admin.mappers;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.domain.Staff;
import com.ssg.wms.admin.dto.MemberCriteria;
import com.ssg.wms.admin.dto.MemberSearchCriteriaDTO;
import com.ssg.wms.admin.dto.StaffDTO;
import com.ssg.wms.common.AccountStatus;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    StaffDTO getStaffDetails(long staffId);
    long findStaffIdByStaffLoginId(String staffLoginId);
    List<Member> getMembersByCriteria(MemberCriteria criteria);
    Member getMemberDetails(long memberId);
    int getMemberTotalCount(MemberCriteria criteria);
    void updateMemberStatus(long memberId, String status);
}
