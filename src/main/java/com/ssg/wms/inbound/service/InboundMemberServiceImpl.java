package com.ssg.wms.inbound.service;

import com.ssg.wms.inbound.domain.InboundItemVO;
import com.ssg.wms.inbound.domain.InboundVO;
import com.ssg.wms.inbound.dto.InboundDTO;
import com.ssg.wms.inbound.dto.InboundRequestDTO;
import com.ssg.wms.inbound.dto.InboundRequestItemDTO;
import com.ssg.wms.inbound.mappers.InboundMemberMapper;
import com.ssg.wms.product_ehs.dto.ProductDTO;
import com.ssg.wms.product_ehs.mappers.ProductMapper;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Primary
@Log4j2
public class InboundMemberServiceImpl implements InboundMemberService {

    @Autowired
    private InboundMemberMapper inboundMemberMapper;

    @Autowired
    private ProductMapper productMapper;

    @Transactional
    @Override
    public InboundRequestDTO createInbound(InboundRequestDTO inboundRequestDTO) {

        log.info("=== Service 진입 ===");
        log.info("받은 DTO memberId: {}", inboundRequestDTO.getMemberId());

        // InboundVO 생성 시 memberId 포함!
        InboundVO inboundVO = InboundVO.builder()
                .memberId(inboundRequestDTO.getMemberId())  // ⭐ 추가!
                .inboundStatus("request")
                .build();

        log.info("생성한 VO memberId: {}", inboundVO.getMemberId());

        // inbound 테이블에 INSERT (inboundId가 자동 생성됨)
        inboundMemberMapper.insertInbound(inboundVO);
        int inboundId = inboundVO.getInboundId();

        log.info("생성된 inboundId: {}", inboundId);

        // inbound_item 테이블에 INSERT
        if (inboundRequestDTO.getInboundRequestItems() != null &&
                !inboundRequestDTO.getInboundRequestItems().isEmpty()) {

            for (InboundRequestItemDTO inboundItemDTO : inboundRequestDTO.getInboundRequestItems()) {
                InboundItemVO inboundItemVO = InboundItemVO.builder()
                        .inboundId(inboundId)
                        .productId(inboundItemDTO.getProductId())
                        .quantity(inboundItemDTO.getQuantity())
                        .build();

                inboundMemberMapper.insertInboundItem(inboundItemVO);
                log.info("품목 추가: productId={}, quantity={}",
                        inboundItemDTO.getProductId(),
                        inboundItemDTO.getQuantity());
            }
        }

        log.info("입고 요청 생성 완료!");
        return inboundRequestDTO;
    }

    @Override
    public List<ProductDTO> getProductsByPartnerAndCategory(int partnerId, int categoryCd) {
        return productMapper.selectProductsByPartnerAndCategory(partnerId, categoryCd);
    }

    @Override
    public InboundDTO getInboundById(int inboundId) {
        return inboundMemberMapper.selectInboundWithItems(inboundId);
    }

}