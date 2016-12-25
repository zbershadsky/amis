--Create tables
CREATE TABLE USERS (
  u_name VARCHAR2(40) NOT NULL,
  u_password VARCHAR2(40) NOT NULL,
  u_email VARCHAR2(40) NOT NULL,
  u_is_manager NUMBER NOT NULL,
  u_groom_name VARCHAR2(40),
  u_groom_surname VARCHAR2(40),
  u_groom_birthday DATE,
  u_bride_name VARCHAR2(40),
  u_bride_surname VARCHAR2(40),
  u_bride_birthday DATE 
);

CREATE TABLE Messages (
  m_from_fk VARCHAR2(40) NOT NULL,
  m_to_fk VARCHAR2(40) NOT NULL,
  m_timestamp TIMESTAMP NOT NULL,
  m_content VARCHAR(256) NOT NULL
);

CREATE TABLE Ceremonies (
  c_number INTEGER NOT NULL,
  u_name_fk VARCHAR2(40) NOT NULL,
  c_date DATE NOT NULL,
  manager_fk VARCHAR2(40)
);

CREATE TABLE Bills (
  b_number INTEGER NOT NULL,
  c_number_fk INTEGER NOT NULL,
  b_amount DECIMAL NOT NULL,
  b_timestamp TIMESTAMP NOT NULL,
  b_is_paid NUMBER NOT NULL
);

CREATE TABLE Artists (
  a_contract INTEGER NOT NULL,
  a_name VARCHAR2(40) NOT NULL,
  a_email VARCHAR2(40) NOT NULL,
  a_genre VARCHAR2(40) NOT NULL,
  a_price_per_day DECIMAL NOT NULL
);

CREATE TABLE Performances (
  c_number_fk INTEGER NOT NULL,
  a_contract_fk INTEGER NOT NULL,
  p_is_confirmed NUMBER NOT NULL
);

CREATE TABLE Restaurants (
  r_contract INTEGER NOT NULL,
  r_name VARCHAR2(40) NOT NULL,
  r_email VARCHAR2(40) NOT NULL,
  r_address VARCHAR2(256) NOT NULL,
  r_price_per_day DECIMAL NOT NULL
);

CREATE TABLE Reservations (
  c_number_fk INTEGER NOT NULL,
  r_contract_fk INTEGER NOT NULL,
  r_is_confirmed NUMBER NOT NULL
);

--Create tables for history log
CREATE TABLE HistoryUsers AS (SELECT * FROM Users);
ALTER TABLE HistoryUsers ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryUsers ADD (change_type VARCHAR2(6));

CREATE TABLE HistoryCeremonies AS (SELECT * FROM Ceremonies);
ALTER TABLE HistoryCeremonies ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryCeremonies ADD (change_type VARCHAR2(6));

CREATE TABLE HistoryArtists AS (SELECT * FROM Artists);
ALTER TABLE HistoryArtists ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryArtists ADD (change_type VARCHAR2(6));

CREATE TABLE HistoryPerformances AS (SELECT * FROM Performances);
ALTER TABLE HistoryPerformances ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryPerformances ADD (change_type VARCHAR2(6));

CREATE TABLE HistoryRestaurants AS (SELECT * FROM Restaurants);
ALTER TABLE HistoryRestaurants ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryRestaurants ADD (change_type VARCHAR2(6));

CREATE TABLE HistoryReservations AS (SELECT * FROM Reservations);
ALTER TABLE HistoryReservations ADD (change_timestamp TIMESTAMP);
ALTER TABLE HistoryReservations ADD (change_type VARCHAR2(6));

--alter tables
ALTER TABLE Users 
  ADD CONSTRAINT Users_PK PRIMARY KEY (u_name); 
ALTER TABLE Users 
  ADD CONSTRAINT Users_UNIQUE UNIQUE (u_email); 

ALTER TABLE Messages 
  ADD CONSTRAINT Messages_PK PRIMARY KEY (m_from_fk, m_to_fk, m_timestamp); 
ALTER TABLE Messages 
  ADD CONSTRAINT Messages_FK_1 FOREIGN KEY (m_from_fk) REFERENCES Users(u_name);
ALTER TABLE Messages 
  ADD CONSTRAINT Messages_FK_2 FOREIGN KEY (m_to_fk) REFERENCES Users(u_name);

ALTER TABLE Ceremonies 
  ADD CONSTRAINT Ceremonies_PK PRIMARY KEY (c_number); 
ALTER TABLE Ceremonies 
  ADD CONSTRAINT Ceremonies_FK_1 FOREIGN KEY (u_name_fk) REFERENCES Users(u_name);
