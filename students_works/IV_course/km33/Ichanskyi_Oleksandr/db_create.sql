create table CUSTOMERS
(
  CUST_NAME      VARCHAR2(150) not null,
  CUST_PASS      VARCHAR2(100) not null,
  CUST_NALOGCODE VARCHAR2(12) not null,
  CUST_EMAIL     VARCHAR2(150),
  CUST_PHONE     VARCHAR2(150)
);

create table ORDERS
(
  ORDER_NUM      NUMBER(10) not null,
  CUST_NALOGCODE VARCHAR2(12) not null,
  ORDER_DATE     VARCHAR2(20) 
);

create table ORDERITEMS
(
  ORDER_NUM  NUMBER(10) not null,
  CAR_ID     NUMBER(10) not null,
  QUANTITY   INTEGER not null,
  ITEM_PRICE NUMBER(17) not null
);

alter table CUSTOMERS
  add constraint PK_CUSTOMERS primary key (CUST_NALOGCODE);
  
alter table ORDERS
  add constraint PK_ORDERS primary key (ORDER_NUM);
  
alter table ORDERS
  add constraint FK_ORDERS_CUST_NALOGCODE foreign key (CUST_NALOGCODE)
  references CUSTOMERS (CUST_NALOGCODE);
  
 alter table ORDERITEMS
  add constraint FK_ORDERITEMS_ORDER_NUM foreign key (ORDER_NUM)
  references ORDERS (ORDER_NUM);



----------тригери ≥ таблиц€ дл€ нього----

CREATE TABLE History_orders
(
  order_num    int      NOT NULL,
  order_date   date     NOT NULL,
  cust_nulogcode     varchar2(12),
  history_date date     NOT NULL
);

create or replace TRIGGER "TR_ORDERS"
 AFTER DELETE ON Orders
REFERENCING OLD AS OLD
 FOR EACH ROW --строковий тр≥гер - тобто спрацюЇ ск≥льки(додасть записи в History_orders) раз≥в ск≥льки буде видалень (з таблиц≥ Orders)
BEGIN

    INSERT INTO History_orders
      (order_num,
       order_date,
       CUST_NULOGCODE,
       history_date
       )
    VALUES
      (:OLD.order_num,
       :OLD.order_date,
       :OLD.CUST_NALOGCODE,
       SYSDATE
       );
END;

-------------представленн€------------
CREATE OR REPLACE VIEW cust_for_admin 
AS
SELECT CUST_NAME as NAMES, CUST_NALOGCODE AS CODE, CUST_PHONE AS PHOHE, CUST_EMAIL AS EMAIL
FROM CUSTOMERS;

CREATE OR REPLACE VIEW order_for_admin
as
SELECT CUSTOMERS.CUST_NAME AS NAMES, ORDERS.ORDER_DATE AS ORDEEDATE, ORDERITEMS.CAR_ID AS NUMBERS,ORDERITEMS.QUANTITY AS QUANTITY 
FROM CUSTOMERS
LEFT JOIN ORDERS ON ORDERS.CUST_NALOGCODE = CUSTOMERS.CUST_NALOGCODE
LEFT JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM;
