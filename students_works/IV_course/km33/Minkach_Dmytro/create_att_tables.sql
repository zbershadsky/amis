--Create tables
CREATE TABLE Teachers (
  t_phone_number VARCHAR2(40) NOT NULL,
  t_name VARCHAR2(40) NOT NULL,
  t_surname VARCHAR2(40) NOT NULL,
  t_password VARCHAR2(40) NOT NULL,
  t_email VARCHAR2(40) NOT NULL,
  t_is_active NUMBER NOT NULL
);

CREATE TABLE Students (
  s_phone_number VARCHAR2(40) NOT NULL,
  s_name VARCHAR2(40) NOT NULL,
  s_surname VARCHAR2(40) NOT NULL,
  s_password VARCHAR2(40) NOT NULL,
  s_email VARCHAR2(40) NOT NULL,
  s_group VARCHAR2(40) NOT NULL,
  s_is_active NUMBER NOT NULL
);

CREATE TABLE Subjects (
  subj_name VARCHAR2(40) NOT NULL,
  subj_credits VARCHAR2(40) NOT NULL
);

CREATE TABLE Rooms (
  r_number VARCHAR2(10) NOT NULL,
  r_build_number VARCHAR2(5) NOT NULL
);

CREATE TABLE Schedule (
  t_email_fk VARCHAR2(40) NOT NULL,
  subj_name_fk VARCHAR2(40) NOT NULL,
  sch_date DATE NOT NULL,
  r_number_fk VARCHAR2(10) NOT NULL,
  r_build_number_fk VARCHAR2(5) NOT NULL
);

CREATE TABLE Attendance (
  t_email_fk VARCHAR2(40) NOT NULL,
  s_email_fk VARCHAR2(40) NOT NULL,
  subj_name_fk VARCHAR2(40) NOT NULL,
  sch_date_fk DATE NOT NULL,
  att_presence NUMBER NOT NULL
); 



--alter tables
ALTER TABLE Teachers
  ADD CONSTRAINT Teachers_PK PRIMARY KEY (t_email);  
  
ALTER TABLE Subjects
  ADD CONSTRAINT Subject_PK PRIMARY KEY (subj_name); 
  
ALTER TABLE Rooms
  ADD CONSTRAINT Room_num_PK PRIMARY KEY (r_number, r_build_number); 

ALTER TABLE Schedule
  ADD CONSTRAINT Schedule_PK PRIMARY KEY (t_email_fk, subj_name_fk, sch_date); 
ALTER TABLE Schedule
  ADD CONSTRAINT Schedule_FK_1 FOREIGN KEY (t_email_fk) REFERENCES Teachers(t_email);
ALTER TABLE Schedule 
  ADD CONSTRAINT Schedule_FK_2 FOREIGN KEY (subj_name_fk) REFERENCES Subjects(subj_name);  
ALTER TABLE Schedule 
  ADD CONSTRAINT Schedule_FK_3 FOREIGN KEY (r_number_fk, r_build_number_fk) REFERENCES Rooms(r_number, r_build_number);

  
ALTER TABLE Students
  ADD CONSTRAINT Students_PK PRIMARY KEY (s_email); 
  
ALTER TABLE Attendance
  ADD CONSTRAINT Attendance_PK PRIMARY KEY (t_email_fk, s_email_fk, subj_name_fk, sch_date_fk);
ALTER TABLE Attendance
  ADD CONSTRAINT Attendance_FK_1 FOREIGN KEY (t_email_fk, subj_name_fk, sch_date_fk) REFERENCES Schedule(t_email_fk, subj_name_fk, sch_date);  
ALTER TABLE Attendance 
  ADD CONSTRAINT Attendance_FK_3 FOREIGN KEY (s_email_fk) REFERENCES Students(s_email); 
  
  
----------------------------------------------------------
PROCEDURES
----------------------------------------------------------


--ALTER SYSTEM SET O7_DICTIONARY_ACCESSIBILITY=TRUE SCOPE=SPFILE; -- run first with sys, then restart

--GRANT EXECUTE ON "SYS"."DBMS_CRYPTO" TO "PUBLIC"; -- for md5 hash function

-- status 0=ok 1=EmailAlreadyExist
CREATE OR REPLACE PROCEDURE REGISTERNEWTEACHER (
  U_EMAIL IN VARCHAR2,
  U_PASSWORD IN VARCHAR2,
  U_NAME IN VARCHAR2,
  U_SURNAME IN VARCHAR2,
  U_PHONE IN VARCHAR2,
  STATUS OUT NUMBER 
) AS 
  existEmail INTEGER;
BEGIN
    SET TRANSACTION ISOLATION LEVEL serializable;
    SELECT COUNT(*) INTO existEmail FROM Teachers WHERE U_EMAIL = T_EMAIL;
      STATUS := 0;
      IF existEmail = 0 THEN
        BEGIN
          INSERT INTO Teachers (T_EMAIL, T_PASSWORD, T_NAME, T_SURNAME, 
                                T_PHONE_NUMBER, T_IS_ACTIVE) 
                        VALUES (U_EMAIL, 
                        dbms_crypto.hash(rawtohex(U_PASSWORD), dbms_crypto.hash_md5), 
                        U_NAME, U_SURNAME, U_PHONE, 1);
          COMMIT;
        END;
      ELSE
        STATUS := 1;
      END IF;
