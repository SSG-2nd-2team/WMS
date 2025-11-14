-- ===================================================
-- 1. DB 생성 및 선택
-- ===================================================
CREATE DATABASE IF NOT EXISTS wmsfinalldb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wmsfinalldb;

-- ===================================================
-- 2. 테이블 초기화 (데이터 리셋용)
-- (FK 제약조건을 잠시 비활성화하여 순서에 상관없이 삭제)
-- ===================================================
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Partner` CASCADE;
DROP TABLE IF EXISTS `category` CASCADE;
DROP TABLE IF EXISTS `WAREHOUSE` CASCADE;
DROP TABLE IF EXISTS `Staff` CASCADE;
DROP TABLE IF EXISTS `Member` CASCADE;
DROP TABLE IF EXISTS `Partner_Fee` CASCADE;
DROP TABLE IF EXISTS `PARTNER_CONTRACT` CASCADE;
DROP TABLE IF EXISTS `Section` CASCADE;
DROP TABLE IF EXISTS `LOCATION` CASCADE;
DROP TABLE IF EXISTS `Product` CASCADE;
DROP TABLE IF EXISTS `inbound` CASCADE;
DROP TABLE IF EXISTS `inbound_item` CASCADE;
DROP TABLE IF EXISTS `outboundRequest` CASCADE;
DROP TABLE IF EXISTS `outboundItem` CASCADE;
DROP TABLE IF EXISTS `outboundOrder` CASCADE;
DROP TABLE IF EXISTS `driver` CASCADE;
DROP TABLE IF EXISTS `dispatch` CASCADE;
DROP TABLE IF EXISTS `waybill` CASCADE;
DROP TABLE IF EXISTS `QR` CASCADE;
DROP TABLE IF EXISTS `Product_Stock` CASCADE;
DROP TABLE IF EXISTS `Physical_Inventory` CASCADE;
DROP TABLE IF EXISTS `product_stock_log` CASCADE;
DROP TABLE IF EXISTS `Inquiry` CASCADE;
DROP TABLE IF EXISTS `Reply` CASCADE;
DROP TABLE IF EXISTS `Announcement` CASCADE;
DROP TABLE IF EXISTS `estimate` CASCADE;
DROP TABLE IF EXISTS `Sales` CASCADE;
DROP TABLE IF EXISTS `Expense` CASCADE;
SET FOREIGN_KEY_CHECKS = 1;

-- ===================================================
-- 3. 팀 공통 테이블 생성 (DDL)
-- (보내주신 DDL을 순서에 맞게 재배치)
-- ===================================================
CREATE TABLE `Partner`
(
    `partner_id`      int          NOT NULL AUTO_INCREMENT COMMENT '거래처 고유 ID',
    `partner_name`    VARCHAR(100) NOT NULL COMMENT '예: 나이키, 아디다스 ...',
    `business_number` VARCHAR(20)  NOT NULL,
    `address`         VARCHAR(255) NOT NULL,
    `created_at`      TIMESTAMP    NOT NULL DEFAULT current_timestamp(),
    `updated_at`      TIMESTAMP    NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`partner_id`)
);
CREATE TABLE `category`
(
    `category_cd`   int          NOT NULL AUTO_INCREMENT,
    `category_name` varchar(200) NOT NULL,
    PRIMARY KEY (`category_cd`)
);
CREATE TABLE `WAREHOUSE`
(
    `warehouse_id`       int            NOT NULL AUTO_INCREMENT COMMENT '창고 고유 식별',
    `admin_id`           int            NOT NULL COMMENT '창고관리담당자ID',
    `name`               varchar(100)   NOT NULL,
    `warehouse_type`     varchar(100)   NOT NULL,
    `warehouse_capacity` int            NULL,
    `warehouse_status`   tinyint        NOT NULL,
    `registration_date`  date           NOT NULL,
    `latest_update_date` timestamp      NOT NULL,
    `address`            varchar(255)   NOT NULL,
    `latitude`           decimal(10, 7) NOT NULL,
    `longitude`          decimal(10, 7) NOT NULL,
    PRIMARY KEY (`warehouse_id`)
);
CREATE TABLE `Staff`
(
    `staff_id`       bigint       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `staff_pw`       varchar(255) NOT NULL,
    `staff_name`     varchar(255) NOT NULL,
    `staff_phone`    varchar(255) NOT NULL,
    `staff_email`    varchar(255) NOT NULL,
    `created_at`     timestamp    NOT NULL DEFAULT current_timestamp(),
    `updated_at`     timestamp    NOT NULL DEFAULT current_timestamp(),
    `status`         varchar(20)  NOT NULL DEFAULT 'ACTIVE',
    `role`           varchar(255) NOT NULL DEFAULT 'MANAGER',
    `staff_login_id` varchar(255) NOT NULL
);
CREATE TABLE `Member`
(
    `member_id`       bigint       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `member_login_id` varchar(255) NOT NULL,
    `member_pw`       varchar(255) NOT NULL,
    `member_name`     varchar(255) NOT NULL,
    `member_phone`    varchar(255) NOT NULL,
    `member_email`    varchar(255) NOT NULL,
    `business_number` varchar(20)  NOT NULL,
    `created_at`      timestamp    NOT NULL DEFAULT current_timestamp(),
    `updated_at`      timestamp    NOT NULL DEFAULT current_timestamp(),
    `status`          varchar(20)  NOT NULL DEFAULT 'PENDING',
    `role`            varchar(255) NOT NULL DEFAULT 'MEMBER',
    `partner_id`      int          NOT NULL,
    CONSTRAINT `FK_Partner_TO_Member_1` FOREIGN KEY (`partner_id`) REFERENCES `Partner` (`partner_id`)
);
CREATE TABLE `Partner_Fee`
(
    `fee_id`     int          NOT NULL AUTO_INCREMENT,
    `partner_id` int          NOT NULL,
    `fee_type`   VARCHAR(255) NOT NULL,
    `price`      DECIMAL      NOT NULL,
    `apply_date` DATE         NULL,
    PRIMARY KEY (`fee_id`),
    CONSTRAINT `FK_Partner_TO_Partner_Fee_1` FOREIGN KEY (`partner_id`) REFERENCES `Partner` (`partner_id`)
);
CREATE TABLE `PARTNER_CONTRACT`
(
    `CONTRACT_ID`     int          NOT NULL AUTO_INCREMENT,
    `partner_id`      int          NOT NULL,
    `CONTRACT_START`  DATE         NULL,
    `CONTRACT_AREA`   DECIMAL      NULL,
    `CONTRACT_STATUS` VARCHAR(255) NOT NULL DEFAULT 'AVAILABLE',
    PRIMARY KEY (`CONTRACT_ID`),
    CONSTRAINT `FK_Partner_TO_PARTNER_CONTRACT_1` FOREIGN KEY (`partner_id`) REFERENCES `Partner` (`partner_id`)
);
CREATE TABLE `Section`
(
    `section_id`      int         NOT NULL AUTO_INCREMENT,
    `warehouse_id`    int         NOT NULL,
    `section_name`    varchar(50) NOT NULL,
    `section_type`    varchar(50) NOT NULL,
    `section_purpose` text        NULL,
    `allocated_area`  int         NULL,
    PRIMARY KEY (`section_id`, `warehouse_id`),
    CONSTRAINT `FK_WAREHOUSE_TO_Section_1` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`)
);
CREATE TABLE `LOCATION`
(
    `location_id`        int            NOT NULL AUTO_INCREMENT,
    `warehouse_id`       int            NOT NULL,
    `location_code`      varchar(100)   NOT NULL,
    `floor_num`          int            NOT NULL,
    `location_type_code` varchar(50)    NOT NULL,
    `max_volume`         decimal(10, 3) NULL,
    PRIMARY KEY (`location_id`),
    CONSTRAINT `FK_WAREHOUSE_TO_LOCATION_1` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`)
);
CREATE TABLE `Product`
(
    `product_id`     varchar(20)  NOT NULL,
    `category_cd`    int          NOT NULL,
    `partner_id`     int          NOT NULL,
    `product_name`   varchar(200) NOT NULL,
    `product_price`  BIGINT       NULL,
    `product_origin` varchar(200) NULL,
    PRIMARY KEY (`product_id`),
    CONSTRAINT `FK_category_TO_Product_1` FOREIGN KEY (`category_cd`) REFERENCES `category` (`category_cd`),
    CONSTRAINT `FK_Partner_TO_Product_1` FOREIGN KEY (`partner_id`) REFERENCES `Partner` (`partner_id`)
);
CREATE TABLE `inbound`
(
    `inbound_id`            int          NOT NULL AUTO_INCREMENT,
    `warehouse_id`          int          NULL,
    `staff_id`              bigint       NULL,
    `member_id`             bigint       NOT NULL,
    `inbound_status`        varchar(100) NOT NULL DEFAULT 'request',
    `inbound_reject_reason` varchar(200) NULL,
    `inbound_requested_at`  timestamp    NOT NULL DEFAULT current_timestamp(),
    `inbound_updated_at`    timestamp    NULL     DEFAULT current_timestamp(),
    `inbound_at`            timestamp    NULL,
    PRIMARY KEY (`inbound_id`),
    CONSTRAINT `FK_WAREHOUSE_TO_inbound_1` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`),
    CONSTRAINT `FK_Staff_TO_inbound_1` FOREIGN KEY (`staff_id`) REFERENCES `Staff` (`staff_id`),
    CONSTRAINT `FK_Member_TO_inbound_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`)
);
CREATE TABLE `inbound_item`
(
    `inbound_item_id` int         NOT NULL AUTO_INCREMENT,
    `product_id`      varchar(20) NOT NULL,
    `inbound_id`      int         NOT NULL,
    `quantity`        int         NOT NULL,
    PRIMARY KEY (`inbound_item_id`),
    CONSTRAINT `FK_Product_TO_inbound_item_1` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
    CONSTRAINT `FK_inbound_TO_inbound_item_1` FOREIGN KEY (`inbound_id`) REFERENCES `inbound` (`inbound_id`)
);
CREATE TABLE `outboundRequest`
(
    `outboundRequest_ID`    INT AUTO_INCREMENT PRIMARY KEY,
    `outboundDate`          TIMESTAMP    NULL,
    `approvedStatus`        VARCHAR(100) NULL,
    `outboundAddress`       VARCHAR(100) NULL,
    `member_id`             BIGINT       NOT NULL,
    `warehouse_id`          INT          NULL,
    `staff_id`              BIGINT       NULL,
    `requestedDeliveryDate` TIMESTAMP    NULL,
    CONSTRAINT `FK_Member_TO_outboundRequest_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
    CONSTRAINT `FK_Staff_TO_outboundRequest_1` FOREIGN KEY (`staff_id`) REFERENCES `Staff` (`staff_id`),
    CONSTRAINT `FK_WAREHOUSE_TO_outboundRequest_1` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`)
);
CREATE TABLE `outboundItem`
(
    `outbound_item_id`   int         NOT NULL AUTO_INCREMENT,
    `outboundRequest_ID` int         NOT NULL,
    `Product_ID`         varchar(20) NOT NULL,
    `outboundQuantity`   int         NOT NULL,
    PRIMARY KEY (`outbound_item_id`),
    CONSTRAINT `FK_outboundRequest_TO_outboundItem_1` FOREIGN KEY (`outboundRequest_ID`) REFERENCES `outboundRequest` (`outboundRequest_ID`),
    CONSTRAINT `FK_Product_TO_outboundItem_1` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`product_id`)
);
CREATE TABLE `outboundOrder`
(
    `approvedOrder_ID`   int         NOT NULL AUTO_INCREMENT,
    `outboundRequest_ID` int         NOT NULL,
    `approvedDate`       TIMESTAMP   NULL,
    `instructionNo`      varchar(10) NULL,
    `orderStatus`        VARCHAR(20) NULL,
    PRIMARY KEY (`approvedOrder_ID`),
    CONSTRAINT `FK_outboundRequest_TO_outboundOrder_1` FOREIGN KEY (`outboundRequest_ID`) REFERENCES `outboundRequest` (`outboundRequest_ID`)
);
CREATE TABLE `driver`
(
    `driver_id`   INT AUTO_INCREMENT PRIMARY KEY,
    `driver_name` VARCHAR(30) NOT NULL,
    `car_id`      INT         NOT NULL,
    `car_number`  VARCHAR(20),
    `car_type`    VARCHAR(20),
    `status`      ENUM ('대기', '운행중', '휴무') DEFAULT '대기'
);
CREATE TABLE `dispatch`
(
    `dispatch_ID`      INT AUTO_INCREMENT PRIMARY KEY,
    `approvedOrder_ID` INT         NOT NULL,
    `carID`            INT         NULL,
    `Cartype`          VARCHAR(20) NULL,
    `driverName`       VARCHAR(10) NULL,
    `assignedDate`     TIMESTAMP   NULL,
    `dispatchStatus`   VARCHAR(10) NULL,
    `loadedBOX`        INT         NULL,
    `maximumBOX`       INT         NULL,
    `driver_id`        INT         NULL,
    CONSTRAINT `FK_outboundOrder_TO_dispatch_1` FOREIGN KEY (`approvedOrder_ID`) REFERENCES `outboundOrder` (`approvedOrder_ID`),
    CONSTRAINT `fk_dispatch_driver` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`)
);
CREATE TABLE `waybill`
(
    `waybill_id`        INT AUTO_INCREMENT PRIMARY KEY,
    `waybill_number`    VARCHAR(50)  NULL,
    `waybill_date`      TIMESTAMP    NULL,
    `waybill_status`    VARCHAR(20)  NULL,
    `dispatch_ID`       INT          NOT NULL,
    `departure_Address` VARCHAR(100) NULL,
    `arrival_Address`   VARCHAR(100) NULL,
    `sender_Name`       VARCHAR(10)  NULL,
    `receiver_Name`     VARCHAR(10)  NULL,
    CONSTRAINT `FK_dispatch_TO_waybill_1` FOREIGN KEY (`dispatch_ID`) REFERENCES `dispatch` (`dispatch_ID`)
);
CREATE TABLE `QR`
(
    `QR_id`      int       NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NULL,
    `waybill_id` int       NOT NULL,
    PRIMARY KEY (`QR_id`),
    CONSTRAINT `FK_waybill_TO_QR_1` FOREIGN KEY (`waybill_id`) REFERENCES `waybill` (`waybill_id`)
);
CREATE TABLE `Product_Stock`
(
    `ps_id`            int         NOT NULL AUTO_INCREMENT,
    `warehouse_id`     int         NOT NULL,
    `section_id`       int         NOT NULL,
    `inbound_item_id`  int         NOT NULL,
    `outbound_item_id` int         NULL,
    `quantity`         int         NOT NULL,
    `product_status`   varchar(50) NOT NULL,
    `last_updatedate`  timestamp   NULL,
    PRIMARY KEY (`ps_id`),
    CONSTRAINT `FK_Section_TO_Product_Stock` FOREIGN KEY (`section_id`, `warehouse_id`) REFERENCES `Section` (`section_id`, `warehouse_id`),
    CONSTRAINT `FK_inbound_item_TO_Product_Stock_1` FOREIGN KEY (`inbound_item_id`) REFERENCES `inbound_item` (`inbound_item_id`),
    CONSTRAINT `FK_outboundItem_TO_Product_Stock_1` FOREIGN KEY (`outbound_item_id`) REFERENCES `outboundItem` (`outbound_item_id`)
);
CREATE TABLE `Physical_Inventory`
(
    `piID`               int         NOT NULL AUTO_INCREMENT,
    `PS_ID`              int         NOT NULL,
    `pi_date`            timestamp   NOT NULL,
    `pi_state`           varchar(30) NOT NULL,
    `pid_quantity`       int         NOT NULL,
    `real_quantity`      int         NULL,
    `different_quantity` int         NULL,
    `update_state`       varchar(30) NULL,
    PRIMARY KEY (`piID`),
    CONSTRAINT `FK_Product_Stock_TO_Physical_Inventory_1` FOREIGN KEY (`PS_ID`) REFERENCES `Product_Stock` (`ps_id`)
);
CREATE TABLE `product_stock_log`
(
    `log_ID`         int         NOT NULL AUTO_INCREMENT,
    `PS_ID`          int         NOT NULL,
    `event_time`     timestamp   NOT NULL,
    `move_quantity`  int         NOT NULL,
    `event_type`     varchar(20) NOT NULL,
    `product_status` varchar(50) NOT NULL,
    `destination`    varchar(30) NOT NULL,
    PRIMARY KEY (`log_ID`),
    CONSTRAINT `FK_Product_Stock_TO_product_stock_log_1` FOREIGN KEY (`PS_ID`) REFERENCES `Product_Stock` (`ps_id`)
);
CREATE TABLE `Inquiry`
(
    `inquiry_id` bigint        NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `title`      varchar(255)  NOT NULL,
    `content`    varchar(1000) NOT NULL,
    `writer`     varchar(255)  NOT NULL,
    `created_at` timestamp     NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp     NOT NULL DEFAULT current_timestamp(),
    `status`     varchar(20)   NOT NULL DEFAULT 'AVAILABLE'
);
CREATE TABLE `Reply`
(
    `reply_id`   bigint       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `inquiry_id` bigint       NOT NULL,
    `content`    varchar(500) NOT NULL,
    `writer`     varchar(255) NOT NULL,
    `created_at` timestamp    NOT NULL DEFAULT current_timestamp(),
    `title`      varchar(255) NOT NULL,
    CONSTRAINT `FK_Inquiry_TO_Reply_1` FOREIGN KEY (`inquiry_id`) REFERENCES `Inquiry` (`inquiry_id`)
);
CREATE TABLE `Announcement`
(
    `announcement_id` bigint        NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `title`           varchar(255)  NOT NULL,
    `content`         varchar(1000) NOT NULL,
    `created_at`      timestamp     NOT NULL DEFAULT current_timestamp(),
    `updated_at`      timestamp     NOT NULL DEFAULT current_timestamp(),
    `status`          varchar(20)   NOT NULL DEFAULT 'AVAILABLE',
    `writer`          varchar(255)  NOT NULL,
    `is_important`    tinyint       NOT NULL DEFAULT 0
);
CREATE TABLE `estimate`
(
    `estimate_id`          BIGINT       NOT NULL AUTO_INCREMENT,
    `member_id`            bigint       NOT NULL,
    `staff_id`             bigint       NOT NULL,
    `is_guest`             tinyint      NOT NULL,
    `guest_name`           varchar(20)  NULL,
    `guest_contact`        varchar(20)  NULL,
    `guest_email`          varchar(40)  NULL,
    `estimate_title`       varchar(200) NOT NULL,
    `estimate_content`     TEXT         NOT NULL,
    `estimate_status`      varchar(20)  NOT NULL DEFAULT 'request',
    `estimate_password`    varchar(100) NULL,
    `estimate_response`    TEXT         NULL,
    `estimate_request_at`  timestamp    NOT NULL DEFAULT current_timestamp(),
    `estimate_response_at` timestamp    NULL,
    PRIMARY KEY (`estimate_id`),
    CONSTRAINT `FK_Member_TO_estimate_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
    CONSTRAINT `FK_Staff_TO_estimate_1` FOREIGN KEY (`staff_id`) REFERENCES `Staff` (`staff_id`)
);
CREATE TABLE `Sales`
(
    `sales_id`       BIGINT AUTO_INCREMENT PRIMARY KEY                               NOT NULL COMMENT '매출 PK',
    `sales_code`     VARCHAR(50)                                                     NULL COMMENT '매출 관리번호 (예: SAL-2511-00001)',
    `warehouse_name` VARCHAR(100)                                                    NOT NULL COMMENT '창고명',
    `sales_date`     DATE                                                            NOT NULL COMMENT '매출일자',
    `category`       VARCHAR(50)                                                     NULL COMMENT '매출 분류',
    `client_name`    VARCHAR(100)                                                    NOT NULL COMMENT '고객사명',
    `amount`         BIGINT                                                          NOT NULL COMMENT '매출 금액',
    `description`    VARCHAR(255)                                                    NULL COMMENT '상세 설명',
    `reg_date`       TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             NOT NULL COMMENT '등록일시',
    `mod_date`       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT '수정일시',
    `status`         VARCHAR(20)                                                     NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)'
);
CREATE TABLE `Expense`
(
    `expense_id`     BIGINT AUTO_INCREMENT PRIMARY KEY                               NOT NULL COMMENT '지출 PK',
    `expense_code`   VARCHAR(50)                                                     NULL COMMENT '지출 관리번호 (예: EXP-2511-00001)',
    `warehouse_name` VARCHAR(100)                                                    NOT NULL COMMENT '창고명',
    `expense_date`   DATE                                                            NOT NULL COMMENT '지출일자',
    `category`       VARCHAR(50)                                                     NULL COMMENT '지출 분류',
    `amount`         BIGINT                                                          NOT NULL COMMENT '지출 금액',
    `description`    VARCHAR(255)                                                    NULL COMMENT '상세 설명',
    `reg_date`       TIMESTAMP DEFAULT CURRENT_TIMESTAMP                             NOT NULL COMMENT '등록일시',
    `mod_date`       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT '수정일시',
    `status`         VARCHAR(20)                                                     NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE, DELETED)'
);

