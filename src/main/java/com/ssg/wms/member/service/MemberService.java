package com.ssg.wms.member.service;

import com.ssg.wms.member.dto.MemberDTO;
import com.ssg.wms.member.dto.MemberUpdateDTO;

public interface MemberService {
    MemberDTO getMemberDetails(long memberId);
    long findMemberIdByMemberLoginId(String memberLoginId);
    void insertMember(MemberDTO memberDTO);
    void updateMember(long memberId, MemberUpdateDTO memberUpdateDTO);
}
