/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     26.12.2016 0:44:57                           */
/*==============================================================*/


alter table "instructor"
   drop constraint FK_INSTRUCT_IS_USER;

alter table "instructor"
   drop constraint FK_INSTRUCT_MANTAINS_ORDER;

alter table "jn_instructor_dive"
   drop constraint "FK_JN_INSTR_IS PROVID_DIVE";

alter table "jn_instructor_dive"
   drop constraint FK_JN_INSTR_PROVIDES_INSTRUCT;

alter table "order"
   drop constraint FK_ORDER_RELATIONS_INSTRUCT;

alter table "order"
   drop constraint FK_ORDER_MAKE_USER;

alter table "order"
   drop constraint FK_ORDER_SELECTED_JN_INSTR;

alter table "visiting history"
   drop constraint FK_VISITING_DO_USER;

drop table "dive" cascade constraints;

drop index "is_FK";

drop index "mantains_FK";

drop table "instructor" cascade constraints;

drop index "is provided_FK";

drop index "provides_FK";

drop table "jn_instructor_dive" cascade constraints;

drop index "make_FK";

drop index "Relationship_9_FK";

drop index "selected_FK";

drop table "order" cascade constraints;

drop table "user" cascade constraints;

drop index "do_FK";

drop table "visiting history" cascade constraints;

/*==============================================================*/
/* Table: "dive"                                                */
/*==============================================================*/
create table "dive" 
(
   "dive_code_pk"       varchar2(20)         not null,
   "dive_name"          varchar2(20)         not null,
   "dive_category"      Integer(2),
   "info"               varchar(100),
   constraint PK_DIVE primary key ("dive_code_pk")
);

/*==============================================================*/
/* Table: "instructor"                                          */
/*==============================================================*/
create table "instructor" 
(
   "user_login_pk3"     varchar2(20)         not null,
   "user_reg_date_pk3"  DATE                 not null,
   "user_login_pk2"     varchar2(20)         not null,
   "user_reg_date_pk2"  DATE                 not null,
   "order_id_pk"        Integer(20),
   "hiring_date"        DATE                 not null,
   "firing_date"        DATE,
   "prof_category"      enum,
   constraint PK_INSTRUCTOR primary key ("user_login_pk3", "user_reg_date_pk3")
);

/*==============================================================*/
/* Index: "mantains_FK"                                         */
/*==============================================================*/
create index "mantains_FK" on "instructor" (
   "order_id_pk" ASC
);

/*==============================================================*/
/* Index: "is_FK"                                               */
/*==============================================================*/
create index "is_FK" on "instructor" (
   "user_login_pk2" ASC,
   "user_reg_date_pk2" ASC
);

/*==============================================================*/
/* Table: "jn_instructor_dive"                                  */
/*==============================================================*/
create table "jn_instructor_dive" 
(
   "user_login_pk4"     varchar2(20)         not null,
   "user_reg_date_pk4"  DATE                 not null,
   "dive_code_pk2"      varchar2(20)         not null,
   "dive_code_pk"       varchar2(20)         not null,
   "user_login_pk3"     varchar2(20)         not null,
   "user_reg_date_pk3"  DATE                 not null,
   constraint PK_JN_INSTRUCTOR_DIVE primary key ("user_login_pk4", "user_reg_date_pk4", "dive_code_pk2")
);

/*==============================================================*/
/* Index: "provides_FK"                                         */
/*==============================================================*/
create index "provides_FK" on "jn_instructor_dive" (
   "user_login_pk3" ASC,
   "user_reg_date_pk3" ASC
);

/*==============================================================*/
/* Index: "is provided_FK"                                      */
/*==============================================================*/
create index "is provided_FK" on "jn_instructor_dive" (
   "dive_code_pk" ASC
);

/*==============================================================*/
/* Table: "order"                                               */
/*==============================================================*/
create table "order" 
(
   "order_id_pk"        Integer(20)          not null,
   "user_login_pk2"     varchar2(20)         not null,
   "user_reg_date_pk2"  DATE                 not null,
   "user_login_pk4"     varchar2(20)         not null,
   "user_reg_date_pk4"  DATE                 not null,
   "dive_code_pk2"      varchar2(20)         not null,
   "user_login_pk3"     varchar2(20),
   "user_reg_date_pk3"  DATE,
   "customer_name_fk"   varchar2(20)         not null,
   "customer_reg_datetime_fk" DATE                 not null,
   "instructor_login_fk" varchar2(20)         not null,
   "instructor_reg_datetime_fk" DATE                 not null,
   "dive_code_fk"       varchar2(20)         not null,
   "order_datetime"     DATE                 not null,
   "dive_date"          DATE                 not null,
   "comment"            varchar2(100),
   "status"             enum                 not null,
   constraint PK_ORDER primary key ("order_id_pk")
);

