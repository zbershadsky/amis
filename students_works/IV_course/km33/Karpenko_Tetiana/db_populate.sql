 INSERT INTO Users (user_email,user_password,user_name, user_surname)
VALUES ('first@gmail.com','1a1dc91c907325c69271ddf0c944bc72','Kate','Smith');

 INSERT INTO Users (user_email,user_password,user_name, user_surname)
VALUES ('tania@gmail.com','962012d09b8170d912f0669f6d7d9d07','Tania','Karpenko');


/*services*/

insert into service (service_name,service_cost)
VALUES ('water','10');

insert into service (service_name,service_cost)
VALUES ('gas','12');

insert into service (service_name,service_cost)
VALUES ('electric power','20');

insert into service (service_name,service_cost)
VALUES ('cleaning','5');

insert into service (service_name,service_cost)
VALUES ('lift','2');


/*cartitems*/

insert into Cartitem (user_email_fk,service_name_fk,addres,email_to_send,pay_name,pay_surname)
values ('tania@gmail.com','water','wallstreet 56/4','tania@gmail.com','Tania','Karpenko');

insert into Cartitem (user_email_fk,service_name_fk,addres,email_to_send,pay_name,pay_surname)
values ('first@gmail.com','lift','wallstreet 2/4','qwrt_send@gmail.com','Alex','Swimmer');

insert into Cartitem (user_email_fk,service_name_fk,addres,email_to_send,pay_name,pay_surname)
values ('first@gmail.com','water','wallstreet 3/4','qwrt_send@gmail.com','Inna','Swimmer');