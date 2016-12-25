create or replace TRIGGER InsertNewUser
BEFORE INSERT
  ON USERS
  FOR EACH ROW
DECLARE
  idCode VARCHAR2(4000);
BEGIN
  :new.USER_PASSWORD := md5_digest(:new.USER_PASSWORD);
  ENCRYPTSTRING(:new.IDENTITY_CODE,idCode);
  :new.IDENTITY_CODE := idCode;
END;

COMMIT;

create or replace trigger number_contract_trg
before insert on Creditcontract
for each row
begin
  if :new.number_contract is null then
    select contract_seq.nextval into :new.number_contract from dual;
  end if;
  :new.status := 'active';
end;

COMMIT;