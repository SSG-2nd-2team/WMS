package com.ssg.wms.inquiry.mappers;

import com.ssg.wms.announcement.dto.AnnouncementDTO;
import com.ssg.wms.announcement.dto.AnnouncementSearch;
import com.ssg.wms.inquiry.dto.InquiryDTO;
import com.ssg.wms.inquiry.dto.InquirySearch;

import java.util.List;

public interface InquiryMapper {
    List<InquiryDTO> selectInquiries(InquirySearch search);

    int countInquiries(InquirySearch search);

    InquiryDTO selectInquiryById(Long id);

    void insertInquiry(InquiryDTO dto);

    void updateInquiry(InquiryDTO dto);

    void deleteInquiry(Long id);
}
