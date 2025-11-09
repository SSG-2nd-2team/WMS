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
@RequiredArgsConstructor // final로 선언된 Mapper를 자동 주입 (Autowired)
@Transactional // (선택 사항: CUD 작업 시 트랜잭션 보장)
public class ExpenseServiceImpl implements ExpenseService {

    private final ExpenseMapper expenseMapper;
    private final ModelMapper modelMapper; // DTO <-> VO 변환용

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
        // Java 8/9 호환 방식: () -> new ... 를 인자로 전달합니다.
        return expenseMapper.findById(id).orElseThrow(() ->
                new NoSuchElementException("ID " + id + "에 해당하는 Expense 를 찾을 수 없습니다.")
        );
    }

    @Override
    public Long saveExpense(ExpenseSaveDTO dto) {
        // DTO 를 VO(Entity)로 변환
        ExpenseVO expenseVO = modelMapper.map(dto, ExpenseVO.class);
        expenseMapper.save(expenseVO);
        return expenseVO.getId(); // 저장 후 생성된 PK 반환
    }

    @Override
    public void updateExpense(Long id, ExpenseSaveDTO dto) {
        // DTO를 VO로 변환
        ExpenseVO expenseVO = modelMapper.map(dto, ExpenseVO.class);
        ExpenseVO finalVO = expenseVO.toBuilder()
                .id(id) // URL 에서 받은 id로 설정
                .build();
        expenseMapper.update(finalVO);
    }

    @Override
    public void deleteExpense(Long id) {
        expenseMapper.delete(id);
    }

    @Override
    public List<CategorySummaryDTO> getAnnualExpenseSummary(int year) {
        return expenseMapper.findSummaryByCategory(year);
    }
}