-- ===================================================
-- 4. 공통 Mock Data INSERT
-- ===================================================

INSERT INTO Partner (partner_name, business_number, address)
VALUES ('Nike', '123-45-67890', '서울시 강남구'),
       ('Adidas', '223-45-67890', '서울시 서초구'),
       ('Puma', '323-45-67890', '서울시 마포구'),
       ('Under armour', '423-45-67890', '서울시 성동구'),
       ('New Balance', '523-45-67890', '서울시 동대문구'),
       ('Asics', '623-45-67890', '서울시 종로구'),
       ('lululemon', '723-45-67890', '서울시 강서구'),
       ('Descente', '823-45-67890', '서울시 용산구'),
       ('Skechers', '923-45-67890', '서울시 광진구'),
       ('Spyder', '103-45-67890', '서울시 중구');

INSERT INTO Member (member_login_id, member_pw, member_name, member_phone, member_email, partner_id, business_number,
                    status)
VALUES ('user01', 'pw01', '홍길동', '010-0000-0001', 'user01@example.com', 1, '123-45-67890', 'APPROVED'),
       ('user02', 'pw02', '김철수', '010-0000-0002', 'user02@example.com', 1, '123-45-67890', 'APPROVED'),
       ('user03', 'pw03', '이영희', '010-0000-0003', 'user03@example.com', 2, '223-45-67890', 'APPROVED'),
       ('user04', 'pw04', '박민수', '010-0000-0004', 'user04@example.com', 2, '223-45-67890', 'APPROVED'),
       ('user05', 'pw05', '최수지', '010-0000-0005', 'user05@example.com', 3, '323-45-67890', 'APPROVED'),
       ('user06', 'pw06', '서장훈', '010-0000-0006', 'user06@example.com', 3, '323-45-67890', 'APPROVED'),
       ('user07', 'pw07', '이강민', '010-0000-0007', 'user07@example.com', 4, '423-45-67890', 'APPROVED'),
       ('user08', 'pw08', '오세훈', '010-0000-0008', 'user08@example.com', 4, '423-45-67890', 'APPROVED'),
       ('user09', 'pw09', '한지민', '010-0000-0009', 'user09@example.com', 5, '523-45-67890', 'APPROVED'),
       ('user10', 'pw10', '카리나', '010-0000-0010', 'user10@example.com', 5, '523-45-67890', 'APPROVED'),
       ('user11', 'pw11', '장동민', '010-0000-0011', 'user11@example.com', 6, '623-45-67890', 'APPROVED'),
       ('user12', 'pw12', '김둘리', '010-0000-0012', 'user12@example.com', 6, '623-45-67890', 'APPROVED'),
       ('user13', 'pw13', '양현종', '010-0000-0013', 'user13@example.com', 7, '723-45-67890', 'APPROVED'),
       ('user14', 'pw14', '서건창', '010-0000-0014', 'user14@example.com', 7, '723-45-67890', 'APPROVED'),
       ('user15', 'pw15', '김원훈', '010-0000-0015', 'user15@example.com', 8, '823-45-67890', 'APPROVED'),
       ('user16', 'pw16', '한동훈', '010-0000-0016', 'user16@example.com', 8, '823-45-67890', 'APPROVED'),
       ('user17', 'pw17', '이재명', '010-0000-0017', 'user17@example.com', 9, '923-45-67890', 'APPROVED'),
       ('user18', 'pw18', '김정은', '010-0000-0018', 'user18@example.com', 9, '923-45-67890', 'APPROVED'),
       ('user19', 'pw19', '시진핑', '010-0000-0019', 'user19@example.com', 10, '103-45-67890', 'APPROVED'),
       ('user20', 'pw20', '김선빈', '010-0000-0020', 'user20@example.com', 10, '103-45-67890', 'APPROVED');

