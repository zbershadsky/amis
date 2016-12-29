/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     26.12.2016 4:40:00                           */
/*==============================================================*/


alter table "Session"
   drop constraint FK_SESSION_RELATIONS_USER;

alter table "connection_profile"
   drop constraint FK_CONNECTI_HAS_USER;

alter table "log_note"
   drop constraint FK_LOG_NOTE_RELATIONS_CONNECTI;

drop index "Relationship_2_FK";

drop table "Session" cascade constraints;

drop index "has_FK";

drop table "connection_profile" cascade constraints;

drop index "Relationship_3_FK";

drop table "log_note" cascade constraints;

drop table "user" cascade constraints;

/*==============================================================*/
/* Table: "Session"                                             */
/*==============================================================*/
create table "Session" 
(
   "session_id"         CHAR(250)            not null,
   "username"           CHAR(50),
   "expired_date"       DATE,
   "user_ip"            CHAR(50),
   "username_fk"        CHAR(50),
   "date_created"       DATE,
   constraint PK_SESSION primary key ("session_id")
);

/*==============================================================*/
/* Index: "Relationship_2_FK"                                   */
/*==============================================================*/
create index "Relationship_2_FK" on "Session" (
   "username" ASC
);

/*==============================================================*/
/* Table: "connection_profile"                                  */
/*==============================================================*/
create table "connection_profile" 
(
   "title"              CHAR(256)            not null,
   "connection_password" CHAR(100)            not null,
   "connection_user"    CHAR(100)            not null,
   "port"               CHAR(100)            not null,
   "host"               CHAR(256)            not null,
   "protocol"           CHAR(256),
   "date_modified"      DATE                 not null,
   "last_connection_date" DATE,
   "deleted"            SMALLINT             not null,
   "saved_by_user"      SMALLINT             not null,
   "username_fk"        CHAR(50)             not null,
   "created_date"       DATE                 not null,
   "username"           CHAR(50)             not null,
   constraint PK_CONNECTION_PROFILE primary key ("created_date", "title")
);

/*==============================================================*/
/* Index: "has_FK"                                              */
/*==============================================================*/
create index "has_FK" on "connection_profile" (
   "username" ASC
);

/*==============================================================*/
/* Table: "log_note"                                            */
/*==============================================================*/
create table "log_note" 
(
   "date"               DATE                 not null,
   "message"            CHAR(256)            not null,
   "connection_title_fk" CHAR(256)            not null,
   "created_date"       DATE                 not null,
   "title"              CHAR(256)            not null,
   "type"               CHAR(100),
   constraint PK_LOG_NOTE primary key ("connection_title_fk")
);

/*==============================================================*/
/* Index: "Relationship_3_FK"                                   */
/*==============================================================*/
create index "Relationship_3_FK" on "log_note" (
   "created_date" ASC,
   "title" ASC
);

/*==============================================================*/
/* Table: "user"                                                */
/*==============================================================*/
create table "user" 
(
   "username"           CHAR(50)             not null,
   "password"           CHAR(256)            not null,
   "email"              CHAR(50),
   "registration_date"  DATE                 not null,
   "last_login_date"    DATE,
   "role"               CHAR(256)            not null,
   constraint PK_USER primary key ("username")
);

alter table "Session"
   add constraint FK_SESSION_RELATIONS_USER foreign key ("username")
      references "user" ("username");

alter table "connection_profile"
   add constraint FK_CONNECTI_HAS_USER foreign key ("username")
      references "user" ("username");

alter table "log_note"
   add constraint FK_LOG_NOTE_RELATIONS_CONNECTI foreign key ("created_date", "title")
      references "connection_profile" ("created_date", "title");

