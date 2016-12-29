/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     25.12.2016 18:08:55                          */
/*==============================================================*/



-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger "CompoundDeleteTrigger_group"
/

drop trigger "CompoundInsertTrigger_group"
/

drop trigger "CompoundUpdateTrigger_group"
/

drop trigger "tdb_group"
/

drop trigger "tub_group"
/

drop trigger "CompoundDeleteTrigger_students"
/

drop trigger "CompoundInsertTrigger_students"
/

drop trigger "CompoundUpdateTrigger_students"
/

drop trigger "tib_students and groups"
/

drop trigger "tub_students and groups"
/

alter table "Result"
   drop constraint FK_RESULT_STUD_WORK_STUDENT
/

alter table "Result"
   drop constraint FK_RESULT_STUD_WORK_WORK
/

alter table "Students and groups"
   drop constraint FK_STUDENTS_STUD_GROU_STUDENT
/

alter table "Subjects, teachers and groups"
   drop constraint FK_SUBJECTS_REFERENCE_GROUP
/

alter table "Subjects, teachers and groups"
   drop constraint FK_SUBJECTS_REFERENCE_TEACHER
/

alter table "Subjects, teachers and groups"
   drop constraint FK_SUBJECTS_REFERENCE_SUBJECT
/

alter table "User status"
   drop constraint "FK_USER STA_USER HAS _USER"
/

alter table "User-role"
   drop constraint "FK_USER-ROL_REFERENCE_USER"
/

alter table "User-role"
   drop constraint "FK_USER-ROL_REFERENCE_ROLE"
/

alter table "User-student"
   drop constraint "FK_USER-STU_STUDENT I_STUDENT"
/

alter table "User-student"
   drop constraint "FK_USER-STU_STUDENT I_USER"
/

alter table "User-teacher"
   drop constraint "FK_USER-TEA_REFERENCE_USER"
/

alter table "User-teacher"
   drop constraint "FK_USER-TEA_REFERENCE_TEACHER"
/

alter table "Work"
   drop constraint FK_WORK_REFERENCE_SUBJECTS
/

drop table "Group" cascade constraints
/

drop index "student_FK3"
/

drop index "work_FK"
/

drop table "Result" cascade constraints
/

drop table "Role" cascade constraints
/

drop table "Student" cascade constraints
/

drop index "group_FK2"
/

drop index "student_FK2"
/

drop table "Students and groups" cascade constraints
/

drop table "Subject" cascade constraints
/

drop index "Teacher_FK2"
/

drop index "group_FK"
/

drop index "teach_subj_group_PK"
/

drop table "Subjects, teachers and groups" cascade constraints
/

drop table "Teacher" cascade constraints
/

drop table "User" cascade constraints
/

drop index "User has statusses_FK"
/

drop table "User status" cascade constraints
/

drop index "User-role_PK"
/

drop index "User_fk3"
/

drop index "role_FK"
/

drop table "User-role" cascade constraints
/

drop index "user_FK2"
/

drop table "User-student" cascade constraints
/

drop index "User-teacher_PK"
/

drop index "Teacher_FK"
/

drop index "User_FK"
/

drop table "User-teacher" cascade constraints
/

drop index "teach_subj_group_FK"
/

drop table "Work" cascade constraints
/

/*==============================================================*/
/* Table: "Group"                                               */
/*==============================================================*/
create table "Group" 
(
   "group_abbr"         VARCHAR2(10)         not null,
   "group_desc"         CLOB,
   "group_status"       VARCHAR2(10)         not null,
   constraint PK_GROUP primary key ("group_abbr")
)
/

/*==============================================================*/
/* Table: "Result"                                              */
/*==============================================================*/
create table "Result" 
(
   "subject_number"     VARCHAR2(10)         not null,
   "group_abbr"         VARCHAR2(10)         not null,
   "teacher_name"       VARCHAR2(100)        not null,
   "teacher_nwc"        VARCHAR2(10)         not null,
   "work_name"          VARCHAR2(30)         not null,
   "student_name"       VARCHAR2(100)        not null,
   "student_nsc"        VARCHAR2(10)         not null,
   "result_mark_value"  INTEGER,
   "result_report_body" BLOB,
   "result_status"      VARCHAR2(10)         not null,
   constraint PK_RESULT primary key ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name", "student_name", "student_nsc")
)
/

/*==============================================================*/
/* Index: "work_FK"                                             */
/*==============================================================*/
create index "work_FK" on "Result" (
   "subject_number" ASC,
   "group_abbr" ASC,
   "teacher_name" ASC,
   "teacher_nwc" ASC,
   "work_name" ASC
)
/

