package com.ssg.wms.reply.mappers;

import com.ssg.wms.reply.dto.ReplyDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {
    List<ReplyDTO> findRepliesByInquiryId(Long inquiryId);
    void insertReply(ReplyDTO replyDTO);
    ReplyDTO findByIdAndInquiryId(Long replyId, Long inquiryId);
    void updateReply(ReplyDTO replyDTO);
    void deleteReply(Long replyId, Long inquiryId);
}