ALTER TABLE Ceremonies 
  ADD CONSTRAINT Ceremonies_FK_2 FOREIGN KEY (manager_fk) REFERENCES Users(u_name);

ALTER TABLE Bills 
  ADD CONSTRAINT Bills_PK PRIMARY KEY (b_number); 
ALTER TABLE Bills 
  ADD CONSTRAINT Bills_FK FOREIGN KEY (c_number_fk) REFERENCES Ceremonies(c_number);

ALTER TABLE Artists 
  ADD CONSTRAINT Artists_PK PRIMARY KEY (a_contract); 

ALTER TABLE Performances 
  ADD CONSTRAINT Performances_PK PRIMARY KEY (c_number_fk, a_contract_fk); 
ALTER TABLE Performances 
  ADD CONSTRAINT Performances_FK_1 FOREIGN KEY (c_number_fk) REFERENCES Ceremonies(c_number);
ALTER TABLE Performances 
  ADD CONSTRAINT Performances_FK_2 FOREIGN KEY (a_contract_fk) REFERENCES Artists(a_contract);

ALTER TABLE Restaurants 
  ADD CONSTRAINT Restaurants_PK PRIMARY KEY (r_contract); 

ALTER TABLE Reservations 
  ADD CONSTRAINT Reservations_PK PRIMARY KEY (c_number_fk, r_contract_fk); 
ALTER TABLE Reservations 
  ADD CONSTRAINT Reservations_FK_1 FOREIGN KEY (c_number_fk) REFERENCES Ceremonies(c_number);
ALTER TABLE Reservations 
  ADD CONSTRAINT Reservations_FK_2 FOREIGN KEY (r_contract_fk) REFERENCES Restaurants(r_contract);
  
--alter history tables  
ALTER TABLE HistoryUsers 
  ADD CONSTRAINT HistoryUsers_PK PRIMARY KEY (u_name, change_timestamp); 
  
ALTER TABLE HistoryCeremonies 
  ADD CONSTRAINT HistoryCeremonies_PK PRIMARY KEY (c_number, change_timestamp);
  
ALTER TABLE HistoryArtists 
  ADD CONSTRAINT HistoryArtists_PK PRIMARY KEY (a_contract, change_timestamp); 

ALTER TABLE HistoryPerformances 
  ADD CONSTRAINT HistoryPerformances_PK PRIMARY KEY (c_number_fk, a_contract_fk, change_timestamp);

ALTER TABLE HistoryRestaurants 
  ADD CONSTRAINT HistoryRestaurants_PK PRIMARY KEY (r_contract, change_timestamp); 

ALTER TABLE HistoryReservations 
  ADD CONSTRAINT HistoryReservations_PK PRIMARY KEY (c_number_fk, r_contract_fk, change_timestamp); 
  