/*==============================================================*/
/* Index: "selected_FK"                                         */
/*==============================================================*/
create index "selected_FK" on "order" (
   "user_login_pk4" ASC,
   "user_reg_date_pk4" ASC,
   "dive_code_pk2" ASC
);

/*==============================================================*/
/* Index: "Relationship_9_FK"                                   */
/*==============================================================*/
create index "Relationship_9_FK" on "order" (
   "user_login_pk3" ASC,
   "user_reg_date_pk3" ASC
);

/*==============================================================*/
/* Index: "make_FK"                                             */
/*==============================================================*/
create index "make_FK" on "order" (
   "user_login_pk2" ASC,
   "user_reg_date_pk2" ASC
);

/*==============================================================*/
/* Table: "user"                                                */
/*==============================================================*/
create table "user" 
(
   "user_login_pk2"     varchar2(20)         not null,
   "user_reg_date_pk2"  DATE                 not null,
   "surname"            varchar2(40)         not null,
   "name"               varchar2(40)         not null,
   "telephone_num"      CHAR(14),
   "birthday"           DATE,
   "is_instructor"      SMALLINT,
   constraint PK_USER primary key ("user_login_pk2", "user_reg_date_pk2")
);

/*==============================================================*/
/* Table: "visiting history"                                    */
/*==============================================================*/
create table "visiting history" 
(
   "user_login_fk"      varchar2(20)         not null,
   "user_reg_datetime_fk" DATE                 not null,
   "login_datetime_pk"  DATE                 not null,
   "user_login_pk2"     varchar2(20)         not null,
   "user_reg_date_pk2"  DATE                 not null,
   "ip_adress"          varchar2(20),
   "logout_datetime"    DATE,
   constraint "PK_VISITING HISTORY" primary key ("user_login_fk", "login_datetime_pk", "user_reg_datetime_fk")
);

/*==============================================================*/
/* Index: "do_FK"                                               */
/*==============================================================*/
create index "do_FK" on "visiting history" (
   "user_login_pk2" ASC,
   "user_reg_date_pk2" ASC
);

alter table "instructor"
   add constraint FK_INSTRUCT_IS_USER foreign key ("user_login_pk2", "user_reg_date_pk2")
      references "user" ("user_login_pk2", "user_reg_date_pk2");

alter table "instructor"
   add constraint FK_INSTRUCT_MANTAINS_ORDER foreign key ("order_id_pk")
      references "order" ("order_id_pk");

alter table "jn_instructor_dive"
   add constraint "FK_JN_INSTR_IS PROVID_DIVE" foreign key ("dive_code_pk")
      references "dive" ("dive_code_pk");

alter table "jn_instructor_dive"
   add constraint FK_JN_INSTR_PROVIDES_INSTRUCT foreign key ("user_login_pk3", "user_reg_date_pk3")
      references "instructor" ("user_login_pk3", "user_reg_date_pk3");

alter table "order"
   add constraint FK_ORDER_RELATIONS_INSTRUCT foreign key ("user_login_pk3", "user_reg_date_pk3")
      references "instructor" ("user_login_pk3", "user_reg_date_pk3");

alter table "order"
   add constraint FK_ORDER_MAKE_USER foreign key ("user_login_pk2", "user_reg_date_pk2")
      references "user" ("user_login_pk2", "user_reg_date_pk2");

alter table "order"
   add constraint FK_ORDER_SELECTED_JN_INSTR foreign key ("user_login_pk4", "user_reg_date_pk4", "dive_code_pk2")
      references "jn_instructor_dive" ("user_login_pk4", "user_reg_date_pk4", "dive_code_pk2");

alter table "visiting history"
   add constraint FK_VISITING_DO_USER foreign key ("user_login_pk2", "user_reg_date_pk2")
      references "user" ("user_login_pk2", "user_reg_date_pk2");

