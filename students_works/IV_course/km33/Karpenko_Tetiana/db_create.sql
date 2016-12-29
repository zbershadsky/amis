CREATE TABLE Users 
(
user_email varchar2(254) NOT NULL Primary key,
user_password varchar2(32) NOT NULL,
user_name varchar2(64) NOT NULL,
user_surname varchar2(64) NOT NULL
);

CREATE VIEW USER_VIEW AS 
SELECT u.user_email, u.user_password,u.user_name,u.user_surname
FROM USERs u;


CREATE TABLE Cart (
user_email_fk varchar2(254) PRIMARY KEY references Users(user_email) ON DELETE CASCADE,
price number (10)
);


CREATE VIEW CART_VIEW AS 
SELECT c.user_email_fk, c.price
FROM Cart c;


CREATE TABLE Service (
service_name varchar2(20) Primary key,
service_cost number (5)
);


CREATE TABLE Cartitem (
item_num number primary key,
user_email_fk varchar2(254) references Users(user_email) ON DELETE CASCADE ,
service_name_fk varchar2(20) references Service(service_name) ON DELETE CASCADE,
addres varchar2(150) , 
email_to_send varchar2(254),
pay_name varchar2(64),
pay_surname varchar2(64)
);

CREATE VIEW Cartitem_view AS
SELECT c.item_num+13 v_id ,c.user_email_fk ,c.service_name_fk ,c.addres , c.email_to_send ,c.pay_name,c.pay_surname 
FROM Cartitem c;

/*to make id for item*/
create sequence item_num_seq;


create or replace trigger trg_item_id
      before insert on cartitem
      for each row
    begin
      select item_num_seq.nextval
        into :new.item_num
        from dual;
    end;
/
/*make view with function of ID*/



/*final trigger*/

CREATE OR REPLACE TRIGGER trg_cart_create
    after INSERT ON cartitem
    FOR EACH ROW
    DECLARE 
    counter integer(2);
    price number(10);
    new_price number(10);
    BEGIN
    
    /*check is there user in cart*/
    select COUNT(*) INTO counter
    FROM Cart
    WHERE user_email_fk = :new.user_email_fk;
    /*find cost of new cartitem*/
    /*if not - add*/
    IF counter = 0 THEN
        INSERT INTO Cart (user_email_fk,price)
        VALUES (:new.user_email_fk,price);
    END IF;
    /*s user alredy in cart*/
   
    END;