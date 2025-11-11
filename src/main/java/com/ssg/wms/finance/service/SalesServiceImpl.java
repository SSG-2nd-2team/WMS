package com.ssg.wms.finance.service;

import com.ssg.wms.finance.domain.SalesVO;
import com.ssg.wms.finance.dto.SalesRequestDTO;
import com.ssg.wms.finance.dto.SalesResponseDTO;
import com.ssg.wms.finance.dto.SalesSaveDTO;
import com.ssg.wms.finance.mappers.SalesMapper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
@Transactional
public class SalesServiceImpl implements SalesService {

    private final SalesMapper salesMapper;
    private final ModelMapper modelMapper;

    @Override
    public SalesResponseDTO getSales(SalesRequestDTO dto) {
        List<SalesVO> salesVO = salesMapper.findAll(dto);
        int total = salesMapper.count(dto);

        SalesResponseDTO response = new SalesResponseDTO();
        response.setSales(salesVO);
        response.setTotal(total);
        response.setPage(dto.getPage());
        response.setSize(dto.getSize());
        return response;
    }

    @Override
    public SalesVO getSale(Long id) {
        return salesMapper.findById(id).orElseThrow(() ->
                new NoSuchElementException("ID " + id + "에 해당하는 Sales 를 찾을 수 없습니다.")
        );
    }

    @Override
    public Long saveSales(SalesSaveDTO dto) {
        SalesVO salesVO = modelMapper.map(dto, SalesVO.class);
        salesMapper.save(salesVO);
        return salesVO.getId();
    }

    @Override
    public void updateSales(Long id, SalesSaveDTO dto) {
        SalesVO salesVO = modelMapper.map(dto, SalesVO.class);
        SalesVO finalVO = salesVO.toBuilder()
                .id(id)
                .build();
        salesMapper.update(finalVO);
    }

    @Override
    public void deleteSales(Long id) {
        salesMapper.delete(id);
    }
}