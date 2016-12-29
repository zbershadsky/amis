ALTER TABLE Users ADD CONSTRAINT identity_code_pk PRIMARY KEY (identity_code);
ALTER TABLE Maturity ADD CONSTRAINT maturity_type_pk PRIMARY KEY (maturity_type);
ALTER TABLE CreditType ADD CONSTRAINT credit_type_pk PRIMARY KEY (type_name,quantity_months);
ALTER TABLE PaymentData ADD CONSTRAINT payment_pk PRIMARY KEY (number_contract,payment_date);
ALTER TABLE CreditContract ADD CONSTRAINT contract_pk PRIMARY KEY (number_contract);

ALTER TABLE PaymentData ADD CONSTRAINT number_contract_fk FOREIGN KEY (number_contract) REFERENCES CreditContract (number_contract);
ALTER TABLE CreditContract ADD CONSTRAINT borrower_fk FOREIGN KEY (borrower) REFERENCES Users (identity_code);
ALTER TABLE CreditContract ADD CONSTRAINT maturity_fk FOREIGN KEY (maturity) REFERENCES Maturity (maturity_type);
ALTER TABLE CreditContract ADD CONSTRAINT credit_type_fk FOREIGN KEY (credit_type,quantity_months) REFERENCES CreditType (type_name,quantity_months);
