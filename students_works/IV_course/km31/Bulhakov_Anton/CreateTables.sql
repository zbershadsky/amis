CREATE TABLE Users
(
  identity_code VARCHAR2(100) NOT NULL,
  user_password VARCHAR2(100) NOT NULL,
  first_name VARCHAR2(50) NOT NULL,
  surname VARCHAR2(50) NOT NULL,
  second_name VARCHAR2(50) NOT NULL,
  number_passport VARCHAR2(8) NOT NULL,
  phone VARCHAR2(100) NOT NULL,
  email VARCHAR2(50) NOT NULL,
  city VARCHAR2(50),
  street VARCHAR2(50),
  house VARCHAR2(50),
  flat Number(3),
  status VARCHAR2(50) NOT NULL
);

CREATE TABLE Maturity
(
  maturity_type VARCHAR2(50) NOT NULL
);

CREATE TABLE CreditType
(
  type_name VARCHAR2(50) NOT NULL,
  quantity_months Number(2) NOT NULL,
  rate Number(3) NOT NULL
);

CREATE TABLE PaymentData
(
  payment_date DATE NOT NULL,
  sum DECIMAL(8,2) NOT NULL,
  number_contract NUMBER(38) NOT NULL
);

CREATE TABLE CreditContract
(
  number_contract NUMBER(38,0) NOT NULL,
  date_conclusion DATE NOT NULL,
  sum DECIMAL(8,2) NOT NULL,
  status VARCHAR2(50) NOT NULL,
  borrower VARCHAR2(100) NOT NULL,
  maturity VARCHAR2(50) NOT NULL,
  credit_type VARCHAR2(50) NOT NULL,
  quantity_months Number(2) NOT NULL,
  months Number(2) NOT NULL
);