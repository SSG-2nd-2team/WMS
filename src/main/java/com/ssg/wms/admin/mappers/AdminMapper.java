package com.ssg.wms.admin.mappers;

import com.ssg.wms.member.domain.Member;
import com.ssg.wms.admin.dto.MemberCriteria;
import com.ssg.wms.manager.dto.StaffDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminMapper {
    StaffDTO getStaffDetails(long staffId);
    long findStaffIdByStaffLoginId(String staffLoginId);
    List<Member> getMembersByCriteria(MemberCriteria criteria);
    Member getMemberDetails(long memberId);
    int getMemberTotalCount(MemberCriteria criteria);
    void updateMemberStatus(@Param("memberId") long memberId, @Param("status") String status);
}
