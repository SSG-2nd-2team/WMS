package com.ssg.wms.finance.controller;

import com.ssg.wms.finance.domain.ExpenseVO;
import com.ssg.wms.finance.dto.ExpenseRequestDTO;
import com.ssg.wms.finance.dto.ExpenseResponseDTO;
import com.ssg.wms.finance.dto.ExpenseSaveDTO;
import com.ssg.wms.finance.service.ExpenseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// @RestController // @Controller가 아닌 @RestController 사용
// @RequestMapping("/api/expense") // API URL 경로
@Log4j2
@RequestMapping("/expense")
@Controller
@RequiredArgsConstructor
public class ExpenseController {

    private final ExpenseService expenseService;

    /**
     * 지출 목록 페이지 (JSP 렌더링) - 화면 요청
     * URL: GET /expense/list
     */
    @GetMapping("/list")
    public String list(Model model, @ModelAttribute ExpenseRequestDTO dto) {
        log.info("Expense list page request: {}", dto);

        ExpenseResponseDTO responseDTO = expenseService.getExpenses(dto);
        model.addAttribute("response", responseDTO);

        return "expense/list";
    }
/*    @GetMapping
    public ResponseEntity<ExpenseResponseDTO> getExpenseList(@ModelAttribute ExpenseRequestDTO dto) {
        ExpenseResponseDTO response = expenseService.getExpenses(dto);
        return ResponseEntity.ok(response);
    }*/

    // 1. 지출 목록 조회
    /**
     * 지출 목록 조회 API (AJAX 용)
     * REST API (AJAX 요청 - 모달에서 호출)
     * URL: GET /expense/api/list
     */
    @GetMapping("/api/list")
    @ResponseBody  // 이 메서드만 JSON 반환
    public ResponseEntity<ExpenseResponseDTO> getExpenseListApi(@ModelAttribute ExpenseRequestDTO dto) {
        log.info("API: Get expense list: {}", dto);
        ExpenseResponseDTO response = expenseService.getExpenses(dto);
        return ResponseEntity.ok(response);
    }


    // 2. 지출 단일 조회
    /**
     * 지출 단건 조회 API (수정 모달 열 때 사용)
     * URL: GET /expense/api/{id}
     */
    @GetMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<ExpenseVO> getExpenseApi(@PathVariable("id") Long id) {
        log.info("API: Get expense by id: {}", id);
        ExpenseVO expenseVO = expenseService.getExpense(id);
        return ResponseEntity.ok(expenseVO);
    }
    /*@GetMapping("/{id}")
    public ResponseEntity<ExpenseVO> getExpense(@PathVariable("id") Long id) {
        ExpenseVO expenseVO = expenseService.getExpense(id);
        return ResponseEntity.ok(expenseVO);
    }*/


    // 3. 지출내역 등록
    /**
     * 지출 등록 API (모달에서 호출)
     * URL: POST /expense/api
     */
    @PostMapping("/api")
    @ResponseBody
    public ResponseEntity<Long> saveExpenseApi(@RequestBody ExpenseSaveDTO dto) {
        log.info("API: Save expense: {}", dto);
        Long newExpenseId = expenseService.saveExpense(dto);
        return new ResponseEntity<>(newExpenseId, HttpStatus.CREATED);
    }
    /*@PostMapping
    public ResponseEntity<Long> saveExpense(@RequestBody ExpenseSaveDTO dto) {
        Long newExpenseId = expenseService.saveExpense(dto);
        return new ResponseEntity<>(newExpenseId, HttpStatus.CREATED);
    }*/


    // 4. 지출내역 수정
    /**
     * 지출 수정 API (모달에서 호출)
     * URL: PUT /expense/api/{id}
     */
    @PutMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<String> updateExpenseApi(@PathVariable("id") Long id, @RequestBody ExpenseSaveDTO dto) {
        log.info("API: Update expense id {}: {}", id, dto);
        expenseService.updateExpense(id, dto);
        return ResponseEntity.ok("success");
    }
    /*@PutMapping("/{id}")
    public ResponseEntity<String> updateExpense(@PathVariable("id") Long id, @RequestBody ExpenseSaveDTO dto) {
        expenseService.updateExpense(id, dto);
        return ResponseEntity.ok("success");
    }*/


    // 5. 지출내역 삭제

    /**
     * 지출 삭제 API (모달에서 호출)
     * URL: DELETE /expense/api/{id}
     */
    @DeleteMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteExpenseApi(@PathVariable("id") Long id) {
        log.info("API: Delete expense id: {}", id);
        expenseService.deleteExpense(id);
        return ResponseEntity.ok("success");
    }
    /*@DeleteMapping("/{id}")
    public ResponseEntity<String> deleteExpense(@PathVariable("id") Long id) {
        expenseService.deleteExpense(id);
        return ResponseEntity.ok("success");
    }*/
}