package com.ssg.wms.manager.mappers;

import com.ssg.wms.admin.dto.MemberCriteria;
import com.ssg.wms.manager.dto.StaffDTO;
import com.ssg.wms.member.domain.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ManagerMapper {
    StaffDTO getManagerDetails(long staffId);
    long findStaffIdByStaffLoginId(String staffLoginId);
    void updateManager(StaffDTO staffDTO);
}
