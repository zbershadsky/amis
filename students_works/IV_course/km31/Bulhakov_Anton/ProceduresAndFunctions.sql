create or replace PROCEDURE encryptString(input_string IN VARCHAR2,encrypted_string OUT VARCHAR2)
IS
  work_string       VARCHAR2(4000);
BEGIN
  work_string := RPAD
                ( input_string
                , (TRUNC(LENGTH(input_string) / 8) + 1 ) * 8
                , CHR(0)
                );
  DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT
           (
             input_string     => work_string
           , key_string       => 'AntonBulgakov'
           , encrypted_string => encrypted_string
           );
END encryptString;

COMMIT;

create or replace PROCEDURE decryptString(encrypted_string IN VARCHAR2,decrypted_string OUT VARCHAR2)
IS
  work_string       VARCHAR2(4000);
BEGIN
  DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT
           (
            input_string     => encrypted_string
           ,key_string       => 'AntonBulgakov'
           ,decrypted_string => work_string
           );

  decrypted_string := RTRIM(work_string, CHR(0));
END decryptString;

COMMIT;

create or replace FUNCTION decryptId(encryptedId IN VARCHAR2) RETURN VARCHAR2
IS
  decryptedId VARCHAR2(100);
BEGIN
  DECRYPTSTRING(encryptedId,decryptedId);
  RETURN decryptedId;
END decryptId;

COMMIT;

create or replace FUNCTION md5_digest(input_string IN VARCHAR2) RETURN VARCHAR2
IS
  hex_digest varchar2(32);
  digest varchar2(16);
BEGIN
  digest := DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => input_string);
  SELECT Lower(RAWTOHEX(digest)) INTO hex_digest FROM dual;
  RETURN hex_digest;
END;

COMMIT;

create or replace FUNCTION encryptId(userId IN VARCHAR2) RETURN VARCHAR2
IS
  encryptedId VARCHAR2(100);
BEGIN
  ENCRYPTSTRING(userId,encryptedId);
  RETURN encryptedId;
END encryptId;

COMMIT;

create or replace procedure getUserStatus(id IN VARCHAR2, status OUT VARCHAR)
IS
BEGIN
  SELECT status INTO status FROM Users WHERE Identity_code = ENCRYPTID(id);
  COMMIT;
END getUserStatus;

COMMIT;

create or replace PROCEDURE getUserInfo
(id IN VARCHAR2,
firstName OUT VARCHAR2,
surname OUT VARCHAR2,
secondName OUT VARCHAR2,
numberPassport OUT VARCHAR2,
userPhone OUT VARCHAR2,
userEmail OUT VARCHAR2,
userCity OUT VARCHAR2,
userStreet OUT VARCHAR2,
userHouse OUT VARCHAR2,
userFlat OUT NUMBER)
IS
BEGIN
  SELECT first_name, surname, second_name, number_passport, phone, email, city, street, house, flat
  INTO firstName, surname, secondName, numberPassport, userPhone, userEmail, userCity, userStreet, userHouse, userFlat
  FROM Users WHERE identity_code = ENCRYPTID(id);
  COMMIT;
END getUserInfo;

COMMIT;

create or replace PROCEDURE getUserId(login IN VARCHAR2,password IN VARCHAR2,id OUT VARCHAR2)
IS
  idCode VARCHAR2(100);
BEGIN
  SELECT IDENTITY_CODE INTO idCode FROM Users WHERE email = login AND md5_digest(password) = user_password;
  DECRYPTSTRING(idCode,id);
  COMMIT;
END getUserId;

COMMIT;

create or replace procedure getUserContract(id IN VARCHAR2, numberContract OUT NUMBER, 
dateConclusion OUT DATE, sum OUT NUMBER, 
months OUT NUMBER,creditType OUT VARCHAR2, maturity OUT VARCHAR2)
IS
BEGIN
  SELECT number_contract, date_conclusion, sum, maturity, credit_type,quantity_months 
  INTO numberContract, dateConclusion, sum, maturity, creditType, months
  FROM CREDITCONTRACT WHERE borrower = ENCRYPTID(id) AND status = 'active';
  COMMIT;
END getUserContract;

COMMIT;