INSERT INTO Staff (staff_pw, staff_name, staff_phone, staff_email, staff_login_id, role)
VALUES ('pw101', '김관리', '010-1000-0001', 'staff01@example.com', 'staff01', 'ADMIN'),
       ('pw102', '이관리', '010-1000-0002', 'staff02@example.com', 'staff02', 'MANAGER'),
       ('pw103', '박관리', '010-1000-0003', 'staff03@example.com', 'staff03', 'MANAGER'),
       ('pw104', '최관리', '010-1000-0004', 'staff04@example.com', 'staff04', 'MANAGER'),
       ('pw105', '정관리', '010-1000-0005', 'staff05@example.com', 'staff05', 'MANAGER'),
       ('pw106', '강관리', '010-1000-0006', 'staff06@example.com', 'staff06', 'MANAGER'),
       ('pw107', '윤관리', '010-1000-0007', 'staff07@example.com', 'staff07', 'MANAGER'),
       ('pw108', '오관리', '010-1000-0008', 'staff08@example.com', 'staff08', 'MANAGER'),
       ('pw109', '한관리', '010-1000-0009', 'staff09@example.com', 'staff09', 'MANAGER'),
       ('pw110', '서관리', '010-1000-0010', 'staff10@example.com', 'staff10', 'MANAGER');