/*==============================================================*/
/* Index: "student_FK3"                                         */
/*==============================================================*/
create index "student_FK3" on "Result" (
   "student_name" ASC,
   "student_nsc" ASC
)
/

/*==============================================================*/
/* Table: "Role"                                                */
/*==============================================================*/
create table "Role" 
(
   "role_name"          VARCHAR2(10)         not null,
   "role_desc"          CLOB,
   constraint PK_ROLE primary key ("role_name")
)
/

/*==============================================================*/
/* Table: "Student"                                             */
/*==============================================================*/
create table "Student" 
(
   "student_name"       VARCHAR2(100)        not null,
   "student_nsc"        VARCHAR2(10)         not null,
   constraint PK_STUDENT primary key ("student_name", "student_nsc")
)
/

/*==============================================================*/
/* Table: "Students and groups"                                 */
/*==============================================================*/
create table "Students and groups" 
(
   "student_name"       VARCHAR2(100)        not null,
   "student_nsc"        VARCHAR2(10)         not null,
   "group_abbr"         VARCHAR2(10)         not null,
   constraint "PK_STUDENTS AND GROUPS" primary key ("student_name", "student_nsc", "group_abbr")
)
/

/*==============================================================*/
/* Index: "student_FK2"                                         */
/*==============================================================*/
create index "student_FK2" on "Students and groups" (
   "student_name" ASC,
   "student_nsc" ASC
)
/

/*==============================================================*/
/* Index: "group_FK2"                                           */
/*==============================================================*/
create index "group_FK2" on "Students and groups" (
   "group_abbr" ASC
)
/

/*==============================================================*/
/* Table: "Subject"                                             */
/*==============================================================*/
create table "Subject" 
(
   "subject_number"     VARCHAR2(10)         not null,
   "subject_name"       VARCHAR2(30)         not null,
   "subject_desc"       CLOB,
   "subject_status"     VARCHAR2(10)         not null,
   constraint PK_SUBJECT primary key ("subject_number")
)
/

/*==============================================================*/
/* Table: "Subjects, teachers and groups"                       */
/*==============================================================*/
create table "Subjects, teachers and groups" 
(
   "group_abbr"         VARCHAR2(10)         not null,
   "teacher_name"       VARCHAR2(100)        not null,
   "teacher_nwc"        VARCHAR2(10)         not null,
   "subject_number"     VARCHAR2(10)         not null,
   constraint "PK_SUBJECTS, TEACHERS AND GROU" primary key ("group_abbr", "teacher_name", "teacher_nwc", "subject_number")
)
/

/*==============================================================*/
/* Index: "teach_subj_group_PK"                                 */
/*==============================================================*/
create unique index "teach_subj_group_PK" on "Subjects, teachers and groups" (
   "group_abbr" ASC,
   "teacher_name" ASC,
   "teacher_nwc" ASC,
   "subject_number" ASC
)
/

/*==============================================================*/
/* Index: "group_FK"                                            */
/*==============================================================*/
create index "group_FK" on "Subjects, teachers and groups" (
   "group_abbr" ASC
)
/

/*==============================================================*/
/* Index: "Teacher_FK2"                                         */
/*==============================================================*/
create index "Teacher_FK2" on "Subjects, teachers and groups" (
   "teacher_name" ASC,
   "teacher_nwc" ASC
)
/

/*==============================================================*/
/* Table: "Teacher"                                             */
/*==============================================================*/
create table "Teacher" 
(
   "teacher_name"       VARCHAR2(100)        not null,
   "teacher_nwc"        VARCHAR2(10)         not null,
   constraint PK_TEACHER primary key ("teacher_name", "teacher_nwc")
)
/

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" 
(
   "user_login"         VARCHAR2(10)         not null,
   "user_pass"          VARCHAR2(50),
   "user_email"         VARCHAR2(30),
   constraint PK_USER primary key ("user_login")
)
/

/*==============================================================*/
/* Table: "User status"                                         */
/*==============================================================*/
create table "User status" 
(
   "user_login"         VARCHAR2(10)         not null,
   "user_status"        VARCHAR2(10)         not null,
   "user_stat_date"     DATE                 not null,
   "user_stat_desc"     CLOB,
   constraint "PK_USER STATUS" primary key ("user_login", "user_status", "user_stat_date")
)
/

/*==============================================================*/
/* Index: "User has statusses_FK"                               */
/*==============================================================*/
create index "User has statusses_FK" on "User status" (
   "user_login" ASC
)
/

/*==============================================================*/
/* Table: "User-role"                                           */
/*==============================================================*/
create table "User-role" 
(
   "user_login"         VARCHAR2(10)         not null,
   "role_name"          VARCHAR2(10)         not null,
   constraint "PK_USER-ROLE" primary key ("user_login", "role_name")
)
/

