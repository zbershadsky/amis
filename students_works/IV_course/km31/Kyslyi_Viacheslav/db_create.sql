
drop trigger "tib_users"
/

alter table COMMENTS
   drop constraint FK_COMMENTS_REFERENCE_USERS
/

alter table SEARCH_QUERY
   drop constraint FK_SEARCH_Q_REFERENCE_USERS
/

drop index "Login_Idx"
/

drop index "ID_idx"
/

drop table USERS cascade constraints
/

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS 
(
   ID                   NUMBER(8)            not null,
   "Login"              CHAR VARYING(60)     not null,
   "Pass"               CHAR VARYING(256)    not null,
   "Email"              CHAR VARYING(256)    not null,
   "First_Name"         CHAR VARYING(60),
   "Last_Name"          CHAR VARYING(60),
   constraint PK_USERS primary key (ID),
   constraint AK_KEY_2_USERS unique ("Login")
)
/

/*==============================================================*/
/* Index: "ID_idx"                                              */
/*==============================================================*/
create index "ID_idx" on USERS (
   ID ASC
)
/

/*==============================================================*/
/* Index: "Login_Idx"                                           */
/*==============================================================*/
create unique index "Login_Idx" on USERS (
   "Login" ASC
)
/


create trigger "tib_users" before insert
on USERS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    max_found        integer;

begin
    select max(USERS.ID) into max_found from USERS; 
    
    if max_found is not null then
      begin
        :new.ID := max_found + 1;
      end;
    else 
      begin 
        :new.ID := 1;
      end;
    end if;

exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

drop trigger "tib_restaurants"
/

alter table MENUS
   drop constraint FK_MENUS_REFERENCE_RESTAURA
/

alter table RESTAURANT_RESULT
   drop constraint FK_RESTAURA_REFERENCE_RESTAURA
/

drop index "Res_Name_Idx"
/

drop index "Rest_ID_idx"
/

drop table RESTAURANTS cascade constraints
/

/*==============================================================*/
/* Table: RESTAURANTS                                           */
/*==============================================================*/
create table RESTAURANTS 
(
   ID                   NUMBER(8)            not null,
   "Name"               CHARACTER VARYING(256) not null,
   "Description"        CHAR VARYING(1024),
   "Address"            CHAR VARYING(1024),
   constraint PK_RESTAURANTS primary key (ID),
   constraint AK_KEY_2_RESTAURA unique ("Name")
)
/

/*==============================================================*/
/* Index: "Rest_ID_idx"                                         */
/*==============================================================*/
create index "Rest_ID_idx" on RESTAURANTS (
   ID ASC
)
/

/*==============================================================*/
/* Index: "Res_Name_Idx"                                        */
/*==============================================================*/
create unique index "Res_Name_Idx" on RESTAURANTS (
   "Name" ASC
)
/

create trigger "tib_restaurants" before insert
on RESTAURANTS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    max_found        integer;

begin
    select max(RESTAURANTS.ID) into max_found from RESTAURANTS; 
    
    if max_found is not null then
      begin
        :new.ID := max_found + 1;
      end;
    else 
      begin 
        :new.ID := 1;
      end;
    end if;

exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

drop trigger "tib_menus"
/

alter table MEALS
   drop constraint FK_MEALS_REFERENCE_MENUS
/

alter table MENUS
   drop constraint FK_MENUS_REFERENCE_RESTAURA
/

drop index "Menu_ID_Idx"
/

drop table MENUS cascade constraints
/

/*==============================================================*/
/* Table: MENUS                                                 */
/*==============================================================*/
create table MENUS 
(
   ID                   NUMBER(8)            not null,
   REST_ID              NUMBER(8)            not null,
   "Name"               CHARACTER VARYING(60),
   "Description"        CHAR VARYING(1024),
   constraint PK_MENUS primary key (ID)
)
/

/*==============================================================*/
/* Index: "Menu_ID_Idx"                                         */
/*==============================================================*/
create unique index "Menu_ID_Idx" on MENUS (
   ID ASC
)
/

alter table MENUS
   add constraint FK_MENUS_REFERENCE_RESTAURA foreign key (REST_ID)
      references RESTAURANTS (ID)
/


create trigger "tib_menus" before insert
on MENUS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    max_found        integer;

begin
    select max(MENUS.ID) into max_found from MENUS; 
    
    if max_found is not null then
      begin
        :new.ID := max_found + 1;
      end;
    else 
      begin 
        :new.ID := 1;
      end;
    end if;

exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

drop trigger "tib_meals"
/

alter table COMMENTS
   drop constraint FK_COMMENTS_REFERENCE_MEALS
/

alter table MEALS
   drop constraint FK_MEALS_REFERENCE_MENUS
/

alter table MEAL_RESULT
   drop constraint FK_MEAL_RES_REFERENCE_MEALS
/

drop index "MEALS_ID_Idx"
/

drop table MEALS cascade constraints
/

/*==============================================================*/
/* Table: MEALS                                                 */
/*==============================================================*/
create table MEALS 
(
   ID                   NUMBER(8)            not null,
   MENU_ID              NUMBER(8)            not null,
   "Name"               CHAR VARYING(60)     not null,
   "Description"        CHAR VARYING(60),
   "Price"              FLOAT,
   constraint PK_MEALS primary key (ID),
   constraint AK_KEY_2_MEALS unique (MENU_ID, "Name")
)
/

