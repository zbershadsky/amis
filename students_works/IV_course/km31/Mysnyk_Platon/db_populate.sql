INSERT INTO "SAMPLE" ("SAMPLE_DATE", "TEXT", "TITLE") VALUES (CURRENT_TIMESTAMP, "lorem lorem lorem", "Lorem"),
(CURRENT_TIMESTAMP, "ipsum ipsum ipsum", "Ipsum");

INSERT INTO "USER_TYPE" ("TYPE") VALUES ('admin');
INSERT INTO "USER_TYPE" ("TYPE") VALUES ('banned');
INSERT INTO "USER_TYPE" ("TYPE") VALUES ('user');

INSERT INTO "USERS" ("EMAIL", "TYPE", "PASSWORD", "NAME") VALUES ('platon@example.com', 'admin', 'pass', 'Platon');
INSERT INTO "USERS" ("EMAIL", "TYPE", "PASSWORD", "NAME") VALUES ('user@example.com', 'user', 'pass', 'User');

INSERT INTO "WORK" ("WORK_DATE", "EMAIL", "TEXT") VALUES (CURRENT_TIMESTAMP, "user@example.com", "lorem ipsum dolor");
INSERT INTO "WORK" ("WORK_DATE", "EMAIL", "TEXT") VALUES (CURRENT_TIMESTAMP, "user@example.com", "lorem lorem lorem");
