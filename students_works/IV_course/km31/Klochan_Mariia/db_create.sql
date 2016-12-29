CREATE TABLE "InterviewLines" (
"Number" NUMBER(10,0), 
"InterviewId" NUMBER(10,0), 
"Question" NVARCHAR2(2000), 
"Reply" NVARCHAR2(2000)
);

CREATE TABLE "Interviews" (
"Id" NUMBER(10,0), 
"AskerUsername" NVARCHAR2(128), 
"RespondentUsername" NVARCHAR2(128), 
"Status" NUMBER(10,0), 
"Title" NVARCHAR2(2000), 
"Preview" NVARCHAR2(2000)
);

CREATE TABLE "Users" (
"Username" NVARCHAR2(128), 
"Password" NVARCHAR2(40), 
"Email" NVARCHAR2(40), 
"FirstName" NVARCHAR2(40), 
"LastName" NVARCHAR2(40), 
"IsAsker" NUMBER(1,0), 
"IsRespondent" NUMBER(1,0), 
"IsEditor" NUMBER(1,0)
);

CREATE SEQUENCE  "SQ_Interviews" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
CREATE OR REPLACE TRIGGER "TR_Interviews"
BEFORE INSERT ON "Interviews"
FOR EACH ROW
BEGIN
  SELECT "SQ_Interviews".NEXTVAL INTO :new."Id" FROM dual;
END;
/

ALTER TABLE "InterviewLines" ADD CONSTRAINT "PK_InterviewLines" PRIMARY KEY ("Number", "InterviewId");
ALTER TABLE "InterviewLines" MODIFY ("InterviewId" NOT NULL);
ALTER TABLE "InterviewLines" MODIFY ("Number" NOT NULL);

ALTER TABLE "Interviews" ADD CONSTRAINT "PK_Interviews" PRIMARY KEY ("Id");
ALTER TABLE "Interviews" MODIFY ("Status" NOT NULL);
ALTER TABLE "Interviews" MODIFY ("Id" NOT NULL);

ALTER TABLE "Users" ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Username");
ALTER TABLE "Users" MODIFY ("IsEditor" NOT NULL);
ALTER TABLE "Users" MODIFY ("IsRespondent" NOT NULL);
ALTER TABLE "Users" MODIFY ("IsAsker" NOT NULL);
ALTER TABLE "Users" MODIFY ("Username" NOT NULL);

ALTER TABLE "InterviewLines" ADD CONSTRAINT "FK_InterviewLines_InterviewId" FOREIGN KEY ("InterviewId")
  REFERENCES "Interviews" ("Id") ON DELETE CASCADE;
ALTER TABLE "Interviews" ADD CONSTRAINT "FK_Interviews_AskerUsername" FOREIGN KEY ("AskerUsername")
  REFERENCES "Users" ("Username");
ALTER TABLE "Interviews" ADD CONSTRAINT "FK_Interviews_RespUsername" FOREIGN KEY ("RespondentUsername")
  REFERENCES "Users" ("Username");
