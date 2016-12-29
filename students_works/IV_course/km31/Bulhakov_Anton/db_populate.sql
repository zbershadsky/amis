INSERT INTO Users
(
  identity_code, user_password, first_name, surname, second_name, number_passport,
  phone, email, city, street, house, flat, status
)VALUES(
  1234567891, 'Bantom274898', 'Anton', 'Bulgakov', 'Igorovich', 'MB123456',
  '0996638095', 'anton.bulgak@gmail.com', 'Kiev', 'Victory avenue', '77/1', 19, 'superAdmin' 
);

INSERT INTO Users
(
  identity_code, user_password, first_name, surname, second_name, number_passport,
  phone, email, city, street, house, flat, status
)VALUES(
  1234567892, 'Bantom274898', 'Nastia', 'Skaletskaya', 'Olegovna', 'AS123451',
  '0634551599', 'nastia_skal@gmail.com', 'Kiev', 'Mayakovskogo', '35a', 35, 'admin' 
);

INSERT INTO Users
(
  identity_code, user_password, first_name, surname, second_name, number_passport,
  phone, email, city, street, house, flat, status
)VALUES(
  1234567893, 'Bantom274898', 'Vasia', 'Pupkin', 'Pupkinivich', 'AB123456',
  '0998877654', 'vasia@mail.ru', 'Sumy', 'Gorkogo', '111', 2, 'user' 
);

INSERT INTO Maturity
(
  maturity_type
)VALUES(
  'classic'
);

INSERT INTO Maturity
(
  maturity_type
)VALUES(
  'annuitet'
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'installment', 12, 15
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'installment', 6, 10
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'installment', 3, 8
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'consumer', 12, 20
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'consumer', 6, 30
);

INSERT INTO CreditType
(
  type_name, quantity_months, rate
)VALUES(
  'consumer', 3, 40
);