create or replace PROCEDURE getShortUserInfo(listUser OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN listUser FOR
    SELECT decryptid(identity_code), first_name, surname, second_name, status
    FROM Users
    WHERE status <> 'ban' OR status <> 'superAdmin';
END getShortUserInfo;

COMMIT;

create or replace PROCEDURE getPayments(userId IN VARCHAR2, paymentList OUT SYS_REFCURSOR)
AS
  numberContract NUMBER(38);
BEGIN
  SELECT number_contract INTO numberContract FROM CreditContract WHERE borrower = ENCRYPTID(userId) AND status = 'active'; 
  OPEN paymentList FOR
    SELECT payment_date, sum, number_contract FROM PaymentData WHERE number_contract = numberContract;
END getPayments;

COMMIT;

create or replace PROCEDURE getMaturity(maturityList OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN maturityList FOR
    SELECT maturity_type FROM maturity;
  COMMIT;
END getMaturity;

COMMIT;

create or replace PROCEDURE getCreditType(listCreditType OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN listCreditType FOR
    SELECT type_name, quantity_months FROM CreditType;
  COMMIT;
END getCreditType;

COMMIT;

create or replace PROCEDURE getCreditRate(creditType IN VARCHAR2, months IN NUMBER, rateContract OUT NUMBER)
AS
BEGIN
  SELECT rate INTO rateContract FROM CreditType WHERE TYPE_NAME = creditType AND QUANTITY_MONTHS = months;
  COMMIT;
END getCreditRate;

COMMIT;

create or replace PROCEDURE closeCreditContract(contractNumber IN NUMBER, adminId IN VARCHAR2)
AS
  userStatus VARCHAR2(50);
BEGIN
    SELECT status INTO userStatus FROM Users WHERE identity_code = ENCRYPTID(adminId);
    IF (userStatus = 'superAdmin') THEN
      UPDATE CreditContract SET status = 'closed' WHERE number_contract = contractNumber;
      COMMIT;
    END IF;
END closeCreditContract;

COMMIT;

create or replace PROCEDURE checkUser(login IN VARCHAR2,password IN VARCHAR2,status OUT VARCHAR2)
IS
  passwordHash VARCHAR2(100);
  userStatus VARCHAR2(100);
BEGIN
  SELECT USER_PASSWORD, STATUS INTO passwordHash,UserStatus FROM Users WHERE email = login;
  IF ((passwordHash = md5_digest(password)) AND (UserStatus <> 'Ban') )THEN
    status := 'true';
  ELSE
    status := 'false';
  END IF;
END checkUser;

COMMIT;

create or replace PROCEDURE changeUserInfo
(id IN VARCHAR2,
firstName IN VARCHAR2,
usersurname IN VARCHAR2,
secondName IN VARCHAR2,
numberPassport IN VARCHAR2,
userPhone IN VARCHAR2,
userEmail IN VARCHAR2,
userCity IN VARCHAR2,
userStreet IN VARCHAR2,
userHouse IN VARCHAR2,
userFlat IN NUMBER,
userPassword IN VARCHAR,
userStatus IN VARCHAR2,
statusOperation OUT VARCHAR2)
IS
BEGIN
  IF (userPassword = '1111') THEN
    UPDATE Users SET 
      first_name = firstName,
      surname = usersurname,
      second_name = secondName,
      number_passport = numberPassport,
      phone = userPhone,
      email = userEmail,
      city = userCity,
      street = userStreet,
      house = userHouse,
      flat = userFlat,
      status = userStatus
    WHERE identity_code = ENCRYPTID(id);
    statusOperation := 'true';
  ELSE
    UPDATE Users SET 
        first_name = firstName,
        surname = usersurname,
        second_name = secondName,
        number_passport = numberPassport,
        phone = userPhone,
        email = userEmail,
        city = userCity,
        street = userStreet,
        house = userHouse,
        flat = userFlat,
        status = userStatus,
        user_password = md5_digest(userPassword)
      WHERE identity_code = ENCRYPTID(id);
      statusOperation := 'true';
  END IF;
  COMMIT;
END changeUserInfo;

COMMIT;

create or replace PROCEDURE addNewUser
(id IN VARCHAR2,
firstName IN VARCHAR2,
surname IN VARCHAR2,
secondName IN VARCHAR2,
numberPassport IN VARCHAR2,
userPhone IN VARCHAR,
userEmail IN VARCHAR2,
userCity IN VARCHAR2,
userStreet IN VARCHAR2,
userHouse IN VARCHAR2,
userFlat IN NUMBER,
userPassword IN VARCHAR,
userStatus IN VARCHAR2,
statusOperation OUT VARCHAR2)
IS
  status VARCHAR2(100);
  CURSOR idCodeEmailCursor IS
    SELECT identity_code, email FROM Users;
BEGIN
  status := 'true';
  FOR val IN idCodeEmailCursor
  LOOP
    IF (val.identity_code = ENCRYPTID(id) OR val.email = userEmail) THEN
      status := 'false';
    END IF;
  END LOOP;
  IF (status = 'true') THEN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    INSERT INTO Users(identity_code, user_password, first_name, surname, second_name, number_passport, phone, email, city, street, house, flat, status)
    VALUES(id, userPassword, firstName, surname, secondName, numberPassport, userPhone, userEmail, userCity, userStreet, userHouse, userFlat, userStatus);
    COMMIT;
    statusOperation := 'true';
  ELSE
    statusOperation := 'false';
  END IF;
END addNewUser;

COMMIT;

create or replace PROCEDURE addNewContract
(userId IN VARCHAR2,
sum IN NUMBER,
creditType IN VARCHAR2,
months IN NUMBER,
maturity IN VARCHAR2,
statusOperation OUT VARCHAR2)
IS
  currentStatus VARCHAR2(50);
  CURSOR creditContractCursor IS
    SELECT status,borrower FROM Creditcontract;
  creditContractStatus VARCHAR2(50);
  CURSOR userStatusCursor IS
    SELECT status FROM Users WHERE identity_code = ENCRYPTID(userId);
BEGIN
  creditContractStatus := 'active';
  statusOperation := 'true';
  FOR val IN creditContractCursor
  LOOP
    IF (val.status = 'active' AND val.borrower = ENCRYPTID(userId)) THEN
      statusOperation := 'false';
    END IF;
  END LOOP;
  
  FOR valTmp IN userStatusCursor
  LOOP
    IF (valTmp.status = 'ban') THEN
      statusOperation := 'false';
    END IF;
  END LOOP;
    
    IF(statusOperation <> 'false') THEN
      SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
      INSERT INTO Creditcontract (date_conclusion, sum, borrower, maturity, credit_type, quantity_months)
      VALUES(SYSDATE, sum, ENCRYPTID(userId), maturity, creditType, months);
      COMMIT;
      statusOperation := 'true';
    END IF;
END addNewContract;

COMMIT;

