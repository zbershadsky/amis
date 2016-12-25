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