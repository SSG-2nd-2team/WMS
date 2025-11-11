package com.ssg.wms.reply.service;

import com.ssg.wms.reply.dto.ReplyDTO;
import com.ssg.wms.reply.mappers.ReplyMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
    private final ReplyMapper replyMapper;

    @Override
    public List<ReplyDTO> getReplies(Long inquiryId) {
        return replyMapper.findRepliesByInquiryId(inquiryId);
    }

    @Override
    public ReplyDTO saveReply(Long inquiryId, ReplyDTO replyDTO) {
        replyDTO.setInquiryId(inquiryId);
        replyMapper.insertReply(replyDTO);
        return replyDTO;
    }

    @Override
    public ReplyDTO getReplyDetail(Long inquiryId, Long replyId) {
        return replyMapper.findByIdAndInquiryId(replyId, inquiryId);
    }

    @Override
    public ReplyDTO updateReply(Long inquiryId, Long replyId, ReplyDTO replyDTO) {
        replyDTO.setInquiryId(inquiryId);
        replyDTO.setReplyId(replyId);
        replyMapper.updateReply(replyDTO);
        return replyDTO;
    }

    @Override
    public void deleteReply(Long inquiryId, Long replyId) {
        replyMapper.deleteReply(replyId, inquiryId);
    }
}
