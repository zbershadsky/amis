/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     22.12.2016 16:23:53                          */
/*==============================================================*/


ALTER TABLE "COMPARE"
   DROP CONSTRAINT FK_COMPARE_SAMPLE_CO_SAMPLE;

ALTER TABLE "COMPARE"
   DROP CONSTRAINT FK_COMPARE_WORK_COMP_WORK;

ALTER TABLE "USERS"
   DROP CONSTRAINT FK_USER_ROLE_USER_USER_TYP;

ALTER TABLE "WORK"
   DROP CONSTRAINT FK_WORK_USER_WORK_USER;

DROP INDEX "WORK_COMPARES_FK";

DROP INDEX "SAMPLE_COMPARES_FK";

DROP TABLE "COMPARE" CASCADE CONSTRAINTS;

DROP TABLE "SAMPLE" CASCADE CONSTRAINTS;

DROP INDEX "ROLE_USERS_FK";

DROP TABLE "USERS" CASCADE CONSTRAINTS;

DROP TABLE "USER_TYPE" CASCADE CONSTRAINTS;

DROP INDEX "USER_WORKS_FK";

DROP TABLE "WORK" CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: "COMPARE"                                             */
/*==============================================================*/
CREATE TABLE "COMPARE" 
(
   "RESULT"             SMALLINT             NOT NULL,
   "COMPARE_DATE"       TIMESTAMP            NOT NULL,
   "SAMPLE_DATE"        TIMESTAMP            NOT NULL,
   "WORK_DATE"          TIMESTAMP            NOT NULL,
   CONSTRAINT PK_COMPARE PRIMARY KEY ("COMPARE_DATE")
);

/*==============================================================*/
/* Index: "SAMPLE_COMPARES_FK"                                  */
/*==============================================================*/
CREATE INDEX "SAMPLE_COMPARES_FK" ON "COMPARE" (
   "SAMPLE_DATE" ASC
);

/*==============================================================*/
/* Index: "WORK_COMPARES_FK"                                    */
/*==============================================================*/
CREATE INDEX "WORK_COMPARES_FK" ON "COMPARE" (
   "WORK_DATE" ASC
);

/*==============================================================*/
/* Table: "SAMPLE"                                              */
/*==============================================================*/
CREATE TABLE "SAMPLE" 
(
   "SAMPLE_DATE"        TIMESTAMP            NOT NULL,
   "TITLE"              VARCHAR2(100)        NOT NULL,
   "FEATURES"           BLOB,
   CONSTRAINT PK_SAMPLE PRIMARY KEY ("SAMPLE_DATE")
);

/*==============================================================*/
/* Table: "USERS"                                                */
/*==============================================================*/
CREATE TABLE "USERS" 
(
   "EMAIL"              VARCHAR2(100)        NOT NULL,
   "TYPE"               VARCHAR2(100)        NOT NULL,
   "PASSWORD"           VARCHAR2(255)        NOT NULL,
   "NAME"               VARCHAR2(100),
   CONSTRAINT PK_USER PRIMARY KEY ("EMAIL")
);

/*==============================================================*/
/* Index: "ROLE_USERS_FK"                                       */
/*==============================================================*/
CREATE INDEX "ROLE_USERS_FK" ON "USERS" (
   "TYPE" ASC
);

/*==============================================================*/
/* Table: "USER_TYPE"                                           */
/*==============================================================*/
CREATE TABLE "USER_TYPE" 
(
   "TYPE"               VARCHAR2(100)        NOT NULL,
   CONSTRAINT PK_USER_TYPE PRIMARY KEY ("TYPE")
);

/*==============================================================*/
/* Table: "WORK"                                                */
/*==============================================================*/
CREATE TABLE "WORK" 
(
   "WORK_DATE"          TIMESTAMP            NOT NULL,
   "EMAIL"              VARCHAR2(100)        NOT NULL,
   "TEXT"               CLOB,
   CONSTRAINT PK_WORK PRIMARY KEY ("WORK_DATE")
);

/*==============================================================*/
/* Index: "USER_WORKS_FK"                                       */
/*==============================================================*/
CREATE INDEX "USER_WORKS_FK" ON "WORK" (
   "EMAIL" ASC
);

ALTER TABLE "COMPARE"
   ADD CONSTRAINT FK_COMPARE_SAMPLE_CO_SAMPLE FOREIGN KEY ("SAMPLE_DATE")
      REFERENCES "SAMPLE" ("SAMPLE_DATE");

ALTER TABLE "COMPARE"
   ADD CONSTRAINT FK_COMPARE_WORK_COMP_WORK FOREIGN KEY ("WORK_DATE")
      REFERENCES "WORK" ("WORK_DATE");

ALTER TABLE "USERS"
   ADD CONSTRAINT FK_USER_ROLE_USER_USER_TYP FOREIGN KEY ("TYPE")
      REFERENCES "USER_TYPE" ("TYPE");

ALTER TABLE "WORK"
   ADD CONSTRAINT FK_WORK_USER_WORK_USER FOREIGN KEY ("EMAIL")
      REFERENCES "USERS" ("EMAIL");

