package com.ssg.wms.finance.mappers;

import com.ssg.wms.finance.domain.ExpenseVO;
import com.ssg.wms.finance.dto.CategorySummaryDTO;
import com.ssg.wms.finance.dto.DashboardSummaryDTO;
import com.ssg.wms.finance.dto.ExpenseRequestDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ExpenseMapper {
    List<ExpenseVO> findAll(ExpenseRequestDTO dto);

    int count(ExpenseRequestDTO dto);

    Optional<ExpenseVO> findById(Long id);

    void save(ExpenseVO expenseVO);

    void update(ExpenseVO expenseVO);

    void delete(Long id);

    List<CategorySummaryDTO> findSummaryByCategory(int year);

    List<DashboardSummaryDTO> findMonthlySummary(int year);
}