END REGISTERNEWTEACHER;
/

-- status 0=ok 1=EmailAlreadyExist
CREATE OR REPLACE PROCEDURE REGISTERNEWSTUDENT (
  U_EMAIL IN VARCHAR2,
  U_PASSWORD IN VARCHAR2,
  U_NAME IN VARCHAR2,
  U_SURNAME IN VARCHAR2,
  U_GROUP IN VARCHAR2,
  U_PHONE IN VARCHAR2,
  STATUS OUT NUMBER 
) AS 
  existEmail INTEGER;
BEGIN
    SET TRANSACTION ISOLATION LEVEL serializable;
    SELECT COUNT(*) INTO existEmail FROM Students WHERE U_EMAIL = S_EMAIL;
      IF existEmail = 0 THEN
        BEGIN
          INSERT INTO Students (S_EMAIL, S_PASSWORD, S_NAME, S_SURNAME, 
                                S_PHONE_NUMBER, S_IS_ACTIVE, S_GROUP) 
                        VALUES (U_EMAIL, 
                        dbms_crypto.hash(rawtohex(U_PASSWORD), dbms_crypto.hash_md5), 
                        U_NAME, U_SURNAME, U_PHONE, 1, U_GROUP);
          COMMIT;
          STATUS := 0;
        END;
      ELSE
        STATUS := 1;
      END IF;
END REGISTERNEWSTUDENT;
/

-- status 0=ok 1=DoNotExist
CREATE OR REPLACE PROCEDURE AUTHORIZE (
  U_EMAIL IN VARCHAR2,
  U_PASSWORD IN VARCHAR2,
  STATUS OUT NUMBER,
  IS_TEACHER OUT NUMBER
) AS 
  existUser INTEGER;
  existTeacher INTEGER;
BEGIN
  IS_TEACHER := 0;
  STATUS :=0;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT COUNT(*) INTO existUser FROM Students 
    WHERE u_email = S_EMAIL 
    AND dbms_crypto.hash(rawtohex(u_password), dbms_crypto.hash_md5) = S_PASSWORD;
  IF existUser = 0 THEN
    BEGIN
      SELECT COUNT(*) INTO existTeacher FROM Teachers WHERE 
        u_email = T_EMAIL AND 
        dbms_crypto.hash(rawtohex(u_password), dbms_crypto.hash_md5) = T_PASSWORD;
      IF existTeacher = 0 THEN
        STATUS := 1;
      ELSE
        IS_TEACHER := 1;
      END IF;
      COMMIT;
    END;
  END IF;
END AUTHORIZE;
/

CREATE OR REPLACE PROCEDURE VIEWSTUDENT (
  U_EMAIL IN VARCHAR2,
  U_NAME OUT VARCHAR2,
  U_SURNAME OUT VARCHAR2,
  U_GROUP OUT VARCHAR2,
  U_PHONE OUT VARCHAR2,
  STATUS OUT NUMBER,
  IS_TEACHER OUT NUMBER
) AS 
BEGIN
  IS_TEACHER := 0;
  STATUS := 0;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT S_NAME, S_SURNAME, S_PHONE_NUMBER, S_GROUP INTO 
         U_NAME, U_SURNAME, U_PHONE, U_GROUP
         FROM Students 
    WHERE u_email = S_EMAIL;
  EXCEPTION
   WHEN no_data_found THEN
      IS_TEACHER := 0;
      STATUS := 1;
   WHEN others THEN
      IS_TEACHER := 0;
      STATUS :=1;
END VIEWSTUDENT;
/

CREATE OR REPLACE PROCEDURE VIEWTEACHER (
  U_EMAIL IN VARCHAR2,
  U_NAME OUT VARCHAR2,
  U_SURNAME OUT VARCHAR2,
  U_PHONE OUT VARCHAR2,
  STATUS OUT NUMBER,
  IS_TEACHER OUT NUMBER
) AS 
BEGIN
  IS_TEACHER := 0;
  STATUS := 0;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT T_NAME, T_SURNAME, T_PHONE_NUMBER INTO 
         U_NAME, U_SURNAME, U_PHONE
         FROM Teachers 
    WHERE u_email = T_EMAIL;
  EXCEPTION
   WHEN no_data_found THEN
      IS_TEACHER := 1;
      STATUS := 1;
   WHEN others THEN
      IS_TEACHER := 1;
      STATUS := 1;
END VIEWTEACHER;
/

CREATE OR REPLACE PROCEDURE UPDATEATTENDANCE (
  EMAIL IN VARCHAR2,
  SCH_DATE IN VARCHAR2,
  PRESENCE IN NUMBER
) AS 
BEGIN
  SET TRANSACTION ISOLATION LEVEL serializable;
  UPDATE ATTENDANCE
  SET ATT_PRESENCE = PRESENCE
  WHERE (S_EMAIL_FK = EMAIL) AND (SCH_DATE_FK = SCH_DATE);
END UPDATEATTENDANCE;
/

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