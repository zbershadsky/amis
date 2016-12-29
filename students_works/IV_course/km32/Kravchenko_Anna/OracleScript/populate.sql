INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Alex9', '12345678Nn', 'uuu@uuu.uuu', 'u');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Brent1', '12345678Nn', 'bbb@iii.oi', 'a');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('David013', '12345678Zz', 'davivdavid@vvv.com', 'b');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Nik25', '12345678Nn', '12345678@qq.zz', 'u');

CREATE OR REPLACE FUNCTION loadBlobFromFile(p_file_name VARCHAR2) RETURN BLOB AS
  dest_loc  BLOB := empty_blob();
  src_loc   BFILE := BFILENAME('FILEUPLOADS', p_file_name);
BEGIN
  -- Open source binary file from OS
  DBMS_LOB.OPEN(src_loc, DBMS_LOB.LOB_READONLY);
  
  -- Create temporary LOB object
  DBMS_LOB.CREATETEMPORARY(
        lob_loc => dest_loc
      , cache   => true
      , dur     => dbms_lob.session
  );
    
  -- Open temporary lob
  DBMS_LOB.OPEN(dest_loc, DBMS_LOB.LOB_READWRITE);
  
  -- Load binary file into temporary LOB
  DBMS_LOB.LOADFROMFILE(
        dest_lob => dest_loc
      , src_lob  => src_loc
      , amount   => DBMS_LOB.getLength(src_loc));
  
  -- Close lob objects
  DBMS_LOB.CLOSE(dest_loc);
  DBMS_LOB.CLOSE(src_loc);
  
  -- Return temporary LOB object
  RETURN dest_loc;
END loadBlobFromFile;
/

INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('0', loadBlobFromFile ('00.jpg'),null,'comic','computer graphics');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('1', loadBlobFromFile ('01.jpg'),'Nik25','sheep','photo');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('2', loadBlobFromFile ('02.jpg'),null,'joke','computer graphics');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('3', loadBlobFromFile ('03.jpg'),'Alex9','woman','oil paints');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('4', loadBlobFromFile ('04.jpg'),null,'magic','computer graphics');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('5', loadBlobFromFile ('05.jpg'),'David013','hares','oil paints');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('6', loadBlobFromFile ('06.jpg'),null,'Black Square','oil paints');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('7', loadBlobFromFile ('07.jpg'),'Nik25','cat','water-color');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('8', loadBlobFromFile ('08.jpg'),null,'town','computer graphics');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('9', loadBlobFromFile ('09.jpg'),null,'deer','water-color');
INSERT INTO demo (demo_id, demo_blol, user_name, tag1, tag2) VALUES ('10', loadBlobFromFile ('10.jpg'),null,'Death Star','photo');

CREATE OR replace view a_work as
Select user_name U_Name, user_status U_Status, user_pass u_pass, user_mail u_mail
from users
where user_status != 'a';


CREATE OR replace view viewallarts as
Select demo_blol img, tag1 tag_main, tag2 tag, user_name author
from demo;

create or replace 
PROCEDURE NEWPASSWORD (
  U_NAME IN VARCHAR2,
  U_PASS IN VARCHAR2,
  U_NEW_PASS IN varchar2,
  STATUS OUT VARCHAR2,
  USER_PASSWORD OUT VARCHAR2  
) AS
loginEmailPairCount INTEGER;
BEGIN
 --SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  SELECT COUNT (*) INTO loginEmailPairCount FROM Users WHERE user_name = U_NAME AND user_pass = U_PASS;
  IF loginEmailPairCount > 0 THEN
    BEGIN
      STATUS := 'ok';
      UPDATE Users SET user_pass = U_NEW_PASS WHERE user_pass = U_PASS;
      --SELECT u_password INTO USER_PASSWORD FROM Users WHERE u_name = USER_NAME AND u_email = USER_EMAIL;
    END;
  ELSE
    STATUS := 'Failed to restore password. Wrong login/email combination';
    USER_PASSWORD := '';
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
      SELECT COUNT(*) INTO isBannedCount FROM Users WHERE user_name = U_NAME AND user_pass = U_PASS AND user_status = 'b';
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

create or replace PROCEDURE UPDATETABLE (
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
        status := 'ok';
        commit;
      end;
    else
     status := 'User not found.';
  end if;
END UPDATETABLE ;
/

create or replace 
PROCEDURE SENDKARTINOCHKA (
  FROM_USER IN VARCHAR2,
  SEND_LINK IN VARCHAR2,
  STATUS OUT VARCHAR2  
) AS 
BEGIN
  --SET TRANSACTION ISOLATION LEVEL serializable;
  INSERT INTO links (u_name, u_link) VALUES (FROM_USER, SEND_LINK);
  STATUS := 'ok';
  COMMIT;
END SENDKARTINOCHKA;
/