CREATE OR REPLACE VIEW SEARCHINCLASS AS 
Select D.demo_id D_ID, CLASS_NAME C_NAME, DEMO_BLOL IMG, visible show
FROM demo D join img_class I on (D.demo_id = I.demo_id)
where visible = 'v';
/




CREATE OR REPLACE VIEW SEECLASS AS 
Select D.demo_id d_id, class_name c_name, class_id c_id, visible show
FROM demo D join img_class I on (D.demo_id = I.demo_id);
/



CREATE OR REPLACE VIEW VIEWALLARTS AS 
Select demo_blol img, visible show, demo_id ident, user_name author
from demo
order by ident;
/


CREATE OR REPLACE VIEW VIEWUSERS AS 
Select user_name U_Name, user_status U_Status, user_pass u_pass, user_mail u_mail
from users
where user_status != 'a';
/


--Proc
CREATE OR
REPLACE PROCEDURE ADDCLASS (
d_id in integer,
c_name in varchar2,
c_id in integer,
status out varchar2
)
AS
existsC_id integer;
existsD_id integer;
BEGIN
SET TRANSACTION ISOLATION LEVEL serializable;
select count(*) into existsC_id from img_class where class_id = c_id;
IF existsC_id = 0 THEN
BEGIN 
select count(*) into existsD_id from demo where demo_id = d_id;
IF existsD_id > 0 then
begin
INSERT INTO img_class (demo_id, class_name, class_id) 
VALUES (d_id, c_name, c_id);
status := 'Column added successfully';
commit;
end;
else
status := 'Fail to find image by entered id';
end if;
end;
else
status := 'Class_id already exists';
end if;
END ADDCLASS;
/


create or replace 
PROCEDURE AUTHORIZEUSER (
  U_NAME IN VARCHAR2,
  U_PASS IN VARCHAR2,
  STATUS OUT VARCHAR2,
  IS_BANNED OUT NUMBER,
  IS_ADMIN OUT NUMBER
) AS 
  userMatchCount INTEGER;
  isBannedCount INTEGER;
  isAdminCount INTEGER;
BEGIN
  --SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT COUNT(*) INTO userMatchCount FROM Users WHERE user_name = U_NAME AND user_pass = U_PASS;
  IF userMatchCount > 0 THEN
    BEGIN
      STATUS := 'ok';
      SELECT COUNT(*) INTO isBannedCount FROM USERS WHERE user_name = U_NAME AND user_pass = U_PASS AND user_status = 'b';
      IF isBannedCount > 0 THEN
        IS_BANNED := 1;
      ELSE
        IS_BANNED := 0;
      END IF;
      
      SELECT COUNT(*) INTO isAdminCount FROM Users WHERE user_name = U_NAME AND user_pass = U_PASS AND user_status = 'a';
      IF isAdminCount > 0 THEN
        IS_ADMIN := 1;
      ELSE
        IS_ADMIN := 0;
      END IF;
      status := 'ok';
      COMMIT;
    END;
  ELSE
    STATUS := 'Combination name-pass is not exist!';
    IS_BANNED := 0;
    IS_ADMIN := 0;
  END IF;
END AUTHORIZEUSER;
/


create or replace 
PROCEDURE             NEWPASSWORD (
  U_NAME IN VARCHAR2,
  U_PASS IN VARCHAR2,
  U_NEW_PASS IN varchar2,
  STATUS OUT VARCHAR2
 ) AS
loginPassPairCount INTEGER;
BEGIN
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT COUNT(*) INTO loginPassPairCount FROM Users WHERE user_name = U_NAME AND user_pass = U_PASS;
  IF loginPassPairCount  > 0 THEN
    BEGIN
      STATUS := 'ok';
      UPDATE Users SET user_pass = U_NEW_PASS WHERE user_name = U_NAME;
    END;
  ELSE
    STATUS := 'Wrong login/password combination';
  END IF;
END NEWPASSWORD;
/


create or replace 
PROCEDURE REGISTERNEWUSER (
  U_NAME IN VARCHAR2,
  U_PASS IN VARCHAR2,
  U_MAIL IN VARCHAR2, 
  STATUS OUT VARCHAR2 
) AS 
  sameLoginCount INTEGER;
  sameEmailCount INTEGER;
BEGIN
  --SET TRANSACTION ISOLATION LEVEL serializable;
  SELECT COUNT(*) INTO sameLoginCount FROM Users WHERE user_name = U_NAME;
  IF sameLoginCount = 0 THEN
    BEGIN
      SELECT COUNT(*) INTO sameEmailCount FROM Users WHERE user_mail = U_MAIL;
      IF sameEmailCount = 0 THEN
        BEGIN
          INSERT INTO users(user_name, user_pass, user_mail, user_status) 
          VALUES (U_NAME, U_PASS, U_MAIL, 'u');
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


create or replace 
PROCEDURE RENAMECLASS (
c_oldname IN varchar2,
c_name IN varchar2,
status out varchar2
) AS
existsVar integer;
BEGIN
SET TRANSACTION ISOLATION LEVEL serializable;
select count(class_id) into existsVar from img_class where class_name = c_oldname;
if existsVar > 0 then
begin 
update img_class set class_name = c_name where class_name = c_oldname;
        status := 'Class name rename successfully';
        commit;
      end;
      else
      status := 'Fail to rename class';
end if;
END RENAMECLASS;
/


create or replace 
PROCEDURE UPDATEIMGVIS (
  D_ID IN VARCHAR2, 
  VIS IN varchar,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
BEGIN
 -- SET TRANSACTION ISOLATION LEVEL serializable;
  select count (*) into userExists from demo where demo_id = D_ID;
  if userExists > 0 then
       begin
        update demo set visible = vis where demo_id = D_ID;
        status := 'Visible update successfully';
        commit;
      end;
    else
     status := 'Fail to update vis';
  end if;
END UPDATEIMGVIS;
/


create or replace 
PROCEDURE UPDATETABLE (
  U_NAME IN VARCHAR2, 
  U_STATUS IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
userExists integer;
BEGIN
 -- SET TRANSACTION ISOLATION LEVEL serializable;
  select count (*) into userExists from users where user_name = u_name;
  if userExists > 0 then
       begin
        update USERS set user_status = U_STATUS where user_name = u_name;
        status := 'User status update successfully';
        commit;
      end;
    else
     status := 'Fail to update status - user not found';
  end if;
END UPDATETABLE ;
/


CREATE SEQUENCE SEQ1
  MINVALUE 1
 MAXVALUE 1000
 INCREMENT BY 1
 START WITH 11 
 CACHE 10 
;
