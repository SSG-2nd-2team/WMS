package com.ssg.wms.inbound.mappers;

import com.ssg.wms.inbound.dto.InboundDTO;
import com.ssg.wms.inbound.dto.InboundListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InboundAdminMapper {

    List<InboundListDTO> selectInboundListByPartner(@Param("partnerId") Long partnerId, @Param("inboundStatus") String status);

    InboundDTO selectInboundWithItems(int inboundId);

}