/*==============================================================*/
/* Index: "role_FK"                                             */
/*==============================================================*/
create unique index "role_FK" on "User-role" (
   "role_name" ASC
)
/

/*==============================================================*/
/* Index: "User_fk3"                                            */
/*==============================================================*/
create unique index "User_fk3" on "User-role" (
   "user_login" ASC
)
/

/*==============================================================*/
/* Index: "User-role_PK"                                        */
/*==============================================================*/
create unique index "User-role_PK" on "User-role" (
   "user_login" ASC,
   "role_name" ASC
)
/

/*==============================================================*/
/* Table: "User-student"                                        */
/*==============================================================*/
create table "User-student" 
(
   "user_login"         VARCHAR2(10)         not null,
   "student_name"       VARCHAR2(100)        not null,
   "student_nsc"        VARCHAR2(10)         not null,
   constraint "PK_USER-STUDENT" primary key ("user_login", "student_name", "student_nsc")
)
/

/*==============================================================*/
/* Index: "user_FK2"                                            */
/*==============================================================*/
create unique index "user_FK2" on "User-student" (
   "user_login" ASC
)
/

/*==============================================================*/
/* Table: "User-teacher"                                        */
/*==============================================================*/
create table "User-teacher" 
(
   "user_login"         VARCHAR2(10)         not null,
   "teacher_name"       VARCHAR2(100)        not null,
   "teacher_nwc"        VARCHAR2(10)         not null,
   constraint "PK_USER-TEACHER" primary key ("user_login", "teacher_name", "teacher_nwc")
)
/

/*==============================================================*/
/* Index: "User_FK"                                             */
/*==============================================================*/
create unique index "User_FK" on "User-teacher" (
   "user_login" ASC
)
/

/*==============================================================*/
/* Index: "Teacher_FK"                                          */
/*==============================================================*/
create unique index "Teacher_FK" on "User-teacher" (
   "teacher_name" ASC,
   "teacher_nwc" ASC
)
/

/*==============================================================*/
/* Index: "User-teacher_PK"                                     */
/*==============================================================*/
create unique index "User-teacher_PK" on "User-teacher" (
   "user_login" ASC,
   "teacher_name" ASC,
   "teacher_nwc" ASC
)
/

/*==============================================================*/
/* Table: "Work"                                                */
/*==============================================================*/
create table "Work" 
(
   "subject_number"     VARCHAR2(10)         not null,
   "group_abbr"         VARCHAR2(10)         not null,
   "teacher_name"       VARCHAR2(100)        not null,
   "teacher_nwc"        VARCHAR2(10)         not null,
   "work_name"          VARCHAR2(30)         not null,
   "work_desc"          CLOB,
   "work_body"          BLOB,
   "work_status"        VARCHAR2(10)         not null,
   constraint PK_WORK primary key ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name")
)
/

/*==============================================================*/
/* Index: "teach_subj_group_FK"                                 */
/*==============================================================*/
create index "teach_subj_group_FK" on "Work" (
   "subject_number" ASC,
   "group_abbr" ASC,
   "teacher_name" ASC,
   "teacher_nwc" ASC
)
/

alter table "Result"
   add constraint FK_RESULT_STUD_WORK_STUDENT foreign key ("student_name", "student_nsc")
      references "Student" ("student_name", "student_nsc")
/

alter table "Result"
   add constraint FK_RESULT_STUD_WORK_WORK foreign key ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name")
      references "Work" ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name")
/

alter table "Students and groups"
   add constraint FK_STUDENTS_STUD_GROU_STUDENT foreign key ("student_name", "student_nsc")
      references "Student" ("student_name", "student_nsc")
/

alter table "Subjects, teachers and groups"
   add constraint FK_SUBJECTS_REFERENCE_GROUP foreign key ("group_abbr")
      references "Group" ("group_abbr")
/

alter table "Subjects, teachers and groups"
   add constraint FK_SUBJECTS_REFERENCE_TEACHER foreign key ("teacher_name", "teacher_nwc")
      references "Teacher" ("teacher_name", "teacher_nwc")
/

alter table "Subjects, teachers and groups"
   add constraint FK_SUBJECTS_REFERENCE_SUBJECT foreign key ("subject_number")
      references "Subject" ("subject_number")
/

alter table "User status"
   add constraint "FK_USER STA_USER HAS _USER" foreign key ("user_login")
      references "User" ("user_login")
/

alter table "User-role"
   add constraint "FK_USER-ROL_REFERENCE_USER" foreign key ("user_login")
      references "User" ("user_login")
/

alter table "User-role"
   add constraint "FK_USER-ROL_REFERENCE_ROLE" foreign key ("role_name")
      references "Role" ("role_name")
/

