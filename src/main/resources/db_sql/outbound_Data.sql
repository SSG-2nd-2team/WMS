
create table category
(
    category_cd   int auto_increment
        primary key,
    category_name varchar(200) not null
);


create table driver
(
    driver_id   int auto_increment
        primary key,
    driver_name varchar(30)                           not null,
    car_id      int                                   not null,
    car_number  varchar(20)                           null,
    car_type    varchar(20)                           null,
    status      enum ('대기', '운행중', '휴무') default '대기' null
);

create table outboundRequest
(
    outboundRequest_ID    int auto_increment
        primary key,
    outboundDate          timestamp    null,
    approvedStatus        varchar(100) null,
    outboundAddress       varchar(100) null,
    member_id             bigint       not null,
    warehouse_id          int          null,
    staff_id              bigint       null,
    requestedDeliveryDate timestamp    null,
    constraint FK_Member_TO_outboundRequest_1
        foreign key (member_id) references Member (member_id),
    constraint FK_Staff_TO_outboundRequest_1
        foreign key (staff_id) references Staff (staff_id),
    constraint FK_WAREHOUSE_TO_outboundRequest_1
        foreign key (warehouse_id) references WAREHOUSE (warehouse_id)
);

create table outboundItem
(
    outbound_item_id   int auto_increment
        primary key,
    outboundRequest_ID int         not null,
    Product_ID         varchar(20) not null,
    outboundQuantity   int         not null,
    constraint FK_Product_TO_outboundItem_1
        foreign key (Product_ID) references Product (product_id),
    constraint FK_outboundRequest_TO_outboundItem_1
        foreign key (outboundRequest_ID) references outboundRequest (outboundRequest_ID)
);

create table outboundOrder
(
    approvedOrder_ID   int auto_increment
        primary key,
    outboundRequest_ID int         not null,
    approvedDate       timestamp   null,
    instructionNo      varchar(10) null,
    orderStatus        varchar(20) null,
    constraint FK_outboundRequest_TO_outboundOrder_1
        foreign key (outboundRequest_ID) references outboundRequest (outboundRequest_ID)
);

create table dispatch
(
    dispatch_ID      int auto_increment
        primary key,
    approvedOrder_ID int         not null,
    carID            int         null,
    Cartype          varchar(20) null,
    driverName       varchar(10) null,
    assignedDate     timestamp   null,
    dispatchStatus   varchar(10) null,
    loadedBOX        int         null,
    maximumBOX       int         null,
    driver_id        int         null,
    constraint FK_outboundOrder_TO_dispatch_1
        foreign key (approvedOrder_ID) references outboundOrder (approvedOrder_ID),
    constraint fk_dispatch_driver
        foreign key (driver_id) references driver (driver_id)
);

create table waybill
(
    waybill_id        int auto_increment
        primary key,
    waybill_number    varchar(50)  null,
    waybill_date      timestamp    null,
    waybill_status    varchar(20)  null,
    dispatch_ID       int          not null,
    departure_Address varchar(100) null,
    arrival_Address   varchar(100) null,
    sender_Name       varchar(10)  null,
    receiver_Name     varchar(10)  null,
    constraint FK_dispatch_TO_waybill_1
        foreign key (dispatch_ID) references dispatch (dispatch_ID)
);

create table QR
(
    QR_id      int auto_increment
        primary key,
    created_at timestamp null,
    waybill_id int       not null,
    constraint FK_waybill_TO_QR_1
        foreign key (waybill_id) references waybill (waybill_id)
);



ALTER TABLE dispatch
    ADD COLUMN driver_id INT,
    ADD CONSTRAINT fk_dispatch_driver
        FOREIGN KEY (driver_id)
            REFERENCES driver(driver_id);