package com.ssg.wms.inbound.mappers;

import com.ssg.wms.inbound.domain.InboundItemVO;
import com.ssg.wms.inbound.domain.InboundVO;
import com.ssg.wms.inbound.dto.InboundDTO;
import com.ssg.wms.inbound.dto.InboundListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InboundMemberMapper {

    // 입고 요청
    int insertInbound(InboundVO inboundVO);
    void insertInboundItem(InboundItemVO item);

    // 입고 요청 목록 조회 (사용자용 - 브랜드, 상태 파라미터로 받아서 검색)
    List<InboundListDTO> selectInboundListByPartner(@Param("memberId") Long memberId, @Param("inboundStatus") String status);

    // 입고 요청 단건 조회
    InboundDTO selectInboundWithItems(int inboundId);

    // 입고 요청 수정

    // 입고 요청 취소

}
