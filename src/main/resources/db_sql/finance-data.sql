USE wmstestdb;

-- 1. 재무 및 출고 테이블 초기화
TRUNCATE TABLE Sales;
TRUNCATE TABLE Expense;
TRUNCATE TABLE outboundRequest;

-- 2. ALTER TABLE (이미 실행했다면 무시됨)
ALTER TABLE Expense
    ADD COLUMN expense_code VARCHAR(50) NULL COMMENT '지출 관리번호 (예: EXP-202511-001)'
        AFTER expense_id;
ALTER TABLE Sales
    ADD COLUMN sales_code VARCHAR(50) NULL COMMENT '매출 관리번호 (예: SAL-202511-001)'
        AFTER sales_id;

-- ===========================
-- Sales (매출) Mock Data (30건)
-- (이전과 동일. "월 이용료", "작업비", "기타" 등 HTML과 일치)
-- ===========================

-- 1
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2024-10-15', '월 이용료', 'Nike', 40000000, '2024년 10월 강남창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- (이하 Sales 데이터 29건 생략... 이전과 동일)
-- 2
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2024-10-20', '작업비', 'Adidas', 35000000, '긴급 상하차 작업 (매출)');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 3
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2024-11-15', '월 이용료', 'Puma', 25000000, '2024년 11월 마포창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 4
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2024-11-20', '추가 보관료', 'Nike', 15000000, '초과 물량 보관');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 5
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('성동창고', '2024-12-15', '월 이용료', 'Reebok', 20000000, '2024년 12월 성동창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 6
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('동대문창고', '2025-01-15', '월 이용료', 'New Balance', 28000000, '2025년 1월 동대문창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 7
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-01-20', '작업비', 'Nike', 13000000, '설 연휴 특별 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 8
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('종로창고', '2025-02-15', '월 이용료', 'Converse', 15000000, '2025년 2월 종로창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 9
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강서창고', '2025-03-15', '월 이용료', 'Fila', 12000000, '2025년 3월 강서창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 10
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2025-04-15', '월 이용료', 'Under Armour', 30000000, '2025년 4월 용산창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 11
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('광진창고', '2025-05-15', '월 이용료', 'Asics', 22000000, '2025년 5월 광진창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 12
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('중구창고', '2025-06-15', '월 이용료', 'Vans', 18000000, '2025년 6월 중구창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 13
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-07-15', '월 이용료', 'Nike', 30000000, '2025년 7월 강남창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 14
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2025-07-20', '추가 보관료', 'Adidas', 18000000, '7월 성수기 추가 보관');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 15
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2025-08-15', '월 이용료', 'Puma', 20000000, '2025년 8월 마포창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 16
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('성동창고', '2025-08-15', '월 이용료', 'Reebok', 18000000, '2025년 8월 성동창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 17
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('동대문창고', '2025-08-15', '월 이용료', 'New Balance', 21000000, '2025년 8월 동대문창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 18
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-08-25', '작업비', 'Nike', 14500000, '8월 대규모 입고 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 19
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('종로창고', '2025-09-15', '월 이용료', 'Converse', 15000000, '2025년 9월 종로창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 20
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강서창고', '2025-09-15', '월 이용료', 'Fila', 14000000, '2025년 9월 강서창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 21
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2025-09-15', '월 이용료', 'Under Armour', 31000000, '2025년 9월 용산창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 22
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2025-09-20', '기타', 'Adidas', 5000000, '컨설팅 비용 청구');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 23
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('광진창고', '2025-10-15', '월 이용료', 'Asics', 23000000, '2025년 10월 광진창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 24
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('중구창고', '2025-10-15', '월 이용료', 'Vans', 19000000, '2025년 10월 중구창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 25
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-10-15', '월 이용료', 'Nike', 42000000, '2025년 10월 강남창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 26
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2025-10-15', '월 이용료', 'Puma', 20000000, '2025년 10월 마포창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 27
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-10-25', '추가 보관료', 'Nike', 12500000, '10월 말 물량 급증');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 28
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2025-11-01', '월 이용료', 'Under Armour', 32000000, '2025년 11월 용산창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 29
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-11-05', '작업비', 'Nike', 11800000, '반품 처리 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
-- 30
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2025-11-10', '월 이용료', 'Adidas', 25000000, '2025년 11월 서초창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();


-- ===========================
-- Expense (지출) Mock Data (30건)
-- [수정] category 값을 HTML 옵션에 맞게 변경
-- ===========================

-- 1
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2024-10-05', '임대료', 25000000, '2024년 10월 강남창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 2
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('서초창고', '2024-10-05', '임대료', 22000000, '2024년 10월 서초창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 3
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2024-10-10', '인건비', 15000000, '2024년 10월 강남창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 4
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('마포창고', '2024-11-05', '임대료', 18000000, '2024년 11월 마포창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 5
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('서초창고', '2024-11-10', '인건비', 13000000, '2024년 11월 서초창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 6
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2024-11-25', '관리비', 3500000, '2024년 10월 강남창고 전기/수도 요금');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 7
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('성동창고', '2024-12-05', '임대료', 15000000, '2024년 12월 성동창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 8
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('동대문창고', '2025-01-05', '임대료', 17000000, '2025년 1월 동대문창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 9
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-01-10', '인건비', 15500000, '2025년 1월 강남창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 10
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('종로창고', '2025-02-05', '임대료', 12000000, '2025년 2월 종로창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 11
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강서창고', '2025-03-05', '임대료', 10000000, '2025년 3월 강서창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 12
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2025-04-05', '임대료', 20000000, '2025년 4월 용산창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 13
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-04-20', '기타', 4500000, '박스 및 완충재 대량 구매');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 14
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('광진창고', '2025-05-05', '임대료', 16000000, '2025년 5월 광진창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 15
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('중구창고', '2025-06-05', '임대료', 14000000, '2025년 6월 중구창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 16
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-07-05', '임대료', 25000000, '2025년 7월 강남창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 17
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('서초창고', '2025-07-05', '임대료', 22000000, '2025년 7월 서초창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 18
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2025-07-10', '인건비', 18000000, '2025년 7월 용산창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 19
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('마포창고', '2025-08-05', '임대료', 18000000, '2025년 8월 마포창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 20
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('성동창고', '2025-08-05', '임대료', 15000000, '2025년 8월 성동창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 21
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-08-25', '기타', 1200000, '지게차 유류비 및 수리비');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 22
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('동대문창고', '2025-09-05', '임대료', 17000000, '2025년 9월 동대문창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 23
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('종로창고', '2025-09-05', '임대료', 12000000, '2025년 9월 종로창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 24
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-09-25', '관리비', 4200000, '2025년 8월 강남창고 전기/수도 요금');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 25
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강서창고', '2025-10-05', '임대료', 10000000, '2025년 10월 강서창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 26
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2025-10-05', '임대료', 20000000, '2025년 10월 용산창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 27
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('광진창고', '2025-10-05', '임대료', 16000000, '2025년 10월 광진창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 28
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-10-10', '인건비', 16000000, '2025년 10월 강남창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 29
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('중구창고', '2025-11-05', '임대료', 14000000, '2025년 11월 중구창고 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
-- 30
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-11-10', '기타', 3000000, '11월 프로모션 대비 포장재 구매');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();


-- ===========================
-- (대시보드용) 1. Inbound 데이터 '완료' 처리 (UPDATE)
-- (inbound-data.sql로 생성한 10건의 데이터를 업데이트합니다)
-- ===========================

-- 2025년 10월 입고 완료 (ID 1~5)
UPDATE inbound
SET inbound_status = 'approved', -- 사용자 요청 상태 'approved'
    inbound_at     = '2025-10-15 14:00:00'
WHERE inbound_id BETWEEN 1 AND 5;

-- 2025년 11월 입고 완료 (ID 6~10)
UPDATE inbound
SET inbound_status = 'approved', -- 사용자 요청 상태 'approved'
    inbound_at     = '2025-11-05 10:00:00'
WHERE inbound_id BETWEEN 6 AND 10;

-- ===========================
-- (대시보드용) 2. Outbound (출고 완료) Mock Data (INSERT)
-- ===========================

-- 2025년 10월 출고 (2건)
INSERT INTO outboundRequest (outboundDate, member_id, warehouse_id, staff_id, approvedStatus, outboundAddress)
VALUES ('2025-10-18 10:00:00', 1, 1, 1, 'Approved', '서울시 강남구'), -- 사용자 요청 상태 'Approved'
       ('2025-10-20 13:00:00', 2, 2, 2, 'Approved', '서울시 서초구');
-- 사용자 요청 상태 'Approved'

-- 2025년 11월 출고 (4건)
INSERT INTO outboundRequest (outboundDate, member_id, warehouse_id, staff_id, approvedStatus, outboundAddress)
VALUES ('2025-11-03 11:00:00', 3, 3, 3, 'Approved', '서울시 마포구'),  -- 사용자 요청 상태 'Approved'
       ('2025-11-06 14:00:00', 4, 4, 4, 'Approved', '서울시 성동구'),  -- 사용자 요청 상태 'Approved'
       ('2025-11-07 10:00:00', 5, 5, 5, 'Approved', '서울시 동대문구'), -- 사용자 요청 상태 'Approved'
       ('2025-11-09 16:00:00', 6, 6, 6, 'Approved', '서울시 종로구');
-- 사용자 요청 상태 'Approved'


ALTER TABLE Expense
    ADD COLUMN expense_code VARCHAR(50) NULL COMMENT '지출 관리번호 (예: EXP-202511-001)'
        AFTER expense_id;
ALTER TABLE Sales
    ADD COLUMN sales_code VARCHAR(50) NULL COMMENT '매출 관리번호 (예: SAL-202511-001)'
        AFTER sales_id;

-- 상태 추가
ALTER TABLE Sales
    ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)';

ALTER TABLE Expense
    ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)';

##############################

CREATE TABLE Expense
(
    expense_id     BIGINT AUTO_INCREMENT PRIMARY KEY                               NOT NULL COMMENT '지출 PK',
    expense_code   VARCHAR(50)                                                     NOT NULL COMMENT '지출 관리번호 (예: EXP-202511-00001)',
    warehouse_name VARCHAR(100)                                                    NOT NULL COMMENT '창고명',
    expense_date   DATE                                                            NOT NULL COMMENT '지출일자',
    category       VARCHAR(50)                                                     NULL COMMENT '지출 분류',
    amount         BIGINT                                                          NOT NULL COMMENT '지출 금액',
    description    VARCHAR(255)                                                    NULL COMMENT '상세 설명',
    reg_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             NOT NULL COMMENT '등록일시',
    mod_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT '수정일시',
    status         VARCHAR(20)                                                     NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)'

) COMMENT '지출 관리 테이블';

CREATE TABLE Sales
(
    sales_id       BIGINT AUTO_INCREMENT PRIMARY KEY                               NOT NULL COMMENT '매출 PK',
    sales_code     VARCHAR(50)                                                     NOT NULL COMMENT '매출 관리번호 (예: SAL-202511-00001)',
    warehouse_name VARCHAR(100)                                                    NOT NULL COMMENT '창고명',
    sales_date     DATE                                                            NOT NULL COMMENT '매출일자',
    category       VARCHAR(50)                                                     NULL COMMENT '매출 분류',
    client_name    VARCHAR(100)                                                    NOT NULL COMMENT '고객사명',
    amount         BIGINT                                                          NOT NULL COMMENT '매출 금액',
    description    VARCHAR(255)                                                    NULL COMMENT '상세 설명',
    reg_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             NOT NULL COMMENT '등록일시',
    mod_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT '수정일시',
    status         VARCHAR(20)                                                     NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)'
) COMMENT '매출 관리 테이블';

##############################

-- 1. 기존 DB가 있다면 삭제 (모든 테이블과 데이터가 삭제됨)
DROP DATABASE IF EXISTS wmstestdb;

-- 2. V4 DDL을 적용할 깨끗한 DB를 다시 생성
CREATE DATABASE wmstestdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. 새로 만든 DB를 사용
USE wmstestdb;