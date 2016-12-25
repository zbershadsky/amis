CREATE DIRECTORY FILEUPLOADS AS 'D:\images_for_db_populate';

-------------------------
-- Create Customer table
-------------------------
CREATE TABLE Customer (
  cust_name varchar2(100) NOT NULL,
  cust_pass varchar2(100) NOT NULL,
  cust_email varchar2(100) NOT NULL,
  cust_phone varchar2(100) NOT NULL,
  CONSTRAINT primary_key_customer PRIMARY KEY (cust_name)
);

-------------------------
-- Create Supermarket table
-------------------------
CREATE TABLE Supermarket (
  supermarket_name varchar2(100) NOT NULL,
  supermarket_image blob NOT NULL,
  CONSTRAINT primary_key_supermarket PRIMARY KEY (supermarket_name)
);

-------------------------
-- Create SectionProducts table
-------------------------
CREATE TABLE SectionProducts (
  section_name varchar2(100) NOT NULL,
  section_image blob NOT NULL,
  CONSTRAINT primary_key_section PRIMARY KEY (section_name)
);

-------------------------
-- Create Product table
-------------------------
CREATE TABLE Product (
  prod_name varchar2(1000) NOT NULL,
  supermarket_name varchar2(100) NOT NULL,
  section_name varchar2(100) NOT NULL,
  prod_price decimal(8,2) NOT NULL,
  prod_desc varchar2(4000) NOT NULL,
  prod_image blob NOT NULL,
  CONSTRAINT primary_key_product PRIMARY KEY (prod_name, supermarket_name),
  CONSTRAINT foreign_key_supermarket FOREIGN KEY (supermarket_name) REFERENCES Supermarket (supermarket_name),
  CONSTRAINT foreign_key_section FOREIGN KEY (section_name) REFERENCES SectionProducts (section_name)
);

-------------------------
-- Create OrderItem table
-------------------------
CREATE TABLE OrderItem (
  cust_name varchar2(100) NOT NULL,
  order_date date NOT NULL,
  order_item int NOT NULL,
  supermarket_name varchar2(100) NOT NULL,
  prod_name varchar2(1000) NOT NULL,
  quantity int NOT NULL,
  CONSTRAINT primary_key_orderitem PRIMARY KEY (cust_name, order_date, order_item),
  CONSTRAINT foreign_key_customer FOREIGN KEY (cust_name) REFERENCES Customer (cust_name),
  CONSTRAINT foreign_key_product FOREIGN KEY (prod_name, supermarket_name) REFERENCES Product (prod_name, supermarket_name)
);

----------------------------------------------
-- Create or replace loadBlobFromFile function
----------------------------------------------
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

-----------------------------------------
-- Create or replace insertUser procedure
-----------------------------------------
CREATE OR REPLACE PROCEDURE insertUser
(username IN varchar2, pass IN varchar2, email IN varchar2, phone IN varchar2)
IS
BEGIN
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  INSERT INTO Customer (cust_name, cust_pass, cust_email, cust_phone) 
  VALUES (username, pass, email, phone);
  COMMIT;
END insertUser;

---------------------------------------------
-- Create or replace updatePassword procedure
---------------------------------------------
CREATE OR REPLACE PROCEDURE updatePassword
(username IN varchar2, new_password IN varchar2)
IS
BEGIN
  UPDATE Customer SET cust_pass = new_password WHERE cust_name = username;
  COMMIT;
END updatePassword;

------------------------------------------
-- Create or replace updatePhone procedure
------------------------------------------
CREATE OR REPLACE PROCEDURE updatePhone
(username IN varchar2, new_phone IN varchar2)
IS
BEGIN
  UPDATE Customer SET cust_phone = new_phone WHERE cust_name = username;
  COMMIT;
END updatePhone;

------------------------------------------
-- Create or replace updateEmail procedure
------------------------------------------
CREATE OR REPLACE PROCEDURE updateEmail
(username IN varchar2, new_email IN varchar2)
IS
BEGIN
  UPDATE Customer SET cust_email = new_email WHERE cust_name = username;
  COMMIT;
END updateEmail;