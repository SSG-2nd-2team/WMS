package com.ssg.wms.admin.service;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.domain.Staff;
import com.ssg.wms.admin.dto.MemberSearchCriteriaDTO;
import com.ssg.wms.admin.dto.StaffDTO;
import com.ssg.wms.admin.mappers.AdminMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper adminMapper;

    @Override
    public StaffDTO getStaffDetails(long staffId) {
        return adminMapper.getStaffDetails(staffId);
    }

    @Override
    public List<Member> getMembersByCriteria(MemberSearchCriteriaDTO criteria) {
        return adminMapper.getMembersByCriteria(criteria);
    }

    @Override
    public Member getMemberDetails(long memberId) {
        return adminMapper.getMemberDetails(memberId);
    }

    @Override
    public long findStaffIdByStaffLoginId(String staffLoginId) {
        return adminMapper.findStaffIdByStaffLoginId(staffLoginId);
    }
}
