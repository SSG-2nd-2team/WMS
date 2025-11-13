USE wmstestdb;
-- ===================================================
-- Sales (매출) Mock Data
-- (순이익이 커 보이도록 금액 상향 조정)
-- ===================================================

-- 2021년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2021-11-15', '월 이용료', 'Nike', 80000000, '2021년 11월 강남창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2021-12-20', '작업비', 'Adidas', 55000000, '2021년 12월 연말 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2022년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2022-05-15', '월 이용료', 'Puma', 78000000, '2022년 5월 마포창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2022-11-20', '추가 보관료', 'Nike', 45000000, '2022년 11월 초과 물량 보관');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2023년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('성동창고', '2023-01-15', '월 이용료', 'Reebok', 62000000, '2023년 1월 성동창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('동대문창고', '2023-06-15', '월 이용료', 'New Balance', 57000000, '2023년 6월 동대문창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2023-11-25', '작업비', 'Nike', 88000000, '2023년 11월 특별 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2024년 (매월 데이터)
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('종로창고', '2024-01-15', '월 이용료', 'Converse', 55000000, '2024년 1월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강서창고', '2024-02-15', '월 이용료', 'Fila', 42000000, '2024년 2월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2024-03-15', '월 이용료', 'Under Armour', 60000000, '2024년 3월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('광진창고', '2024-04-15', '월 이용료', 'Asics', 52000000, '2024년 4월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('중구창고', '2024-05-15', '월 이용료', 'Vans', 48000000, '2024년 5월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2024-06-15', '월 이용료', 'Nike', 70000000, '2024년 6월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2024-07-20', '추가 보관료', 'Adidas', 48000000, '2024년 7월 성수기');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2024-08-15', '월 이용료', 'Puma', 50000000, '2024년 8월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('성동창고', '2024-09-15', '월 이용료', 'Reebok', 48000000, '2024년 9월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('동대문창고', '2024-10-15', '월 이용료', 'New Balance', 51000000, '2024년 10월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2024-11-25', '작업비', 'Nike', 94500000, '2024년 11월 블프 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('종로창고', '2024-12-15', '월 이용료', 'Converse', 85000000, '2024년 12월 연말 특수');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2025년 (매월 데이터)
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강서창고', '2025-01-15', '월 이용료', 'Fila', 54000000, '2025년 1월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2025-02-15', '월 이용료', 'Under Armour', 61000000, '2025년 2월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2025-03-20', '기타', 'Adidas', 15000000, '2025년 3월 컨설팅');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('광진창고', '2025-04-15', '월 이용료', 'Asics', 53000000, '2025년 4월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('중구창고', '2025-05-15', '월 이용료', 'Vans', 49000000, '2025년 5월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-06-15', '월 이용료', 'Nike', 82000000, '2025년 6월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('마포창고', '2025-07-15', '월 이용료', 'Puma', 60000000, '2025년 7월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-08-25', '추가 보관료', 'Nike', 32500000, '2025년 8월 말 물량 급증');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('용산창고', '2025-09-01', '월 이용료', 'Under Armour', 62000000, '2025년 9월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-10-05', '작업비', 'Nike', 31800000, '2025년 10월 반품 처리');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('서초창고', '2025-11-10', '월 이용료', 'Adidas', 65000000, '2025년 11월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('강남창고', '2025-11-11', '월 이용료', 'SSG (테스트)', 102100000, '2025년 11월 SSG');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();


-- ===================================================
-- Expense (지출) Mock Data (2021 ~ 2025년)
-- (순이익이 커 보이도록 금액 하향 조정)
-- ===================================================

-- 2021년
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2021-11-05', '임대료', 15000000, '2021년 11월 월세');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2021-12-10', '인건비', 12000000, '2021년 12월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();

-- 2022년
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2022-05-05', '임대료', 18000000, '2022년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('서초창고', '2022-11-10', '인건비', 13000000, '2022년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();

-- 2023년
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2023-01-25', '관리비', 3500000, '2023년 1월 전기/수도');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('성동창고', '2023-06-05', '임대료', 15000000, '2023년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('동대문창고', '2023-11-05', '임대료', 17000000, '2023년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();

-- 2024년 (매월 2회씩)
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2024-01-05', '임대료', 15000000, '2024년 1월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-01-10', '인건비', 18000000, '2024년 1월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('종로창고', '2024-02-05', '임대료', 12000000, '2024년 2월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-02-10', '인건비', 18000000, '2024년 2월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강서창고', '2024-03-05', '임대료', 10000000, '2024년 3월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-03-10', '인건비', 18000000, '2024년 3월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2024-04-05', '임대료', 20000000, '2024년 4월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-04-10', '인건비', 18000000, '2024년 4월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('광진창고', '2024-05-05', '임대료', 16000000, '2024년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-05-10', '인건비', 18000000, '2024년 5월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('중구창고', '2024-06-05', '임대료', 14000000, '2024년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-06-10', '인건비', 18000000, '2024년 6월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2024-07-05', '임대료', 25000000, '2024년 7월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-07-10', '인건비', 19000000, '2024년 7월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('마포창고', '2024-08-05', '임대료', 18000000, '2024년 8월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-08-10', '인건비', 19000000, '2024년 8월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('성동창고', '2024-09-05', '임대료', 15000000, '2024년 9월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-09-10', '인건비', 20000000, '2024년 9월 급여(추석 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('동대문창고', '2024-10-05', '임대료', 17000000, '2024년 10월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-10-10', '인건비', 19500000, '2024년 10월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('종로창고', '2024-11-05', '임대료', 12000000, '2024년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-11-10', '인건비', 19500000, '2024년 11월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강서창고', '2024-12-05', '임대료', 10000000, '2024년 12월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-12-10', '인건비', 19500000, '2024년 12월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();

-- 2025년 (매월 2회씩)
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2025-01-05', '임대료', 20000000, '2025년 1월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-01-10', '인건비', 22000000, '2025년 1월 급여(설 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('광진창고', '2025-02-05', '임대료', 16000000, '2025년 2월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-02-10', '인건비', 20000000, '2025년 2월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('중구창고', '2025-03-05', '임대료', 14000000, '2025년 3월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-03-10', '인건비', 20000000, '2025년 3월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강남창고', '2025-04-05', '임대료', 25000000, '2025년 4월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-04-10', '인건비', 20000000, '2025년 4월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('서초창고', '2025-05-05', '임대료', 22000000, '2025년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-05-10', '인건비', 20000000, '2025년 5월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('마포창고', '2025-06-05', '임대료', 18000000, '2025년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-06-10', '인건비', 20000000, '2025년 6월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('성동창고', '2025-07-05', '임대료', 15000000, '2025년 7월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-07-10', '인건비', 21000000, '2025년 7월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('동대문창고', '2025-08-05', '임대료', 17000000, '2025년 8월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-08-10', '인건비', 21000000, '2025년 8월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('종로창고', '2025-09-05', '임대료', 12000000, '2025년 9월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-09-10', '인건비', 22000000, '2025년 9월 급여(추석 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('강서창고', '2025-10-05', '임대료', 10000000, '2025년 10월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-10-10', '인건비', 21000000, '2025년 10월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('용산창고', '2025-11-05', '임대료', 20000000, '2025년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-11-10', '인건비', 21000000, '2025년 11월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('경기 창고', '2025-11-11', '임대료', 65749600, '경기 창고');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('경기 창고', '2025-11-11', '임대료', 20000, 'asd');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