INSERT INTO category (category_name)
VALUES ('아우터'),
       ('상의'),
       ('하의'),
       ('신발'),
       ('기타');

INSERT INTO WAREHOUSE (admin_id, name, warehouse_type, warehouse_capacity, warehouse_status, registration_date,
                       latest_update_date, address, latitude, longitude)
VALUES (1, '나이키 창고', '허브', 50000, 1, '2025-11-10', '2025-11-13 14:30:00', '서울 중구 을지로 12', 37.565805, 126.983050),
       (2, '아디다스 창고', '창고', 15000, 2, '2025-11-11', '2025-11-13 10:15:00', '경기 수원시 영통구 광교중앙로 145', 37.291708,
        127.053738),
       (3, '푸마 창고', '창고', 12000, 1, '2025-11-12', '2025-11-13 09:00:00', '부산 해운대구 센텀남대로 35', 35.168782, 129.132800),
       (4, '언더아머 창고', '창고', 18000, 2, '2025-11-10', '2025-11-13 11:45:00', '대구 중구 동성로3길 100', 35.870305, 128.592750),
       (5, '뉴발란스 창고', '창고', 25000, 1, '2025-11-13', '2025-11-13 15:20:00', '인천 연수구 송도국제대로 123', 37.380720, 126.658250),
       (6, '아식스 창고', '창고', 10000, 2, '2025-11-11', '2025-11-13 08:30:00', '광주 서구 무진대로 902', 35.157000, 126.856000),
       (7, '룰루레몬 창고', '창고', 8000, 1, '2025-11-12', '2025-11-13 13:55:00', '대전 서구 둔산로 100', 36.353315, 127.387530),
       (8, '데상트 창고', '창고', 13000, 2, '2025-11-10', '2025-11-13 12:10:00', '울산 남구 삼산로 288', 35.535070, 129.340010),
       (9, '스케쳐스 창고', '창고', 9000, 1, '2025-11-13', '2025-11-13 16:40:00', '제주 제주시 칠성로길 44', 33.515000, 126.525500),
       (10, '스파이더 창고', '창고', 20000, 2, '2025-11-12', '2025-11-13 17:00:00', '강원 춘천시 퇴계로 71', 37.868000, 127.734000);

