INSERT INTO "Users" ("Username","Password","Email","FirstName","LastName","IsAsker","IsRespondent","IsEditor") VALUES ('respondent','qwe','user2@gmail.com','Mr','Respondent',0,1,0);
INSERT INTO "Users" ("Username","Password","Email","FirstName","LastName","IsAsker","IsRespondent","IsEditor") VALUES ('editor','qwe','user3@gmail.com','Mr','Editor',0,0,1);
INSERT INTO "Users" ("Username","Password","Email","FirstName","LastName","IsAsker","IsRespondent","IsEditor") VALUES ('asker','qwe','user1@gmail.com','Mr','Asker',1,0,0);
INSERT INTO "Users" ("Username","Password","Email","FirstName","LastName","IsAsker","IsRespondent","IsEditor") VALUES ('user','qwe',NULL,'Mr','User',0,0,0);

INSERT INTO "Interviews" ("Id","AskerUsername","RespondentUsername","Status","Title","Preview") VALUES (1,'asker','respondent',1,'Example 1','Some info');
INSERT INTO "Interviews" ("Id","AskerUsername","RespondentUsername","Status","Title","Preview") VALUES (2,'asker',NULL,0,'Saved one','Lorem Ipsum');
INSERT INTO "Interviews" ("Id","AskerUsername","RespondentUsername","Status","Title","Preview") VALUES (3,'asker','respondent',3,'Published','Lorem Ipsum');

INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (1,1,'Q1',NULL);
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (2,1,'Q2',NULL);
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (3,1,'Q3',NULL);
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (1,2,'Q',NULL);
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (1,3,'Q1?','R1');
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (2,3,'Q2?','R2');
INSERT INTO "InterviewLines" ("Number","InterviewId","Question","Reply") VALUES (3,3,'Q3?','R3');