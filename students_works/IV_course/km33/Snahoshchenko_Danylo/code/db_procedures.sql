CREATE OR REPLACE PROCEDURE InsertQuestionAnswers
(qText IN char, answAtext IN char, answBtext IN char, 
answCtext IN char, answDtext IN char, answCorrect IN char)

IS
new_num number;

BEGIN
  select count(*)+1 into new_num from QUESTIONS;
  
  INSERT INTO QUESTIONS (QUEST_NUM,  QUEST_TEXT, QUEST_STATUS)
  VALUES (new_num , qText, 1);
  
  INSERT INTO ANSWERS (QUEST_NUM, ANSWER_VARIANT, ANSWER_TEXT, ANSWER_CORRECT, ANSWER_STATUS)
  VALUES (new_num , 'A', answAtext, 0, 1);
  
  INSERT INTO ANSWERS (QUEST_NUM, ANSWER_VARIANT, ANSWER_TEXT, ANSWER_CORRECT, ANSWER_STATUS)
  VALUES (new_num , 'B', answBtext, 0, 1);
  
  INSERT INTO ANSWERS (QUEST_NUM, ANSWER_VARIANT, ANSWER_TEXT, ANSWER_CORRECT, ANSWER_STATUS)
  VALUES (new_num , 'C', answCtext, 0, 1);
  
  INSERT INTO ANSWERS (QUEST_NUM, ANSWER_VARIANT, ANSWER_TEXT, ANSWER_CORRECT, ANSWER_STATUS)
  VALUES (new_num , 'D', answDtext, 0, 1);
  
  update ANSWERS
  set ANSWER_CORRECT = 1 
  where ANSWERS.QUEST_NUM = new_num and ANSWERS.ANSWER_VARIANT=answCorrect;
  
END InsertQuestionAnswers;


-----------------------------------------




-----------------------------------------

CREATE OR REPLACE PROCEDURE DeleteQuestion
(delNumber IN number)
is
BEGIN

  UPDATE Questions
  set Quest_status=0
  where Quest_num = delNumber-9;
  
END DeleteQuestion;

---------------------------------------------
CREATE OR REPLACE PROCEDURE EditQuestionAnswers
(qNum in number, qText IN char, answAtext IN char, answBtext IN char, 
answCtext IN char, answDtext IN char, answCorrect IN char)

IS


BEGIN
  update QUESTIONS
  set quest_text = qText
  where quest_num = qNum-9;
  
  update ANSWERS
  set answer_text = answAtext
  where quest_num = qNum-9 and answer_variant = 'A';
  update ANSWERS
  set answer_text = answBtext
  where quest_num = qNum-9 and answer_variant = 'B';
  update ANSWERS
  set answer_text = answCtext
  where quest_num = qNum-9 and answer_variant = 'C';
  update ANSWERS
  set answer_text = answDtext
  where quest_num = qNum-9 and answer_variant = 'D';
  update ANSWERS
  set answer_correct = 0
  where quest_num = qNum-9;
  update ANSWERS
  set answer_correct = 1
  where quest_num = qNum-9 and answer_variant = answCorrect;
  
  
END EditQuestionAnswers;
--------------------------------------------
CREATE OR REPLACE PROCEDURE newUser
(username IN char, surname IN char, email IN char, 
userpassword IN char)
IS
BEGIN
INSERT INTO ORGANISMS
(organism_box, organism_code, organism_title, organism_secondTitle, organism_god)
VALUES (email,userpassword,username, surname, 0);
END newUser;
--------------------------------------------
create or replace PROCEDURE newTest
(userbox IN char, testdate IN char, qnum IN number, truefalse IN number)
IS 
BEGIN

INSERT INTO tests
(organism_box,Test_date,QUEST_NUM,Test_answer)
VALUES (userbox,testdate, qnum-9, truefalse);
END newTest;

------------------------------------------
create or replace PROCEDURE newIQ
(userbox IN char, testdate IN char, iqlevel IN number)
IS 
BEGIN

INSERT INTO IQ
(organism_box,Test_date,iq_level)
VALUES (userbox,testdate, iqlevel);
END newIQ;
------------------------------------------


CREATE OR REPLACE TRIGGER "deleteAnswers"
AFTER UPDATE
  ON Questions
  FOR EACH ROW
BEGIN
  update ANSWERS
  set ANSWER_status = :new.Quest_status
  where ANSWERS.QUEST_NUM = :new.QUEST_NUM;
END;








