
	--------------------------------------------------------
	--  DDL for Table COLLOQUIUM
	--------------------------------------------------------

	  CREATE TABLE "COLLOQUIUM" 
	   (	"COLLOQUIUMNAME" VARCHAR2(20 BYTE), 
		"AUTHOR" VARCHAR2(20 BYTE)
	   );


	--------------------------------------------------------
	--  DDL for Table LECTURERS
	--------------------------------------------------------

	  CREATE TABLE "LECTURERS" 
	   (	"LOGIN" VARCHAR2(20 BYTE), 
		"PASSWORD" VARCHAR2(32 BYTE), 
		"EMAIL" VARCHAR2(20 BYTE), 
		"NAME" VARCHAR2(20 BYTE), 
		"SURNAME" VARCHAR2(20 BYTE)
	   ) ;


	--------------------------------------------------------
	--  DDL for Table STUDENTANSWER
	--------------------------------------------------------

	  CREATE TABLE "STUDENTANSWER" 
	   (	"TASKNAME" VARCHAR2(20 BYTE), 
		"AUTHOR" VARCHAR2(20 BYTE), 
		"COLLOQUIUMNAME" VARCHAR2(20 BYTE), 
		"ANSWER" VARCHAR2(20 BYTE), 
		"MARK" NUMBER, 
		"LECTURER" VARCHAR2(20 BYTE)
	   );


	--------------------------------------------------------
	--  DDL for Table STUDENTS
	--------------------------------------------------------

	  CREATE TABLE "STUDENTS" 
	   (	"LOGIN" VARCHAR2(20 BYTE), 
		"PASSWORD" VARCHAR2(32 BYTE), 
		"EMAIL" VARCHAR2(20 BYTE), 
		"NAME" VARCHAR2(20 BYTE), 
		"SURNAME" VARCHAR2(20 BYTE)
	   );


	--------------------------------------------------------
	--  DDL for Table TASK
	--------------------------------------------------------

	  CREATE TABLE "TASK" 
	   (	"TASKNAME" VARCHAR2(20 BYTE), 
		"QUESTION" VARCHAR2(20 BYTE), 
		"CORRECTANSWER" VARCHAR2(20 BYTE), 
		"AUTHOR" VARCHAR2(20 BYTE)
	   );


	--------------------------------------------------------
	--  DDL for Table COLLOQUIUMTASKLIST
	--------------------------------------------------------

	  CREATE TABLE "COLLOQUIUMTASKLIST" 
	   (	"AUTHOR" VARCHAR2(20 BYTE), 
		"COLLOQUIUMNAME" VARCHAR2(20 BYTE), 
		"TASKNAME" VARCHAR2(20 BYTE)
	   );

	  
	  --------------------------------------------------------
	--  Constraints for Table COLLOQUIUM
	--------------------------------------------------------

	  ALTER table colloquium add constraint colloquium_pk primary key (colloquiumname, author);

	--------------------------------------------------------
	--  Constraints for Table TASK
	--------------------------------------------------------

	  ALTER TABLE TASK ADD CONSTRAINT TASK_PK PRIMARY KEY (TASKNAME, AUTHOR);

		  
		  --------------------------------------------------------
	--  Constraints for Table LECTURERS
	--------------------------------------------------------

	  ALTER TABLE "LECTURERS" ADD CONSTRAINT "LEC_PK" PRIMARY KEY ("LOGIN");

	  --------------------------------------------------------
	--  Constraints for Table STUDENTANSWER
	--------------------------------------------------------

	  ALTER TABLE "STUDENTANSWER" ADD CONSTRAINT "STUDENTANSWER_PK" PRIMARY KEY ("TASKNAME", "AUTHOR", "COLLOQUIUMNAME", "LECTURER");
	  
	  --------------------------------------------------------
	--  Constraints for Table STUDENTS
	--------------------------------------------------------

	  ALTER TABLE "STUDENTS" ADD CONSTRAINT "ST_PK" PRIMARY KEY ("LOGIN");
	  
	  --------------------------------------------------------
	--  Ref Constraints for Table TASK
	--------------------------------------------------------

	  ALTER TABLE "TASK" ADD CONSTRAINT "TASK_LECTURERS_FK1" FOREIGN KEY ("AUTHOR")
		  REFERENCES "LECTURERS" ("LOGIN");
	  --------------------------------------------------------
	--  Ref Constraints for Table STUDENTANSWER
	--------------------------------------------------------

	  ALTER TABLE "STUDENTANSWER" ADD CONSTRAINT "STUDENTANSWER_COLLOQUIUM_FK1" FOREIGN KEY ("COLLOQUIUMNAME", "LECTURER")
		  REFERENCES "COLLOQUIUM" ("COLLOQUIUMNAME", "AUTHOR");
	 
	  ALTER TABLE "STUDENTANSWER" ADD CONSTRAINT "STUDENTANSWER_TASK_FK1" FOREIGN KEY ("TASKNAME", "LECTURER")
		  REFERENCES "TASK" ("TASKNAME", "AUTHOR");

		  --------------------------------------------------------
	--  Ref Constraints for Table COLLOQUIUMTASKLIST
	--------------------------------------------------------

	  ALTER TABLE "COLLOQUIUMTASKLIST" ADD CONSTRAINT "COLLOQUIUMTASKLIST_COLLOQ_FK1" FOREIGN KEY ("COLLOQUIUMNAME", "AUTHOR")
		  REFERENCES "COLLOQUIUM" ("COLLOQUIUMNAME", "AUTHOR");
	 
	  ALTER TABLE "COLLOQUIUMTASKLIST" ADD CONSTRAINT "COLLOQUIUMTASKLIST_TASK_FK1" FOREIGN KEY ("TASKNAME", "AUTHOR")
		  REFERENCES "TASK" ("TASKNAME", "AUTHOR");
		  
create view colloquium_view as 
select * from colloquium;
create view colloquiumtasklist_view as 
select * from colloquiumtasklist;
create view lec_view as 
select Login, password from lecturers;
create view stud_view as 
select Login, password from students;
create view studentanswer_view as 
select * from studentanswer;
create view task_view as 
select * from task;