/*==============================================================*/
/* Index: "MEALS_ID_Idx"                                        */
/*==============================================================*/
create unique index "MEALS_ID_Idx" on MEALS (
   ID ASC
)
/

alter table MEALS
   add constraint FK_MEALS_REFERENCE_MENUS foreign key (MENU_ID)
      references MENUS (ID)
/

create trigger "tib_meals" before insert
on MEALS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    max_found        integer;

begin
    select max(MEALS.ID) into max_found from MEALS; 
    
    if max_found is not null then
      begin
        :new.ID := max_found + 1;
      end;
    else 
      begin 
        :new.ID := 1;
      end;
    end if;

exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


alter table COMMENTS
   drop constraint FK_COMMENTS_REFERENCE_USERS;

alter table COMMENTS
   drop constraint FK_COMMENTS_REFERENCE_MEALS;

drop table COMMENTS cascade constraints;

/*==============================================================*/
/* Table: COMMENTS                                              */
/*==============================================================*/
create table COMMENTS 
(
   USER_ID              NUMBER(8)            not null,
   MEAL_ID              NUMBER(8)            not null,
   "Date"               DATE                 not null,
   "Comment"            CHAR VARYING(1024),
   constraint PK_COMMENTS primary key (USER_ID, "Date", MEAL_ID),
   constraint AK_KEY_1_COMMENTS unique ()
);

alter table COMMENTS
   add constraint FK_COMMENTS_REFERENCE_USERS foreign key (USER_ID)
      references USERS (ID);

alter table COMMENTS
   add constraint FK_COMMENTS_REFERENCE_MEALS foreign key (MEAL_ID)
      references MEALS (ID);

drop trigger "tib_search_query"
/

alter table MEAL_RESULT
   drop constraint FK_MEAL_RES_REFERENCE_SEARCH_Q
/

alter table RESTAURANT_RESULT
   drop constraint FK_RESTAURA_REFERENCE_SEARCH_Q
/

alter table SEARCH_QUERY
   drop constraint FK_SEARCH_Q_REFERENCE_USERS
/

drop index "Query_ID_Idx"
/

drop table SEARCH_QUERY cascade constraints
/

/*==============================================================*/
/* Table: SEARCH_QUERY                                          */
/*==============================================================*/
create table SEARCH_QUERY 
(
   ID                   NUMBER(8)            not null,
   USER_ID              NUMBER(8),
   "Query"              CHAR VARYING(1024),
   "Date"               DATE,
   constraint PK_SEARCH_QUERY primary key (ID)
)
/

/*==============================================================*/
/* Index: "Query_ID_Idx"                                        */
/*==============================================================*/
create unique index "Query_ID_Idx" on SEARCH_QUERY (
   ID ASC
)
/

alter table SEARCH_QUERY
   add constraint FK_SEARCH_Q_REFERENCE_USERS foreign key (USER_ID)
      references USERS (ID)
/


create trigger "tib_search_query" before insert
on SEARCH_QUERY for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    max_found        integer;

begin
    select max(SEARCH_QUERY.ID) into max_found from SEARCH_QUERY; 
    
    if max_found is not null then
      begin
        :new.ID := max_found + 1;
      end;
    else 
      begin 
        :new.ID := 1;
      end;
    end if;
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

alter table MEAL_RESULT
   drop constraint FK_MEAL_RES_REFERENCE_SEARCH_Q;

alter table MEAL_RESULT
   drop constraint FK_MEAL_RES_REFERENCE_MEALS;

drop table MEAL_RESULT cascade constraints;

/*==============================================================*/
/* Table: MEAL_RESULT                                           */
/*==============================================================*/
create table MEAL_RESULT 
(
   QUERY_ID             NUMBER(8)            not null,
   MEAL_ID              NUMBER(8)            not null,
   constraint PK_MEAL_RESULT primary key (QUERY_ID, MEAL_ID)
);

alter table MEAL_RESULT
   add constraint FK_MEAL_RES_REFERENCE_SEARCH_Q foreign key (QUERY_ID)
      references SEARCH_QUERY (ID);

alter table MEAL_RESULT
   add constraint FK_MEAL_RES_REFERENCE_MEALS foreign key (MEAL_ID)
      references MEALS (ID);

alter table RESTAURANT_RESULT
   drop constraint FK_RESTAURA_REFERENCE_SEARCH_Q;

alter table RESTAURANT_RESULT
   drop constraint FK_RESTAURA_REFERENCE_RESTAURA;

drop table RESTAURANT_RESULT cascade constraints;

/*==============================================================*/
/* Table: RESTAURANT_RESULT                                     */
/*==============================================================*/
create table RESTAURANT_RESULT 
(
   QUERY_ID             NUMBER(8)            not null,
   RES_ID               NUMBER(8)            not null,
   constraint PK_RESTAURANT_RESULT primary key (QUERY_ID, RES_ID)
);

alter table RESTAURANT_RESULT
   add constraint FK_RESTAURA_REFERENCE_SEARCH_Q foreign key (QUERY_ID)
      references SEARCH_QUERY (ID);

alter table RESTAURANT_RESULT
   add constraint FK_RESTAURA_REFERENCE_RESTAURA foreign key (RES_ID)
      references RESTAURANTS (ID);

