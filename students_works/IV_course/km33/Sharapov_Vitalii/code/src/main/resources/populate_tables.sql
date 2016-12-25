INSERT INTO users(u_name, u_password, u_email, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('rand', 'at', 'dragon@reborn.net', 1, 
    NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO users(u_name, u_password, u_email, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('garreth', 'garreth', 'garreth@tanfer.kar', 0, 
    'unknown', 'garreth', '14-AUG-1988', 'tiny', 'teit', '20-APR-1990');
INSERT INTO users(u_name, u_password, u_email, u_is_manager, 
  u_groom_name, u_groom_surname, u_groom_birthday, 
  u_bride_name, u_bride_surname, u_bride_birthday) 
  VALUES ('Thelomen', 'Toblakai', 'teblor@uryd.lp', 0, 
    'Karsa', 'Orlong', '23-SEP-1936', 'Samar', ' Dev', '11-JUN-1986');
    
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('rand', 'garreth', SYSTIMESTAMP, 'your name is a bit strange');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('garreth', 'rand', SYSTIMESTAMP, 'i dont give a fuck');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('rand', 'garreth', SYSTIMESTAMP, 'you better start doing it now');
INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES ('Thelomen', 'rand', SYSTIMESTAMP, 
    'i will destroy you whatever you are');
  
INSERT INTO Ceremonies(c_number, u_name_fk, c_date, manager_fk)
  VALUES (0, 'garreth', '19-DEC-16', 'rand');
INSERT INTO Ceremonies(c_number, u_name_fk, c_date, manager_fk)
  VALUES (1, 'Thelomen', '17-DEC-16', 'rand');
  
INSERT INTO Bills(b_number, c_number_fk, b_amount, b_timestamp, b_is_paid)
  VALUES (0, 0, 1488, SYSTIMESTAMP, 0);

INSERT INTO Artists(a_contract, a_name, 
  a_email, a_genre, a_price_per_day)
  VALUES (0, 'Dandelion', 'not@a.spy', 'live music', 100);
INSERT INTO Artists(a_contract, a_name, 
  a_email, a_genre, a_price_per_day)
  VALUES (1, 'Thomdril Merrilin', 'jump_da@fuck.up', 'live music', 300);
INSERT INTO Artists(a_contract, a_name, 
  a_email, a_genre, a_price_per_day)
  VALUES (3, 'Seargent Hurtmann', 'jump_da@fuck.up', 'PT', 300);

INSERT INTO Performances(c_number_fk, a_contract_fk, p_is_confirmed)
  VALUES (0, 0, 0);
INSERT INTO Performances(c_number_fk, a_contract_fk, p_is_confirmed)
  VALUES (0, 1, 1);

INSERT INTO Restaurants(r_contract, r_name, 
  r_email, r_address, r_price_per_day)
  VALUES (0, 'Pig and Whistle', 'pig@whist.le', 
    'Old Town, Stormwind City', 2000);
INSERT INTO Restaurants(r_contract, r_name, 
  r_email, r_address, r_price_per_day)
  VALUES (1, 'Salty Sailor Tavern', 'salt@sail.or', 
    'Booty Bay, Stranglethorn Vale', 1488);

INSERT INTO Reservations(c_number_fk, r_contract_fk, r_is_confirmed)
  VALUES (0, 1, 0);
INSERT INTO Reservations(c_number_fk, r_contract_fk, r_is_confirmed)
  VALUES (1, 0, 1);

--procedures
CREATE OR REPLACE PROCEDURE REGISTERNEWUSER (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  USER_EMAIL IN VARCHAR2, 
  STATUS OUT VARCHAR2 
) AS 
  sameLoginCount INTEGER;
  sameEmailCount INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  SELECT COUNT(*) INTO sameLoginCount FROM Users WHERE u_name = USER_NAME;
  IF sameLoginCount = 0 THEN
    BEGIN
      SELECT COUNT(*) INTO sameEmailCount FROM Users WHERE u_email = USER_EMAIL;
      IF sameEmailCount = 0 THEN
        BEGIN
          INSERT INTO users(u_name, u_password, u_email, u_is_manager, 
            u_groom_name, u_groom_surname, u_groom_birthday, 
            u_bride_name, u_bride_surname, u_bride_birthday) 
          VALUES (USER_NAME, USER_PASSWORD, USER_EMAIL, 0, 
            NULL, NULL, NULL, NULL, NULL, NULL);
          COMMIT;
          STATUS := 'ok';
        END;
      ELSE
        STATUS := 'Email already in use';
      END IF;
    END;
  ELSE
    STATUS := 'Login already in use';
  END IF;
END REGISTERNEWUSER;
/

CREATE OR REPLACE PROCEDURE AUTHORIZEUSER (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  STATUS OUT VARCHAR2,
  IS_MANAGER OUT NUMBER
) AS 
  userMatchCount INTEGER;
  managerMatchCount INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT COUNT(*) INTO userMatchCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD;
  IF userMatchCount > 0 THEN
    BEGIN
      STATUS := 'ok';
      SELECT COUNT(*) INTO managerMatchCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD AND u_is_manager <> 0;
      IF managerMatchCount > 0 THEN
        IS_MANAGER := 1;
      ELSE
        IS_MANAGER := 0;
      END IF;
      status := 'ok';
      COMMIT;
    END;
  ELSE
    STATUS := 'Wrong login/password combination';
    IS_MANAGER := 0;
  END IF;
END AUTHORIZEUSER;
/

CREATE OR REPLACE PROCEDURE RESTOREPASSWORD (
  USER_NAME IN VARCHAR2,
  USER_EMAIL IN VARCHAR2,
  STATUS OUT VARCHAR2,
  USER_PASSWORD OUT VARCHAR2  
) AS
loginEmailPairCount INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT COUNT (*) INTO loginEmailPairCount FROM Users WHERE u_name = USER_NAME AND u_email = USER_EMAIL;
  IF loginEmailPairCount > 0 THEN
    BEGIN
      STATUS := 'ok';
      SELECT u_password INTO USER_PASSWORD FROM Users WHERE u_name = USER_NAME AND u_email = USER_EMAIL;
    END;
  ELSE
    STATUS := 'Failed to restore password. Wrong login/email combination';
    USER_PASSWORD := '';
  END IF;
END RESTOREPASSWORD;
/

CREATE OR REPLACE PROCEDURE UPDATEPERSONALPAGE (
  USER_NAME IN VARCHAR2,
  USER_PASSWORD IN VARCHAR2,
  GROOM_NAME IN VARCHAR2,
  GROOM_SURNAME IN VARCHAR2,
  GROOM_BIRTHDAY IN VARCHAR2,
  BRIDE_NAME IN VARCHAR2,
  BRIDE_SURNAME IN VARCHAR2,
  BRIDE_BIRTHDAY IN VARCHAR2, 
  NEW_PASSWORD IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
correctUserCount INTEGER;
sameEmailCount INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  SELECT COUNT(*) INTO correctUserCount FROM Users WHERE u_name = USER_NAME AND u_password = USER_PASSWORD;
  IF correctUserCount <> 0 THEN
    BEGIN
      if (groom_name is not null and 
        GROOM_SURNAME is not null and 
        GROOM_BIRTHDAY is not null and 
        BRIDE_NAME is not null and 
        BRIDE_SURNAME is not null and 
        BRIDE_BIRTHDAY is not null) then 
        UPDATE Users SET 
          u_groom_name = GROOM_NAME, 
          u_groom_surname = GROOM_SURNAME, 
          u_groom_birthday = to_date(GROOM_BIRTHDAY, 'yyyy-mm-dd'),
          u_bride_name = BRIDE_NAME,
          u_bride_surname = BRIDE_SURNAME,
          u_bride_birthday = to_date(BRIDE_BIRTHDAY, 'yyyy-mm-dd')
        WHERE u_name = USER_NAME;
      end if;
      IF NEW_PASSWORD IS NOT NULL THEN
        UPDATE Users SET u_password = NEW_PASSWORD WHERE u_name = USER_NAME;
      END IF;
      
      STATUS := 'ok';

      COMMIT;
    END;
  ELSE
    STATUS := 'Failed to apply changes. Incorrect current password';
  END IF;
END UPDATEPERSONALPAGE;
/

create or replace 
PROCEDURE SENDMESSAGE (
  FROM_USER IN VARCHAR2,
  TO_USER IN VARCHAR2,
  MESSAGE_CONTENT IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  INSERT INTO Messages(m_from_fk, m_to_fk, m_timestamp, m_content)
  VALUES (FROM_USER, TO_USER, SYSTIMESTAMP, MESSAGE_CONTENT);
  STATUS := 'ok';
  COMMIT;
END SENDMESSAGE;
/

create or replace 
PROCEDURE CHANGERESTAURANT (
  USER_NAME IN VARCHAR2, 
  REST_NUMBER IN INTEGER,
  STATUS OUT VARCHAR2
) AS 
restaurantExists INTEGER;
restaurantsReserved INTEGER;
ceremonyNumber INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  SELECT COUNT(*) INTO restaurantExists FROM Restaurants WHERE r_contract = REST_NUMBER;
  
  IF restaurantExists > 0 THEN 
    BEGIN
      SELECT COUNT(*) INTO restaurantsReserved
      FROM Users
        INNER JOIN Ceremonies ON u_name_fk = u_name
        INNER JOIN Reservations ON c_number = c_number_fk
        INNER JOIN Restaurants ON r_contract_fk = r_contract
      WHERE u_name = USER_NAME;
    
      SELECT c_number INTO ceremonyNumber
      FROM Users
        INNER JOIN Ceremonies ON u_name_fk = u_name
      WHERE u_name = USER_NAME;
  
      IF restaurantsReserved > 0 THEN
        UPDATE Reservations SET r_contract_fk = REST_NUMBER, r_is_confirmed = 0 WHERE c_number_fk = ceremonyNumber;
      ELSE
        INSERT INTO Reservations(c_number_fk, r_contract_fk, r_is_confirmed)
        VALUES (ceremonyNumber, REST_NUMBER, 0);
      END IF;
      STATUS := 'ok';
      COMMIT;
    END;
  ELSE  
    STATUS := 'Specified restaurant was not found';
  END IF;
  
END CHANGERESTAURANT;
/

create or replace 
PROCEDURE CHANGEARTIST (
  USER_NAME IN VARCHAR2, 
  ARTIST_NUMBER IN INTEGER,
  STATUS OUT VARCHAR2
) AS 
artistExists INTEGER;
performancesCount INTEGER;
ceremonyNumber INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  SELECT COUNT(*) INTO artistExists FROM Artists WHERE a_contract = ARTIST_NUMBER;
  
  IF artistExists > 0 THEN 
    BEGIN
      SELECT COUNT(*) INTO performancesCount
      FROM Users
        INNER JOIN Ceremonies ON u_name_fk = u_name
        INNER JOIN Performances ON c_number = c_number_fk
        INNER JOIN Artists ON a_contract_fk = a_contract
      WHERE u_name = USER_NAME AND a_contract = ARTIST_NUMBER;
    
      SELECT c_number INTO ceremonyNumber
      FROM Users
        INNER JOIN Ceremonies ON u_name_fk = u_name
      WHERE u_name = USER_NAME;
  
      IF performancesCount = 0 THEN
        INSERT INTO Performances(c_number_fk, a_contract_fk, p_is_confirmed)
        VALUES (ceremonyNumber, ARTIST_NUMBER, 0);
      END IF;
      STATUS := 'ok';
      COMMIT;
    END;
  ELSE  
    STATUS := 'Specified artist was not found';
  END IF;
  
END CHANGEARTIST;
/

CREATE OR REPLACE PROCEDURE CHANGEROLE (
  USER_NAME IN VARCHAR2, 
  MANAGER_NAME IN VARCHAR2, 
  STATUS OUT VARCHAR2
) AS 
managerExists INTEGER;
userExists INTEGER;
userIsManager INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into managerExists from users where u_name = manager_name and u_is_manager <> 0;
  
  if managerExists > 0 then
    begin
      select count(*) into userExists from users where u_name = user_name;
      if userExists > 0 then
        begin
          select u_is_manager into userIsManager from users where u_name = user_name;
        
          if userIsManager <> 0 then
            update users set u_is_manager = 0 where u_name = user_name;
          else
            update users set u_is_manager = 1 where u_name = user_name;
          end if;
          status := 'ok';
          commit;
        end;
      else
        status := 'no such user';
      end if;
    end;
  else
    status := 'manager privelegies not confirmed';
  end if;
END CHANGEROLE;
/

CREATE OR REPLACE PROCEDURE CHANGECEREMONYDATE (
  USER_NAME IN VARCHAR2,
  NEW_DATE IN DATE,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
ceremonyExists integer;
maxCeremonyNumber integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into userExists from users where u_name = user_name;
  
  if userExists > 0 then
    begin
      select count(*) into ceremonyExists from ceremonies where u_name_fk = user_name;
      
      if ceremonyExists > 0 then
        if new_date > sysdate then
          update ceremonies set c_date = new_date where u_name_fk = user_name;
          status := 'ok';
        else
          status := 'new date is in the past';
        end if;
      else
        begin
          select max(c_number) into maxCeremonyNumber from ceremonies;
          maxCeremonyNumber := maxCeremonyNumber + 1;
          
          INSERT INTO Ceremonies(c_number, u_name_fk, c_date, manager_fk)
          VALUES (maxCeremonyNumber, user_name, new_date, null);
          status := 'ok';
        end;
      end if;
      commit;
    end;
  else
    status := 'user not found';
  end if;
END CHANGECEREMONYDATE;
/

create or replace 
PROCEDURE MANAGECEREMONY (
  USER_NAME IN VARCHAR2,
  MANAGER_NAME IN VARCHAR2, 
  STATUS OUT VARCHAR2  
) AS 
isManager INTEGER;
isUser INTEGER;
isUserOccupied INTEGER;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into isUser from users where u_name = user_name and u_is_manager = 0;
  select count(*) into isManager from users where u_name = manager_name and u_is_manager <> 0;
  
  if isUser > 0 and isManager > 0 then
    begin
      select count(*) into isUserOccupied from ceremonies where u_name_fk = user_name and manager_fk is not null;
      
      if isUserOccupied = 0 then
        begin
          update ceremonies set manager_fk = manager_name where u_name_fk = user_name;
          status := 'ok1';
        end;
      else
        begin
          update ceremonies set manager_fk = null where u_name_fk = user_name;
          status := 'ok2';
        end;
      end if;
      commit;
    end;
  else
    status := 'user or manager is invalid';
  end if;
END MANAGECEREMONY;
/

CREATE OR REPLACE PROCEDURE MANAGERESTAURANT (
  USER_NAME IN VARCHAR2,
  MANAGER_NAME IN VARCHAR2,
  REST_NUMBER IN NUMBER,
  do_confirm in number,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
managerExists integer;
restaurantExists integer;
isManagerAssignedToUser integer;
userCeremonyDate date;
reservationsCount integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into userExists from users where u_name = user_name and u_is_manager = 0;
  select count(*) into managerExists from users where u_name = manager_name and u_is_manager <> 0;
  select count(*) into restaurantExists from restaurants where r_contract = rest_number;
  select count(*) into isManagerAssignedToUser from ceremonies where u_name_fk = user_name and manager_fk = MANAGER_NAME;
  
  if userExists > 0 then 
    if managerExists > 0 then
      if restaurantExists > 0 then
        if isManagerAssignedToUser > 0 then
          begin
            select count(*) into reservationsCount 
            from ceremonies inner join reservations on c_number = c_number_fk 
            where 
              r_contract_fk = rest_number 
              and c_date in (select c_date from ceremonies where u_name_fk = user_name);
          
            if reservationsCount = 1 then
              begin
                update reservations set r_is_confirmed = do_confirm where c_number_fk in (select c_number from ceremonies where u_name_fk = user_name) and r_contract_fk = rest_number;
                status := 'ok';
              end;
            else 
              status := 'restaurant is busy that day';
            end if;
          end;
        else
          status := 'manager is not assigned to user';
        end if;
      else
        status := 'restaurant not found';
      end if;
    else
      status := 'manager not found';
    end if;
  else
    status := 'user not found';
  end if;
END MANAGERESTAURANT;
/

create or replace 
PROCEDURE MANAGEARTIST (
  USER_NAME IN VARCHAR2,
  MANAGER_NAME IN VARCHAR2,
  ARtist_NUMBER IN NUMBER,
  do_confirm in number,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
managerExists integer;
artistExists integer;
isManagerAssignedToUser integer;
performancesCount integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into userExists from users where u_name = user_name and u_is_manager = 0;
  select count(*) into managerExists from users where u_name = manager_name and u_is_manager <> 0;
  select count(*) into artistExists from artists where a_contract = artist_number;
  select count(*) into isManagerAssignedToUser from ceremonies where u_name_fk = user_name and manager_fk = MANAGER_NAME;
  
  if userExists > 0 then 
    if managerExists > 0 then
      if artistExists > 0 then
        if isManagerAssignedToUser > 0 then
          begin
            select count(*) into performancesCount 
            from ceremonies inner join performances on c_number = c_number_fk 
            where 
              a_contract_fk = artist_number 
              and c_date in (select c_date from ceremonies where u_name_fk = user_name);
          
            if performancesCount = 1 then
              begin
                update performances set p_is_confirmed = do_confirm where c_number_fk in (select c_number from ceremonies where u_name_fk = user_name) and a_contract_fk = artist_number;
                status := 'ok';
              end;
            else 
              status := 'artist is busy that day';
            end if;
          end;
        else
          status := 'manager is not assigned to user';
        end if;
      else
        status := 'artist not found';
      end if;
    else
      status := 'manager not found';
    end if;
  else
    status := 'user not found';
  end if;
END MANAGEARTIST;
/

create or replace 
PROCEDURE UPDATEARTIST (
  MANAGER_NAME IN VARCHAR2,
  ARTIST_NAME IN VARCHAR2,
  ARTIST_EMAIL IN VARCHAR2,
  ARTIST_GENRE IN VARCHAR2,
  ARTIST_PRICE_PER_day IN NUMBER,
  STATUS OUT VARCHAR2  
) AS 
isManager integer;
artistExists integer;
newContract integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into isManager from users where u_name = manager_name and u_is_manager <> 0;
  
  if isManager <> 0 then
    begin
      select count(*) into artistExists from artists where a_name = ARTIST_NAME;
      
      if artistExists <> 0 then
        begin 
          select a_contract into newContract from artists where a_name = artist_name;
            update artists set a_email = artist_email, a_genre = artist_genre, a_price_per_day = ARTIST_PRICE_PER_day where a_contract = newContract;
        end;
      else
        select max(a_contract) into newContract from artists;
        newContract := newContract + 1;
        insert into artists(a_contract, a_name, a_email, a_genre, a_price_per_day) 
        values(newContract, ARTIST_NAME, ARTIST_EMAIL, ARTIST_GENRE, ARTIST_PRICE_PER_day);
      end if;
      status := 'ok';
      commit;
    end;
  else
    status :='not a manager';
  end if;
  
END UPDATEARTIST;
/

create or replace 
PROCEDURE UPDATErestaurants (
  MANAGER_NAME IN VARCHAR2,
  rest_NAME IN VARCHAR2,
  rest_EMAIL IN VARCHAR2,
  rest_address IN VARCHAR2,
  rest_PRICE_PER_day IN NUMBER,
  STATUS OUT VARCHAR2  
) AS 
isManager integer;
restExists integer;
newContract integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count(*) into isManager from users where u_name = manager_name and u_is_manager <> 0;
  
  if isManager > 0 then
    begin
      select count(*) into restExists from restaurants where r_name = rest_NAME;
      
      if restExists <> 0 then
        begin 
          select r_contract into newContract from restaurants where r_name = rest_name;
            update restaurants set r_email = rest_email, r_address = rest_address, r_price_per_day = reST_PRICE_PER_day where r_contract = newContract;
        end;
      else
        select max(r_contract) into newContract from restaurants;
        newContract := newContract + 1;
        insert into restaurants(r_contract, r_name, r_email, r_address, r_price_per_day) 
        values(newContract, rest_NAME, rest_EMAIL, rest_address, rest_PRICE_PER_day);
      end if;
      status := 'ok';
      commit;
    end;
  else
    status :='not a manager';
  end if;
  
END UPDATErestaurants;
/

create or replace 
PROCEDURE UPDATEBILL (
  USER_NAME IN VARCHAR2, 
  MANAGER_NAME IN VARCHAR2,
  DO_CONFIRM IN NUMBER,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
managerExists integer;
ceremonyNumber integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count (*) into userExists from users where u_name = user_name and u_is_manager = 0;
  select count (*) into managerExists from users where u_name = manager_name and u_is_manager <> 0;
  
  if userExists > 0 then
    if managerExists > 0 then
      begin
        select c_number into ceremonyNumber from ceremonies where u_name_fk = user_name;
        update bills set b_is_paid = do_confirm where c_number_fk = ceremonyNumber;
        status := 'ok';
        commit;
      end;
    else
      status := 'manager not found';
    end if;
  else
    status := 'user not found';
  end if;
END UPDATEBILL;
/

create view personalInfo as(
  select 
    u_name, u_email, u_is_manager,
    u_groom_name, u_groom_surname, u_groom_birthday, 
    u_bride_name, u_bride_surname, u_bride_birthday
  from
    users
);
/

CREATE OR REPLACE PROCEDURE INSERTBILL (
  user_name IN VARCHAR2, 
  amount IN number, 
  status OUT VARCHAR2  
) AS 
userExists number;
billNumber number;
ceremonyNumber number;
BEGIN
  set transaction isolation level serializable;
  select count(*) into userExists from users where u_name = user_name;
  if userExists > 0 then
    if amount > 0 then
      begin
        select max(b_number) into billNumber from bills;
        billNumber := billNumber + 1;
        select c_number into ceremonyNumber from ceremonies where u_name_fk = user_name;
        
        insert into Bills(b_number, c_number_fk, b_amount, b_timestamp, b_is_paid)
        values (billNumber, ceremonyNumber, amount, systimestamp, 0);
        status := 'ok';
      commit;
      end;
    else
      status := 'negative amount';
    end if;
  else 
    status := 'user not found';
  end if;
END INSERTBILL;
/

CREATE OR REPLACE PROCEDURE ASSIGNTOUSER (
  USER_NAME IN VARCHAR2, 
  MANAGER_NAME IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
managerExists integer;
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  select count (*) into userExists from users where u_name = user_name and u_is_manager = 0;
  select count (*) into managerExists from users where u_name = manager_name and u_is_manager <> 0;
  
  if userExists > 0 then
    if managerExists > 0 then
      begin
        update ceremonies set manager_fk = manager_name where u_name_fk = user_name;
        status := 'ok';
        commit;
      end;
    else
      status := 'manager not found';
    end if;
  else
    status := 'user not found';
  end if;
END ASSIGNTOUSER;
/

create view ceremonyrestaurant as(
  select 
    u_name,
    u_groom_name, u_groom_surname, u_groom_birthday,
    u_bride_name, u_bride_surname, u_bride_birthday,
    c_date,
    r_name, r_address, r_is_confirmed
  from
    users inner join ceremonies on u_name = u_name_fk
    inner join reservations on c_number = c_number_fk
    inner join restaurants on r_contract = r_contract_fk
);
  
create view ceremonyartists as(
  select 
    u_name,
    u_groom_name, u_groom_surname, u_groom_birthday,
    u_bride_name, u_bride_surname, u_bride_birthday,
    c_date,
    a_name, a_genre, p_is_confirmed
  from
    users inner join ceremonies on u_name = u_name_fk
    inner join performances on c_number = c_number_fk
    inner join artists on a_contract = a_contract_fk
);
/

create view paymentBills as (
  select 
    u_name_fk, b_amount, b_timestamp, b_is_paid
  from 
    ceremonies inner join bills on c_number = c_number_fk
);
/

create view userStatus as (
  select 
    u_name, u_email, u_is_manager
  from 
    users
);
/

create view managerAssignments as (
  select
    u_name, manager_fk
  from 
    users right outer join ceremonies on u_name = u_name_fk
);
/

create view ceremonyDates as (
  select
    u_name, c_date
  from 
    users inner join ceremonies on u_name = u_name_fk
);

create or replace view viewrestaurants as (
  select
    r_contract, r_name, r_address, r_price_per_day
  from 
    restaurants
);
/

create or replace view viewartists as (
  select
    a_contract, a_name, a_genre, a_price_per_day
  from 
    artists
);
/

create view messageHistory as 
select m_from_fk m_from, m_to_fk m_to, m_content, m_timestamp 
from Messages
order by m_timestamp desc;
/