--create triggers for history tables
CREATE OR REPLACE TRIGGER USERSCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Users 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
      INSERT INTO HistoryUsers(u_name, u_password, u_email, u_is_manager, 
        u_groom_name, u_groom_surname, u_groom_birthday, 
        u_bride_name, u_bride_surname, u_bride_birthday, change_timestamp, change_type) 
        VALUES (:NEW.u_name, :NEW.u_password, :NEW.u_email, :NEW.u_is_manager, 
        :NEW.u_groom_name, :NEW.u_groom_surname, :NEW.u_groom_birthday, 
        :NEW.u_bride_name, :NEW.u_bride_surname, :NEW.u_bride_birthday, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
      INSERT INTO HistoryUsers(u_name, u_password, u_email, u_is_manager, 
        u_groom_name, u_groom_surname, u_groom_birthday, 
        u_bride_name, u_bride_surname, u_bride_birthday, change_timestamp, change_type) 
        VALUES (:OLD.u_name, :OLD.u_password, :OLD.u_email, :OLD.u_is_manager, 
        :OLD.u_groom_name, :OLD.u_groom_surname, :OLD.u_groom_birthday, 
        :OLD.u_bride_name, :OLD.u_bride_surname, :OLD.u_bride_birthday, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
      INSERT INTO HistoryUsers(u_name, u_password, u_email, u_is_manager, 
        u_groom_name, u_groom_surname, u_groom_birthday, 
        u_bride_name, u_bride_surname, u_bride_birthday, change_timestamp, change_type) 
        VALUES (:OLD.u_name, :OLD.u_password, :OLD.u_email, :OLD.u_is_manager, 
        :OLD.u_groom_name, :OLD.u_groom_surname, :OLD.u_groom_birthday, 
        :OLD.u_bride_name, :OLD.u_bride_surname, :OLD.u_bride_birthday, SYSTIMESTAMP, 'delete');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER CEREMONIESCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Ceremonies 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    INSERT INTO HistoryCeremonies(c_number, u_name_fk, c_date, manager_fk, change_timestamp, change_type)
      VALUES (:NEW.c_number, :NEW.u_name_fk, :NEW.c_date, :NEW.manager_fk, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
    INSERT INTO HistoryCeremonies(c_number, u_name_fk, c_date, manager_fk, change_timestamp, change_type)
      VALUES (:OLD.c_number, :OLD.u_name_fk, :OLD.c_date, :OLD.manager_fk, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
    INSERT INTO HistoryCeremonies(c_number, u_name_fk, c_date, manager_fk, change_timestamp, change_type)
      VALUES (:OLD.c_number, :OLD.u_name_fk, :OLD.c_date, :OLD.manager_fk, SYSTIMESTAMP, 'delete');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER ARTISTSCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Artists 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    INSERT INTO HistoryArtists(a_contract, a_name, a_email, a_genre, a_price_per_day, change_timestamp, change_type)
      VALUES (:NEW.a_contract, :NEW.a_name, :NEW.a_email, :NEW.a_genre, :NEW.a_price_per_day, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
    INSERT INTO HistoryArtists(a_contract, a_name, a_email, a_genre, a_price_per_day, change_timestamp, change_type)
      VALUES (:OLD.a_contract, :OLD.a_name, :OLD.a_email, :OLD.a_genre, :OLD.a_price_per_day, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
    INSERT INTO HistoryArtists(a_contract, a_name, a_email, a_genre, a_price_per_day, change_timestamp, change_type)
      VALUES (:OLD.a_contract, :OLD.a_name, :OLD.a_email, :OLD.a_genre, :OLD.a_price_per_day, SYSTIMESTAMP, 'delete');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER PERFORMANCESCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Performances 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    INSERT INTO HistoryPerformances(c_number_fk, a_contract_fk, p_is_confirmed, change_timestamp, change_type)
      VALUES (:NEW.c_number_fk, :NEW.a_contract_fk, :NEW.p_is_confirmed, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
    INSERT INTO HistoryPerformances(c_number_fk, a_contract_fk, p_is_confirmed, change_timestamp, change_type)
      VALUES (:OLD.c_number_fk, :OLD.a_contract_fk, :OLD.p_is_confirmed, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
    INSERT INTO HistoryPerformances(c_number_fk, a_contract_fk, p_is_confirmed, change_timestamp, change_type)
      VALUES (:OLD.c_number_fk, :OLD.a_contract_fk, :OLD.p_is_confirmed, SYSTIMESTAMP, 'delete');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER RESTAURANTSCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Restaurants 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    INSERT INTO HistoryRestaurants(r_contract, r_name, r_email, r_address, r_price_per_day, change_timestamp, change_type)
      VALUES (:NEW.r_contract, :NEW.r_name, :NEW.r_email, :NEW.r_address, :NEW.r_price_per_day, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
    INSERT INTO HistoryRestaurants(r_contract, r_name, r_email, r_address, r_price_per_day, change_timestamp, change_type)
      VALUES (:OLD.r_contract, :OLD.r_name, :OLD.r_email, :OLD.r_address, :OLD.r_price_per_day, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
    INSERT INTO HistoryRestaurants(r_contract, r_name, r_email, r_address, r_price_per_day, change_timestamp, change_type)
      VALUES (:OLD.r_contract, :OLD.r_name, :OLD.r_email, :OLD.r_address, :OLD.r_price_per_day, SYSTIMESTAMP, 'delete');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER ReservationsCHANGETRIGGER 
BEFORE INSERT OR DELETE OR UPDATE ON Reservations 
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    INSERT INTO HistoryReservations(c_number_fk, r_contract_fk, r_is_confirmed, change_timestamp, change_type)
      VALUES (:NEW.c_number_fk, :NEW.r_contract_fk, :NEW.r_is_confirmed, SYSTIMESTAMP, 'insert');
  END IF;
  IF UPDATING THEN
    INSERT INTO HistoryReservations(c_number_fk, r_contract_fk, r_is_confirmed, change_timestamp, change_type)
      VALUES (:OLD.c_number_fk, :OLD.r_contract_fk, :OLD.r_is_confirmed, SYSTIMESTAMP, 'update');
  END IF;
  IF DELETING THEN
    INSERT INTO HistoryReservations(c_number_fk, r_contract_fk, r_is_confirmed, change_timestamp, change_type)
      VALUES (:OLD.c_number_fk, :OLD.r_contract_fk, :OLD.r_is_confirmed, SYSTIMESTAMP, 'delete');
  END IF;
END;
/
