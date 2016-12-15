#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>


struct Group{
char name;
int number_of_students;
};


struct user_student_type {
char *student_first_name;
char *student_last_name;
char *student_group;
};

struct user_lecturer_type {
char *lecturer_first_name;
char *lecturer_last_name;
};

struct test_type {
int variant;
char *theme;
int count_of_tasks;
char task_question;
};

//validation functions
char *get_name() {
    char name[20];

          while ((scanf("%s", &name)==1)&& strlen(name)>20) {
          printf(" Ошибка! Вы должны ввести строку, которая содержит не более 20 символов. Попробуйте снова: ");
          fflush(stdin);}
        scanf("%s", name);
    return name;
}

char *get_group() {
    char group[10];
         while ((scanf("%s", &group)==1)&& strlen(group)>10) {
          printf(" Ошибка! Вы должны ввести строку, которая содержит не более 10 символов. Попробуйте снова: ");{
         scanf("%s",group);
         fflush(stdin);
         }
return group;
}

int get_int() {
    int number;
        while ((scanf("%d", &number)!=1)) {
          printf(" Вы можете ввести только цифры. Попробуйте снова: ");
          fflush(stdin);}
return number;
}

//main part
void main() {
struct user_student_type *user_student=NULL;
struct user_teacher_type *user_teacher=NULL;
struct test_type *test=NULL;
struct Group *group=NULL;


user_student=(struct user_student_type *)malloc(sizeof(struct user_student_type));
user_student->student_first_name=get_name();
user_student->student_last_name=get_name();
user_student->student_group=get_group();

user_teacher=(struct user_lecturer_type *)malloc(sizeof(struct user_lecturer_type));
user_teacher->lecturer_first_name=get_name();
user_teacher->lecturer_last_name=get_name();

test=(struct test_type *)malloc(sizeof(struct test_type));
test->variant=get_int();
test->theme=get_name();
test->count_of_tasks=get_int();
test->task_question=get_name();

group=(struct Group *)malloc(sizeof(struct Group));
group->name=get_name();
group->number_of_students=get_int();

free(user_student);
free(user_lecturer);
free(test);
free(group);
}
