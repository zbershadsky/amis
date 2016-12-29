insert into "Role" ("role_name", "role_desc") values ('Викладач', 'Людина, яка проводить заняття та приймає залік');

insert into "Role" ("role_name", "role_desc") values ('Студент', 'Людина, яка складає залік та навчається у викладача');

/*==============================================================*/

insert into "User" ("user_login", "user_pass", "user_email") values ('iTereshenko', 'KVGB8K1860EJ9CLXDROTQEAO5BT4GA4XLV8SWJH6DXN7P724AO', 'tereshenko@gmail.com');

insert into "User" ("user_login", "user_pass", "user_email") values ('iZhuk', '6UKQH3XXHL1WSVLQX87ICLXCNFH5W1F4R8MK15LR6GUF3PGMB', 'zis96@ukr.net');


/*==============================================================*/

insert into "Student" ("student_name", "student_nsc") values ('Жук Іван Сергійович', 'HT20BTVBS6');

/*==============================================================*/

insert into "User-student" ("user_login", "student_name", "student_nsc") values ('iZhuk', 'Жук Іван Сергійович', 'HT20BTVBS6');

/*==============================================================*/

insert into "Teacher" ("teacher_name", "teacher_nwc") values ('Терещенко Ігор Олександрович', 'VFNUJE62NC');

/*==============================================================*/

insert into "User-teacher" ("user_login", "teacher_name", "teacher_nwc") values ('iTereshenko', 'Терещенко Ігор Олександрович', 'VFNUJE62NC');

/*==============================================================*/

insert into "User status" ("user_login", "user_status", "user_stat_date", "user_stat_desc") values ('iZhuk', 'created', '2016-12-25 12:00:00','Користувач iZhuk створений');

insert into "User status" ("user_login", "user_status", "user_stat_date", "user_stat_desc") values ('iTereshenko', 'created', '2016-12-25 12:01:00','Користувач iTereshenko створений');

insert into "User status" ("user_login", "user_status", "user_stat_date", "user_stat_desc") values ('iTereshenko', 'verified', '2016-12-25 12:04:00','Користувач iTereshenko верифікований. Це Терещенко Ігор Олександрович, Викладач, номер трудової книжки: VFNUJE62NC');

insert into "User status" ("user_login", "user_status", "user_stat_date", "user_stat_desc") values ('iZhuk', 'verified', '2016-12-25 12:05:00','Користувач iZhuk верифікований. Це Жук Іван Сергійович, Студент, номер студентського квитка: HT20BTVBS6');

/*==============================================================*/

insert into "Group" ("group_abbr", "group_desc", "group_status") values ('КМ-32', 'Група кафедри прикладної математики', 'created');

/*==============================================================*/

insert into "Students and groups" ("student_name", "student_nsc", "group_abbr") values ('Жук Іван Сергійович', 'HT20BTVBS6', 'КМ-32');

/*==============================================================*/

insert into "Subject" ("subject_number", "subject_name", "subject_desc", "subject_status") values ('НППС-4011', 'Бази Даних та Інформаційні Системи', 'Дисципліна, яка дає знання з побудови Баз Даних та розробки Інформаційних систем', 'created');

/*==============================================================*/

insert into "Subjects, teachers and groups" ("group_abbr", "teacher_name", "teacher_nwc", "subject_number") values ('КМ-32', 'Терещенко Ігор Олександрович', 'VFNUJE62NC', 'НППС-4011');

/*==============================================================*/

insert into "Work" ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name", "work_desc", "work_status") values ('НППС-4011', 'КМ-32', 'Терещенко Ігор Олександрович', 'VFNUJE62NC', 'Залікова контрольна робота', 'В рамках даної роботи потрібно виконати завдання, які наведені у файлу', 'created');

/*==============================================================*/

insert into "Result" ("subject_number", "group_abbr", "teacher_name", "teacher_nwc", "work_name", "student_name", "student_nsc", "result_mark_value", "result_status") values ('НППС-4011', 'КМ-32', 'Терещенко Ігор Олександрович', 'VFNUJE62NC', 'Залікова контрольна робота', 'Жук Іван Сергійович', 'HT20BTVBS6', 90, 'created');

/*==============================================================*/

insert into "User-role" ("user_login", "role_name") values ('iZhuk', 'Студент');

insert into "User-role" ("user_login", "role_name") values ('iTereshenko', 'Викладач');