INSERT INTO Section (warehouse_id, section_name, section_type, section_purpose, allocated_area)
VALUES (1, '나이키 보관구역', 'A', '보관', 3500),
       (2, '아디다스 검수구역', 'B', '검수', 1200),
       (3, '푸마 보관구역', 'C', '보관', 2800),
       (4, '언더아머 검수구역', 'D', '검수', 1500),
       (5, '뉴발란스 보관구역', 'A', '보관', 4100),
       (6, '아식스 검수구역', 'B', '검수', 900),
       (7, '룰루레몬 보관구역', 'C', '보관', 2100),
       (8, '데상트 검수구역', 'D', '검수', 1300),
       (9, '스케쳐스 보관구역', 'A', '보관', 3000),
       (10, '스파이더 검수구역', 'B', '검수', 1800);


-- ===================================================
-- 5. Sales (매출) Mock Data (2021 ~ 2025년)
-- (팀 DDL의 거래처명, 창고명 사용 / 순이익이 높도록 금액 설정)
-- ===================================================

-- 2021년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2021-11-15', '월 이용료', 'Nike', 90000000, '2021년 11월 나이키 창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아디다스 창고', '2021-12-20', '작업비', 'Adidas', 65000000, '2021년 12월 연말 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2022년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('푸마 창고', '2022-05-15', '월 이용료', 'Puma', 78000000, '2022년 5월 푸마 창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2022-11-20', '추가 보관료', 'Nike', 55000000, '2022년 11월 초과 물량 보관');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2023년
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('언더아머 창고', '2023-01-15', '월 이용료', 'Under armour', 62000000, '2023년 1월 언더아머 창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('뉴발란스 창고', '2023-06-15', '월 이용료', 'New Balance', 57000000, '2023년 6월 뉴발란스 창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2023-11-25', '작업비', 'Nike', 98000000, '2023년 11월 특별 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2024년 (매월 데이터)
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아식스 창고', '2024-01-15', '월 이용료', 'Asics', 55000000, '2024년 1월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('룰루레몬 창고', '2024-02-15', '월 이용료', 'lululemon', 42000000, '2024년 2월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('데상트 창고', '2024-03-15', '월 이용료', 'Descente', 60000000, '2024년 3월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('스케쳐스 창고', '2024-04-15', '월 이용료', 'Skechers', 52000000, '2024년 4월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('스파이더 창고', '2024-05-15', '월 이용료', 'Spyder', 48000000, '2024년 5월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2024-06-15', '월 이용료', 'Nike', 70000000, '2024년 6월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아디다스 창고', '2024-07-20', '추가 보관료', 'Adidas', 48000000, '2024년 7월 성수기');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('푸마 창고', '2024-08-15', '월 이용료', 'Puma', 50000000, '2024년 8월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('언더아머 창고', '2024-09-15', '월 이용료', 'Under armour', 48000000, '2024년 9월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('뉴발란스 창고', '2024-10-15', '월 이용료', 'New Balance', 51000000, '2024년 10월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2024-11-25', '작업비', 'Nike', 94500000, '2024년 11월 블프 작업');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아식스 창고', '2024-12-15', '월 이용료', 'Asics', 85000000, '2024년 12월 연말 특수');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();

-- 2025년 (매월 데이터)
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('룰루레몬 창고', '2025-01-15', '월 이용료', 'lululemon', 54000000, '2025년 1월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('데상트 창고', '2025-02-15', '월 이용료', 'Descente', 61000000, '2025년 2월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아디다스 창고', '2025-03-20', '기타', 'Adidas', 15000000, '2025년 3월 컨설팅');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('스케쳐스 창고', '2025-04-15', '월 이용료', 'Skechers', 53000000, '2025년 4월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('스파이더 창고', '2025-05-15', '월 이용료', 'Spyder', 49000000, '2025년 5월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2025-06-15', '월 이용료', 'Nike', 82000000, '2025년 6월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('푸마 창고', '2025-07-15', '월 이용료', 'Puma', 60000000, '2025년 7월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2025-08-25', '추가 보관료', 'Nike', 32500000, '2025년 8월 말 물량 급증');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('언더아머 창고', '2025-09-01', '월 이용료', 'Under armour', 62000000, '2025년 9월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2025-10-05', '작업비', 'Nike', 31800000, '2025년 10월 반품 처리');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('아디다스 창고', '2025-11-10', '월 이용료', 'Adidas', 65000000, '2025년 11월');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고', '2025-11-11', '월 이용료', 'SSG (테스트)', 102100000, '2025년 11월 SSG');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();


-- ===================================================
-- 6. Expense (지출) Mock Data (2021 ~ 2025년)
-- (순이익이 커 보이도록 금액 하향 조정됨)
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
VALUES ('푸마 창고', '2022-05-05', '임대료', 18000000, '2022년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('아디다스 창고', '2022-11-10', '인건비', 13000000, '2022년 11월');
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
VALUES ('언더아머 창고', '2023-06-05', '임대료', 15000000, '2023년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('뉴발란스 창고', '2023-11-05', '임대료', 17000000, '2023년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();

-- 2024년 (매월 2회씩)
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('나이키 창고', '2024-01-05', '임대료', 20000000, '2024년 1월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-01-10', '인건비', 18000000, '2024년 1월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('아식스 창고', '2024-02-05', '임대료', 12000000, '2024년 2월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-02-10', '인건비', 18000000, '2024년 2월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('룰루레몬 창고', '2024-03-05', '임대료', 10000000, '2024년 3월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-03-10', '인건비', 18000000, '2024년 3월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('데상트 창고', '2024-04-05', '임대료', 20000000, '2024년 4월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-04-10', '인건비', 18000000, '2024년 4월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스케쳐스 창고', '2024-05-05', '임대료', 16000000, '2024년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-05-10', '인건비', 18000000, '2024년 5월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스파이더 창고', '2024-06-05', '임대료', 14000000, '2024년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-06-10', '인건비', 18000000, '2024년 6월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('나이키 창고', '2024-07-05', '임대료', 25000000, '2024년 7월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-07-10', '인건비', 19000000, '2024년 7월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('푸마 창고', '2024-08-05', '임대료', 18000000, '2024년 8월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-08-10', '인건비', 19000000, '2024년 8월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('언더아머 창고', '2024-09-05', '임대료', 15000000, '2024년 9월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-09-10', '인건비', 20000000, '2024년 9월 급여(추석 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('뉴발란스 창고', '2024-10-05', '임대료', 17000000, '2024년 10월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-10-10', '인건비', 19500000, '2024년 10월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('아식스 창고', '2024-11-05', '임대료', 12000000, '2024년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2024-11-10', '인건비', 19500000, '2024년 11월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('룰루레몬 창고', '2024-12-05', '임대료', 10000000, '2024년 12월');
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
VALUES ('데상트 창고', '2025-01-05', '임대료', 20000000, '2025년 1월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-01-10', '인건비', 22000000, '2025년 1월 급여(설 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스케쳐스 창고', '2025-02-05', '임대료', 16000000, '2025년 2월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-02-10', '인건비', 20000000, '2025년 2월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스파이더 창고', '2025-03-05', '임대료', 14000000, '2025년 3월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-03-10', '인건비', 20000000, '2025년 3월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('나이키 창고', '2025-04-05', '임대료', 25000000, '2025년 4월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-04-10', '인건비', 20000000, '2025년 4월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('아디다스 창고', '2025-05-05', '임대료', 22000000, '2025년 5월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-05-10', '인건비', 20000000, '2025년 5월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('푸마 창고', '2025-06-05', '임대료', 18000000, '2025년 6월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-06-10', '인건비', 20000000, '2025년 6월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('언더아머 창고', '2025-07-05', '임대료', 15000000, '2025년 7월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-07-10', '인건비', 21000000, '2025년 7월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('뉴발란스 창고', '2025-08-05', '임대료', 17000000, '2025년 8월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-08-10', '인건비', 21000000, '2025년 8월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('아식스 창고', '2025-09-05', '임대료', 12000000, '2025년 9월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-09-10', '인건비', 22000000, '2025년 9월 급여(추석 상여)');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('룰루레몬 창고', '2025-10-05', '임대료', 10000000, '2025년 10월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-10-10', '인건비', 21000000, '2025년 10월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('데상트 창고', '2025-11-05', '임대료', 20000000, '2025년 11월');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('전체', '2025-11-10', '인건비', 21000000, '2025년 11월 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스케쳐스 창고', '2025-11-11', '임대료', 65749600, '경기 창고');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('스파이더 창고', '2025-11-11', '임대료', 20000, 'asd');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();


-- ===================================================
-- 7. 물류 Mock Data (INSERT) - 대시보드 테스트용
-- (FK 제약조건에 맞게 수정)
-- ===================================================
-- 2025년 10월 입고 완료 (5건)
INSERT INTO inbound (inbound_status, inbound_at, warehouse_id, staff_id, member_id)
VALUES ('approved', '2025-10-15 14:00:00', 1, 1, 1),
       ('approved', '2025-10-16 10:00:00', 2, 2, 3),
       ('approved', '2025-10-17 11:00:00', 3, 3, 5),
       ('approved', '2025-10-18 13:00:00', 4, 4, 7),
       ('approved', '2025-10-19 15:00:00', 5, 5, 9);

-- 2025년 11월 입고 완료 (5건)
INSERT INTO inbound (inbound_status, inbound_at, warehouse_id, staff_id, member_id)
VALUES ('approved', '2025-11-05 10:00:00', 6, 6, 11),
       ('approved', '2025-11-06 11:00:00', 7, 7, 13),
       ('approved', '2025-11-07 14:00:00', 8, 8, 15),
       ('approved', '2025-11-08 16:00:00', 9, 9, 17),
       ('approved', '2025-11-09 09:00:00', 10, 10, 19);

-- 2025년 10월 출고 완료 (2건)
INSERT INTO outboundRequest (approvedStatus, outboundDate, member_id, warehouse_id, staff_id)
VALUES ('Approved', '2025-10-18 10:00:00', 2, 1, 2),
       ('Approved', '2025-10-20 13:00:00', 4, 2, 2);

-- 2025년 11월 출고 완료 (4건)
INSERT INTO outboundRequest (approvedStatus, outboundDate, member_id, warehouse_id, staff_id)
VALUES ('Approved', '2025-11-03 11:00:00', 6, 3, 3),
       ('Approved', '2025-11-06 14:00:00', 8, 4, 4),
       ('Approved', '2025-11-07 10:00:00', 10, 5, 5),
       ('Approved', '2025-11-09 16:00:00', 12, 6, 6);

-- 2024년 11월 데이터 (전년 대비 테스트용)
INSERT INTO Sales (warehouse_name, sales_date, category, client_name, amount, description)
VALUES ('나이키 창고(작년)', '2024-11-15', '월 이용료', 'Nike', 30000000, '2024년 11월 나이키 창고 이용료');
UPDATE Sales
SET sales_code = CONCAT('SAL-', DATE_FORMAT(sales_date, '%y%m%d'), '-', LPAD(sales_id, 5, '0'))
WHERE sales_id = LAST_INSERT_ID();
INSERT INTO Expense (warehouse_name, expense_date, category, amount, description)
VALUES ('나이키 창고(작년)', '2024-11-10', '인건비', 10000000, '2024년 11월 나이키 창고 직원 급여');
UPDATE Expense
SET expense_code = CONCAT('EXP-', DATE_FORMAT(expense_date, '%y%m%d'), '-', LPAD(expense_id, 5, '0'))
WHERE expense_id = LAST_INSERT_ID();