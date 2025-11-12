package com.ssg.wms.member.service;

import com.ssg.wms.member.dto.MemberDTO;
import com.ssg.wms.member.dto.MemberUpdateDTO;
import com.ssg.wms.member.mappers.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Log4j2
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Override
    public MemberDTO getMemberDetails(long memberId) {
        return memberMapper.getMemberDetails(memberId);
    }

    @Override
    public long findMemberIdByMemberLoginId(String memberLoginId) {
        return memberMapper.findMemberIdByMemberLoginId(memberLoginId);
    }

    @Override
    public void insertMember(MemberDTO memberDTO) {
        memberMapper.insertMember(memberDTO);
    }

    @Override
    public void updateMember(long memberId, MemberUpdateDTO memberUpdateDTO) {
        memberUpdateDTO.setMemberId(memberId);
        memberMapper.updateMember(memberUpdateDTO);
    }
}
