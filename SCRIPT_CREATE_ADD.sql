--DROP TABLE Img_class;
--DROP TABLE USER_DATA;
--DROP TABLE TAGS;
--DROP TABLE DEMO;
--DROP TABLE USERS;

--All about Users
CREATE TABLE Users (
user_name    varchar2(40)  NOT NULL , 
user_pass    varchar2(40)  NOT NULL ,
user_mail    varchar2(40)  NOT NULL UNIQUE,
user_status  varchar2(1)   NOT NULL );

ALTER TABLE Users		ADD CONSTRAINT PK_Users		PRIMARY KEY (user_name);

INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Alex9', '12345678Uu', 'uuu@uuu.uuu', 'u');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Brent1', '12345678Aa', 'bbb@iii.oi', 'a');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('David013', '12345678Bb', 'davivdavid@vvv.com', 'b');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Nik25', '12345678Zz', '12345678@qq.zz', 'u');
INSERT INTO USERS (user_name, user_pass, user_mail, user_status) VALUES ('Toni7', '12345678Tt', 'toni.toni@tt.tt', 'u');





--All about demo
CREATE TABLE demo (
demo_id		integer NOT NULL, 
demo_blol	blob 			    NOT NULL,
user_name	varchar2(40)	, 
visible		varchar(1)		NOT NULL
);

ALTER TABLE demo		ADD CONSTRAINT PK_demo		PRIMARY KEY (demo_id);

ALTER TABLE demo
ADD CONSTRAINT FK_demo_Users FOREIGN KEY (user_name) REFERENCES Users (user_name);

CREATE DIRECTORY FILEUPLOADS AS 'D:\images_for_db_populate';

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

INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (000, loadBlobFromFile ('00.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (001, loadBlobFromFile ('01.jpg'),'Nik25','v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (002, loadBlobFromFile ('02.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (003, loadBlobFromFile ('03.jpg'),'Alex9','v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (004, loadBlobFromFile ('04.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (005, loadBlobFromFile ('05.jpg'),'David013','v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (006, loadBlobFromFile ('06.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (007, loadBlobFromFile ('07.jpg'),'Nik25','v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (008, loadBlobFromFile ('08.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (009, loadBlobFromFile ('09.jpg'),null,'v');
INSERT INTO demo (demo_id, demo_blol, user_name, visible) VALUES (010, loadBlobFromFile ('10.jpg'),null,'v');





--All about Img_class
CREATE TABLE Img_class (
demo_id		integer, 
class_name	varchar2(40),
class_id  integer
);

ALTER TABLE Img_class		ADD CONSTRAINT PK_Img_class	PRIMARY KEY (class_id);

ALTER TABLE Img_class
ADD CONSTRAINT FK_Img_class_demo FOREIGN KEY (demo_id) REFERENCES demo (demo_id);

insert into Img_class (demo_id, class_name, class_id) values (000, 'comic strip', 000);
insert into Img_class (demo_id, class_name, class_id) values (001, 'photo', 001);
insert into Img_class (demo_id, class_name, class_id) values (002, 'computer graphics', 002);
insert into Img_class (demo_id, class_name, class_id) values (003, 'oil paints', 003);
insert into Img_class (demo_id, class_name, class_id) values (004, 'computer graphics', 004);
insert into Img_class (demo_id, class_name, class_id) values (005, 'oil paints', 005);
insert into Img_class (demo_id, class_name, class_id) values (006, 'oil paints', 006);
insert into Img_class (demo_id, class_name, class_id) values (007, 'watercolor', 007);
insert into Img_class (demo_id, class_name, class_id) values (008, 'computer graphics', 008);
insert into Img_class (demo_id, class_name, class_id) values (009, 'watercolor', 009);
insert into Img_class (demo_id, class_name, class_id) values (010, 'photo', 010);