#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <locale.h>
#include <stdbool.h>

typedef struct{
 char teacher_name[20];
 char teacher_surname[20];
 char teacher_patronymic[20];
 char subject[20];
 char academic_degree[20];
} teacher;

typedef struct{
 char student_name[20];
 char student_surname[20];
 char student_patronymic[20];
 int student_course;
 char student_groupname[5];
 int student_groupnumber;
} student;

enum bal_mark{
    Fx, // <36
    F,  // <60
    E,  // 60-64
    D,  // 65-74
    C,  // 75-84
    B,  // 85-94
    A   // 95-100
};

typedef struct{
 int mark;
 enum bal_mark bal_mark;
 bool got_credit;
} credit;



int main()
{
 setlocale(LC_ALL,"Russian");
 system("cls");

 teacher *teach = NULL;
 student *stud = NULL;
 credit  *cred = NULL;

 teach = (teacher*) malloc(sizeof(teacher));
 stud = (student*) malloc(sizeof(student));
 cred = (credit*) malloc(sizeof(credit));

 char get_student(){
     int student_check = 0;
  		while (student_check == 0)
  			{
	 		 fflush(stdin);
	 		 printf("Type your name, surname, patronymic: ");
	 		 scanf("%s", &name);

	 		 if (strchr(student, '0') || strchr(student, '1') || strchr(student, '2') || strchr(student, '3') || strchr(student, '4') ||
                 strchr(student, '5') || strchr(student, '6') || strchr(student, '7') || strchr(student, '8') || strchr(student, '9'))
              {
                 printf("You input a number. Try again!\n");
                 getchar();
                 system("cls");
			  }
 			 else
                 student_check = 1;
	 		 }
	 return student;
 }

 int get_course(){
 		int ucourse = 0;
  		while (ucourse == 0)
  			{
	 		 fflush(stdin);
	 		 printf("Type your course: ");
			 scanf("%i", &course);

			 if (strchr(course, '1') || strchr(course, '2') || strchr(course, '3') || strchr(course, '4') ||
			 strchr(course, '5') || strchr(course, '6')){
			 	ucourse = 1;
			 }
			 else
			 	printf(" You typed wrong course number!\n");
			 	getchar();
			 	system("cls");
			 }
	return course;
 }

 char length_name() {
    char name[n];
          while ((scanf("%s", &name)==1) && (strlen(name)>200))
          {
            printf("Length > 20. Try again: ");
            fflush(stdin);
          }
    scanf("%s", name);
    return name;
 }


 free(teach);
 free(stud);
 free(cred);
 return 0;
}
