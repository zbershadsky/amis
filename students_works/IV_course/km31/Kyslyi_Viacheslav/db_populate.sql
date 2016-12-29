
Insert into RESTAURANTS (ID, "Name", "Description", "Address") 
	values (1, 'Happy Grill Bar', 'Маленька мережа барів у києві.', 'Поділ, Київ'); --1
Insert into RESTAURANTS (ID, "Name", "Description", "Address") 
	values (2, 'Пузата хата', 'Маленька мережа барів у києві.', 'Поділ, Київ'); --2
Insert into RESTAURANTS (ID, "Name", "Description", "Address") 
	values (3, 'Цимес', 'Маленька мережа барів у києві.', 'Поділ, Київ'); --3
Insert into RESTAURANTS (ID, "Name", "Description", "Address") 
	values (4, 'Жуль верн', 'Маленька мережа барів у києві.', 'Поділ, Київ'); --4
Insert into RESTAURANTS (ID, "Name", "Description", "Address") 
	values (5, 'Salateira', 'Маленька мережа барів у києві.', 'Поділ, Київ'); --5

Insert into MENUS (ID, REST_ID, "Name", "Description") 
	values (1, 1, 'Основне', 'Основне меню ресторану');

Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (1, 'Борщ', 'Традиційна українська страва', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (1, 'Чізбургер', 'Бургер з сиром', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (1, 'Картопля', 'Традиційний гарнір', 25);	


Insert into MENUS (ID, REST_ID, "Name", "Description") 
	values (2, 2, 'Основне', 'Основне меню ресторану');

Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (2, 'Борщ', 'Традиційна українська страва', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (2, 'Чізбургер', 'Бургер з сиром', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (2, 'Картопля', 'Традиційний гарнір', 25);


Insert into MENUS (ID, REST_ID, "Name", "Description") 
	values (3, 3, 'Основне', 'Основне меню ресторану');

Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (3, 'Борщ', 'Традиційна українська страва', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (3, 'Чізбургер', 'Бургер з сиром', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (3, 'Картопля', 'Традиційний гарнір', 25);

Insert into MENUS (ID, REST_ID, "Name", "Description") 
	values (4, 4, 'Основне', 'Основне меню ресторану');

Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (4, 'Борщ', 'Традиційна українська страва', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (4, 'Чізбургер', 'Бургер з сиром', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (4, 'Картопля', 'Традиційний гарнір', 25);

Insert into MENUS (ID, REST_ID, "Name", "Description") 
	values (5, 5, 'Основне', 'Основне меню ресторану');

Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (5, 'Борщ', 'Традиційна українська страва', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (5, 'Чізбургер', 'Бургер з сиром', 25);
Insert into MEALS (MENU_ID, "Name", "Description", "Price") 
	values (5, 'Картопля', 'Традиційний гарнір', 25);

---------------------------------------------------------------------
--Procedures-
---------------------------------------------------------------------

create or replace 
procedure addQuery(query_value IN varchar2, user_id IN integer, query_id OUT integer)
AS
  begin
      
    insert into search_query("USER_ID", "Query", "Date")
      VALUES (user_id, query_value, CURRENT_DATE);
    
    select max(search_query.ID) into query_id from search_query; 
    commit;    
      
    exception 
      WHEN OTHERS THEN
      rollback;
  end;


 create or replace 
procedure addToMealQueryLink(query_id IN integer, meal_id IN integer)
AS
  begin
      
    insert into meal_result("QUERY_ID", "MEAL_ID")
      VALUES (query_id, meal_id); 
    commit;    
      
    exception 
      WHEN OTHERS THEN
      rollback;
  end;


  create or replace 
procedure addToRestQueryLink(query_id IN integer, res_id IN integer)
AS
  begin
      
    insert into restaurant_result("QUERY_ID", "RES_ID")
      VALUES (query_id, res_id); 
    commit;    
      
    exception 
      WHEN OTHERS THEN
      rollback;
  end;


  create or replace 
procedure addUser(login       IN varchar2, 
                  pass        IN varchar2,
                  first_name  IN varchar2,
                  last_name   IN varchar2,
                  email       IN varchar2,
                  status      OUT integer)
AS
  login_check varchar2(256);
  begin
  
    status := 1;
    
    begin

    select "Login" into login_check from users where "Login" = login;

    EXCEPTION WHEN NO_DATA_FOUND then
      status := 1;
    end;
    
    if login_check is not null then
      begin 
      
        status := 2;
        
      end;
    else 
      begin 
      
        insert into users("Login", "Pass", "First_Name", "Last_Name", "Email")
          VALUES (login, pass, first_name, last_name, email);
        commit;
        
      end;
    end if;
      
    exception 
      WHEN OTHERS THEN
      status := 0;
      rollback;
  end;


  ----------
  ---Views 
  -----

  CREATE OR REPLACE FORCE VIEW RESTAURANT_MEAL 
AS 
  SELECT 
    r.ID as rest_id, r."Name", r."Description", r."Address", m.ID as meal_id from restaurants r 
      inner join menus on menus.rest_id = r.ID
      inner join meals m on menus.ID = m.menu_id;


CREATE OR REPLACE FORCE VIEW MEALVIEW ("ID", "MENU_ID", "Name", "Description", "Price") AS 
  select "ID","MENU_ID","Name","Description","Price" from meals;