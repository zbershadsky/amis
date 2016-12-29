insert into CUSTOMERS (CUST_NALOGCODE, CUST_PASS, CUST_NAME, CUST_EMAIL, CUST_PHONE)
values ('1234', '12345', 'Namefirst', 'first@gmail.com', '+380967812333');
insert into CUSTOMERS (CUST_NALOGCODE, CUST_PASS, CUST_NAME, CUST_EMAIL, CUST_PHONE)
values ('1235', '12345', 'Namefirst', 'first@gmail.com', '+380967812333');

------------------

insert into ORDERS (ORDER_NUM, CUST_NALOGCODE, ORDER_DATE)
values (1,'1234', '25.12.2016 10.10');
insert into ORDERS (ORDER_NUM, CUST_NALOGCODE, ORDER_DATE)
values (2, '1235', '25.12.2016 10.10');

-------------------

insert into ORDERITEMS (ORDER_NUM, CAR_ID, QUANTITY, ITEM_PRICE)
values (1, 1, 1, 800000);

insert into ORDERITEMS (ORDER_NUM, CAR_ID, QUANTITY, ITEM_PRICE)
values (2, 2, 1, 500000);
