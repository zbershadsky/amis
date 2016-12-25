/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     26.12.2016 0:22:11                           */
/*==============================================================*/


alter table "Cards"
   drop constraint "FK_CARDS_HAS CARD_USER";

alter table "Payment"
   drop constraint "FK_PAYMENT_FILL PHON_USER_PHO";

alter table "Payment"
   drop constraint "FK_PAYMENT_PAY WITH_CARDS";

alter table "User_Phones"
   drop constraint "FK_USER_PHO_HAS PHONE_USER";

alter table "User_account_statuses"
   drop constraint "FK_USER_ACC_ACCOUNT H_USER";

alter table "User_account_statuses"
   drop constraint "FK_USER_ACC_ACCOUNTS _ACCOUNT";

drop table "Account statuses" cascade constraints;

drop index "has card_FK";

drop table "Cards" cascade constraints;

drop index "pay with_FK";

drop index "fill phone_FK";

drop table "Payment" cascade constraints;

drop table "User" cascade constraints;

drop index "has phone_FK";

drop table "User_Phones" cascade constraints;

drop index "account had statuses_FK";

drop index "accounts has statuses_FK";

drop table "User_account_statuses" cascade constraints;

/*==============================================================*/
/* Table: "Account statuses"                                    */
/*==============================================================*/
create table "Account statuses" 
(
   "status_name"        VARCHAR2(10)         not null,
   "status_description" CLOB,
   constraint "PK_ACCOUNT STATUSES" primary key ("status_name")
);

/*==============================================================*/
/* Table: "Cards"                                               */
/*==============================================================*/
create table "Cards" 
(
   "Card No."           VARCHAR2(16)         not null,
   "login"              VARCHAR2(30)         not null,
   "Token"              VARCHAR2(25)         not null,
   "Card name"          VARCHAR2(30),
   constraint PK_CARDS primary key ("Card No.")
);

/*==============================================================*/
/* Index: "has card_FK"                                         */
/*==============================================================*/
create index "has card_FK" on "Cards" (
   "login" ASC
);

/*==============================================================*/
/* Table: "Payment"                                             */
/*==============================================================*/
create table "Payment" 
(
   "payment_id"         INTEGER              not null,
   "Card No."           VARCHAR2(16)         not null,
   "login"              VARCHAR2(30)         not null,
   "phone_number"       VARCHAR2(10)         not null,
   "date"               TIMESTAMP            not null,
   "amount"             NUMBER(4,2)          not null,
   constraint PK_PAYMENT primary key ("payment_id")
);

/*==============================================================*/
/* Index: "fill phone_FK"                                       */
/*==============================================================*/
create index "fill phone_FK" on "Payment" (
   "login" ASC,
   "phone_number" ASC
);

/*==============================================================*/
/* Index: "pay with_FK"                                         */
/*==============================================================*/
create index "pay with_FK" on "Payment" (
   "Card No." ASC
);

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" 
(
   "login"              VARCHAR2(30)         not null,
   "email"              VARCHAR2(50)         not null,
   "hash"               VARCHAR2(60)         not null,
   "salt"               VARCHAR2(30)         not null,
   "user_role"          VARCHAR2(10),
   constraint PK_USER primary key ("login")
);

/*==============================================================*/
/* Table: "User_Phones"                                         */
/*==============================================================*/
create table "User_Phones" 
(
   "login"              VARCHAR2(30)         not null,
   "phone_number"       VARCHAR2(10)         not null,
   "phone_name"         VARCHAR2(40),
   constraint PK_USER_PHONES primary key ("login", "phone_number")
);

/*==============================================================*/
/* Index: "has phone_FK"                                        */
/*==============================================================*/
create index "has phone_FK" on "User_Phones" (
   "login" ASC
);

/*==============================================================*/
/* Table: "User_account_statuses"                               */
/*==============================================================*/
create table "User_account_statuses" 
(
   "status_name"        VARCHAR2(10)         not null,
   "login"              VARCHAR2(30)         not null,
   "date_of_status"     TIMESTAMP,
   constraint PK_USER_ACCOUNT_STATUSES primary key ("login", "status_name")
);

/*==============================================================*/
/* Index: "accounts has statuses_FK"                            */
/*==============================================================*/
create index "accounts has statuses_FK" on "User_account_statuses" (
   "status_name" ASC
);

/*==============================================================*/
/* Index: "account had statuses_FK"                             */
/*==============================================================*/
create index "account had statuses_FK" on "User_account_statuses" (
   "login" ASC
);

alter table "Cards"
   add constraint "FK_CARDS_HAS CARD_USER" foreign key ("login")
      references "User" ("login");

alter table "Payment"
   add constraint "FK_PAYMENT_FILL PHON_USER_PHO" foreign key ("login", "phone_number")
      references "User_Phones" ("login", "phone_number");

alter table "Payment"
   add constraint "FK_PAYMENT_PAY WITH_CARDS" foreign key ("Card No.")
      references "Cards" ("Card No.");

alter table "User_Phones"
   add constraint "FK_USER_PHO_HAS PHONE_USER" foreign key ("login")
      references "User" ("login");

alter table "User_account_statuses"
   add constraint "FK_USER_ACC_ACCOUNT H_USER" foreign key ("login")
      references "User" ("login");

alter table "User_account_statuses"
   add constraint "FK_USER_ACC_ACCOUNTS _ACCOUNT" foreign key ("status_name")
      references "Account statuses" ("status_name");

