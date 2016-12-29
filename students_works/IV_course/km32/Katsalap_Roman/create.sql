/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     25.12.2016 23:22:11                           */
/*==============================================================*/


alter table Cards
   drop constraint "FK_CARDS_HAS CARD_USER";

alter table Payment
   drop constraint "FK_PAYMENT_FILL PHON_USER_PHO";

alter table Payment
   drop constraint "FK_PAYMENT_PAY WITH_CARDS";

alter table User_Phones
   drop constraint "FK_USER_PHO_HAS PHONE_USER";

alter table User_account_statuses
   drop constraint "FK_USER_ACC_ACCOUNT H_USER";

alter table User_account_statuses
   drop constraint "FK_USER_ACC_ACCOUNTS _ACCOUNT";

drop table Account_statuses cascade constraints;

drop index has_card_FK;

drop table Cards cascade constraints;

drop index pay_with_FK;

drop index fill_phone_FK;

drop table Payment cascade constraints;

drop table USERS cascade constraints;

drop index has_phone_FK;

drop table User_Phones cascade constraints;

drop index account_had_statuses_FK;

drop index accounts has statuses_FK;

drop table User_account_statuses cascade constraints;

/*==============================================================*/
/* Table: "Account statuses"                                    */
/*==============================================================*/
create table Account_statuses 
(
   status_name      VARCHAR2(12)         not null,
   status_description    CLOB,
   constraint "PK_ACCOUNT STATUSES" primary key ("status_name")
);

/*==============================================================*/
/* Table: "Cards"                                               */
/*==============================================================*/
create table Cards
(
   CardNo         VARCHAR2(16)         not null,
   login              VARCHAR2(30)         not null,
   Token              VARCHAR2(25)         not null,
   CardName          VARCHAR2(30),
   constraint PK_CARDS primary key ("CardNo")
);

/*==============================================================*/
/* Index: "has card_FK"                                         */
/*==============================================================*/
create index has_card_FK on Cards (
   login ASC
);

/*==============================================================*/
/* Table: "Payment"                                             */
/*==============================================================*/
create table "Payment" 
(
   payment_id         INTEGER              not null	AUTO_INCREMENT,
   CardNo           VARCHAR2(16)         not null,
   login             VARCHAR2(30)         not null,
   phone_number       VARCHAR2(10)         not null,
   paydate             TIMESTAMP            not null,
   amount             NUMBER(4,2)          not null,
   constraint PK_PAYMENT primary key (payment_id)
);

/*==============================================================*/
/* Index: "fill phone_FK"                                       */
/*==============================================================*/
create index fill_phone_FK on Payment (
   login ASC,
   phone_number ASC
);

/*==============================================================*/
/* Index: "pay with_FK"                                         */
/*==============================================================*/
create index pay_with_FK on Payment (
   CardNo ASC
);

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table USERS
(
   login              VARCHAR2(30)         not null,
   email              VARCHAR2(50)         not null,
   hash               VARCHAR2(60)         not null,
   salt              VARCHAR2(30)         not null,
   user_role          VARCHAR2(15),
   constraint PK_USER primary key (login)
);

/*==============================================================*/
/* Table: "User_Phones"                                         */
/*==============================================================*/
create table User_Phones 
(
   login              VARCHAR2(30)         not null,
   phone_number       VARCHAR2(10)         not null,
   phone_name         VARCHAR2(40),
   constraint PK_USER_PHONES primary key (login, phone_number)
);

/*==============================================================*/
/* Index: "has phone_FK"                                        */
/*==============================================================*/
create index has_phone_FK on User_Phones (
   login ASC
);

/*==============================================================*/
/* Table: "User_account_statuses"                               */
/*==============================================================*/
create table User_account_statuses 
(
   status_name       VARCHAR2(12)         not null,
   login              VARCHAR2(30)         not null,
   date_of_status     TIMESTAMP,
   constraint PK_USER_ACCOUNT_STATUSES primary key (login, status_name)
);

/*==============================================================*/
/* Index: "accounts has statuses_FK"                            */
/*==============================================================*/
create index accounts_has_statuses_FK on User_account_statuses (
   status_name ASC
);

/*==============================================================*/
/* Index: "account had statuses_FK"                             */
/*==============================================================*/
create index account_had_statuses_FK on User_account_statuses (
   login ASC
);

alter table Cards
   add constraint FK_CARDS_HAS_CARD_USER foreign key (login)
      references Users (login);

alter table Payment
   add constraint "FK_PAYMENT_FILL PHON_USER_PHO" foreign key (login, phone_number)
      references User_Phones (login, phone_number);

alter table Payment
   add constraint "FK_PAYMENT_PAY WITH_CARDS" foreign key (CardNo)
      references Cards (CardNo);

alter table User_Phones
   add constraint "FK_USER_PHO_HAS PHONE_USER" foreign key (login)
      references Usesr (login);

alter table User_account_statuses
   add constraint "FK_USER_ACC_ACCOUNT H_USER" foreign key (login)
      references Users (login);

alter table User_account_statuses
   add constraint "FK_USER_ACC_ACCOUNTS _ACCOUNT" foreign key (status_name)
      references Account_statuses (status_name);


/*VIEW*/

CREATE VIEW CARDSPAYMENTS
AS SELECT P.payment_id payment_ID,
P.paydate PAYDATE,
P.amount AMOUNT,
P.phone_number PHONE_NUMBER,
P.CardNo CARDNO,
C.Token TOKEN,
C.CardName CARDNAME,
C.login LOGIN FROM Payment P JOIN Cards  C ON P.CardNo = C.CardNo;
