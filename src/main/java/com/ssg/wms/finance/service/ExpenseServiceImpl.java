package com.ssg.wms.finance.service;

import com.ssg.wms.finance.domain.ExpenseVO;
import com.ssg.wms.finance.dto.CategorySummaryDTO;
import com.ssg.wms.finance.dto.ExpenseRequestDTO;
import com.ssg.wms.finance.dto.ExpenseResponseDTO;
import com.ssg.wms.finance.dto.ExpenseSaveDTO;
import com.ssg.wms.finance.mappers.ExpenseMapper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
@Transactional
public class ExpenseServiceImpl implements ExpenseService {

    private final ExpenseMapper expenseMapper;
    private final ModelMapper modelMapper;

    @Override
    public ExpenseResponseDTO getExpenses(ExpenseRequestDTO dto) {
        List<ExpenseVO> expenses = expenseMapper.findAll(dto);
        int total = expenseMapper.count(dto);

        ExpenseResponseDTO response = new ExpenseResponseDTO();
        response.setExpenses(expenses);
        response.setTotal(total);
        response.setPage(dto.getPage());
        response.setSize(dto.getSize());
        return response;
    }

    @Override
    public ExpenseVO getExpense(Long id) {
        return expenseMapper.findById(id).orElseThrow(() ->
                new NoSuchElementException("ID " + id + "에 해당하는 Expense 를 찾을 수 없습니다.")
        );
    }

    @Override
    public Long saveExpense(ExpenseSaveDTO dto) {
        ExpenseVO expenseVO = modelMapper.map(dto, ExpenseVO.class);
        expenseMapper.save(expenseVO);
        return expenseVO.getId();
    }

    @Override
    public void updateExpense(Long id, ExpenseSaveDTO dto) {
        ExpenseVO expenseVO = modelMapper.map(dto, ExpenseVO.class);
        ExpenseVO finalVO = expenseVO.toBuilder()
                .id(id)
                .build();
        expenseMapper.update(finalVO);
    }

    @Override
    public void deleteExpense(Long id) {
        expenseMapper.delete(id);
    }

    // [수정] getAnnualExpenseSummary가 Service 인터페이스와 맞도록 @Override 추가
    @Override
    public List<CategorySummaryDTO> getAnnualExpenseSummary(int year) {
        return expenseMapper.findSummaryByCategory(year);
    }

    // [수정] 월별 카테고리 요약 메서드 구현 추가
    @Override
    public List<CategorySummaryDTO> getMonthlyExpenseSummary(int year, int month) {
        return expenseMapper.findSummaryByCategoryForMonth(year, month);
    }
}