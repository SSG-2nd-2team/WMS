package com.ssg.wms.admin.mappers;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.domain.Staff;
import com.ssg.wms.admin.dto.MemberSearchCriteriaDTO;
import com.ssg.wms.admin.dto.StaffDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    StaffDTO getStaffDetails(long staffId);
    long findStaffIdByStaffLoginId(String staffLoginId);
    List<Member> getMembersByCriteria(MemberSearchCriteriaDTO criteria);
    Member getMemberDetails(long memberId);
}