alter table "User-student"
   add constraint "FK_USER-STU_STUDENT I_STUDENT" foreign key ("student_name", "student_nsc")
      references "Student" ("student_name", "student_nsc")
/

alter table "User-student"
   add constraint "FK_USER-STU_STUDENT I_USER" foreign key ("user_login")
      references "User" ("user_login")
/

alter table "User-teacher"
   add constraint "FK_USER-TEA_REFERENCE_USER" foreign key ("user_login")
      references "User" ("user_login")
/

alter table "User-teacher"
   add constraint "FK_USER-TEA_REFERENCE_TEACHER" foreign key ("teacher_name", "teacher_nwc")
      references "Teacher" ("teacher_name", "teacher_nwc")
/

alter table "Work"
   add constraint FK_WORK_REFERENCE_SUBJECTS foreign key ("group_abbr", "teacher_name", "teacher_nwc", "subject_number")
      references "Subjects, teachers and groups" ("group_abbr", "teacher_name", "teacher_nwc", "subject_number")
/


create or replace trigger "CompoundDeleteTrigger_group"
for delete on "Group" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_group"
for insert on "Group" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_group"
for update on "Group" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tdb_group" before delete
on "Group" for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of DeleteParentRestrict constraint for ""Students and groups""
    cursor cfk1_"students and groups"(var_"group_abbr" varchar) is
       select 1
       from   "Students and groups"
       where  "group_abbr" = var_"group_abbr"
        and   var_"group_abbr" is not null;

begin
    --  Cannot delete parent ""Group"" if children still exist in ""Students and groups""
    open  cfk1_"students and groups"(:old."group_abbr");
    fetch cfk1_"students and groups" into dummy;
    found := cfk1_"students and groups"%FOUND;
    close cfk1_"students and groups";
    if found then
       errno  := -20006;
       errmsg := 'Children still exist in ""Students and groups"". Cannot delete parent ""Group"".';
       raise integrity_error;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger "tub_group" before update
of "group_abbr"
on "Group" for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of UpdateParentRestrict constraint for ""Students and groups""
    cursor cfk1_"students and groups"(var_"group_abbr" varchar) is
       select 1
       from   "Students and groups"
       where  "group_abbr" = var_"group_abbr"
        and   var_"group_abbr" is not null;

begin
    --  Cannot modify parent code in ""Group"" if children still exist in ""Students and groups""
    if (updating('group_abbr') and :old."group_abbr" != :new."group_abbr") then
       open  cfk1_"students and groups"(:old."group_abbr");
       fetch cfk1_"students and groups" into dummy;
       found := cfk1_"students and groups"%FOUND;
       close cfk1_"students and groups";
       if found then
          errno  := -20005;
          errmsg := 'Children still exist in ""Students and groups"". Cannot modify parent code in ""Group"".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_students"
for delete on "Students and groups" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_students"
for insert on "Students and groups" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_students"
for update on "Students and groups" compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_students and groups" before insert
on "Students and groups" for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    --  Declaration of InsertChildParentExist constraint for the parent ""Group""
    cursor cpk2_"students and groups"(var_"group_abbr" varchar) is
       select 1
       from   "Group"
       where  "group_abbr" = var_"group_abbr"
        and   var_"group_abbr" is not null;

begin
    --  Parent ""Group"" must exist when inserting a child in ""Students and groups""
    if :new."group_abbr" is not null then
       open  cpk2_"students and groups"(:new."group_abbr");
       fetch cpk2_"students and groups" into dummy;
       found := cpk2_"students and groups"%FOUND;
       close cpk2_"students and groups";
       if not found then
          errno  := -20002;
          errmsg := 'Parent does not exist in ""Group"". Cannot create child in ""Students and groups"".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger "tub_students and groups" before update
of "student_name",
   "student_nsc",
   "group_abbr"
on "Students and groups" for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;
    --  Declaration of UpdateChildParentExist constraint for the parent ""Group""
    cursor cpk2_"students and groups"(var_"group_abbr" varchar) is
       select 1
       from   "Group"
       where  "group_abbr" = var_"group_abbr"
        and   var_"group_abbr" is not null;

begin
    seq := IntegrityPackage.GetNestLevel;
    --  Parent ""Group"" must exist when updating a child in ""Students and groups""
    if (:new."group_abbr" is not null) and (seq = 0) then
       open  cpk2_"students and groups"(:new."group_abbr");
       fetch cpk2_"students and groups" into dummy;
       found := cpk2_"students and groups"%FOUND;
       close cpk2_"students and groups";
       if not found then
          errno  := -20003;
          errmsg := 'Parent does not exist in ""Group"". Cannot update child in ""Students and groups"".';
          raise integrity_error;
       end if;
    end if;


--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

