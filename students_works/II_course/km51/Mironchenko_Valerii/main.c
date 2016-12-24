#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <locale.h>
#include <stdbool.h>


typedef struct teacher{
 char teacher_name[20];
 char teacher_surname[20];
 char teacher_patronymic[20];
 char subject[20];
 char academic_degree[20];
};

typedef struct student{
 char student_name[20];
 char student_surname[20];
 char student_patronymic[20];
 char student_course[2];
 char student_groupname[5];
 char student_groupnumber[3];
};

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

// Function for printing name
 char* input_name()
 {
     int i = 0;
 	char name[20];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
 		printf("Enter your first name: ");
 		scanf("%s", &name);
 		if (strchr(name, '0') || strchr(name, '1') || strchr(name, '2') || strchr(name, '3') || strchr(name, '4') ||
 			strchr(name, '5') || strchr(name, '6') || strchr(name, '7') || strchr(name, '8') || strchr(name, '9'))
 		{
 			printf("You input a number! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}
 		else if ((strlen(name) > 20)||(strlen(name)<1))
 		{
 			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 		system("cls");
 		}
 		else i = 1;
 	}

 	return name;
 }

// Function for printing surname
 char* input_surname()
 {
     int i = 0;
 	char surname[20];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
 		printf("Enter your surname: ");
 		scanf("%s",&surname);
 		if (strchr(surname, '0') || strchr(surname, '1') || strchr(surname, '2') || strchr(surname, '3') || strchr(surname, '4') ||
 			strchr(surname, '5') || strchr(surname, '6') || strchr(surname, '7') || strchr(surname, '8') || strchr(surname, '9'))
 		{
 			printf("You input a number! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}
 		 else if ((strlen(surname) > 20)||(strlen(surname)<1))
 		{
			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}
 		else i = 1;
 	}
 	return surname;
 }

 // Function for printing patronymic
 char* input_patronymic()
 {
     int i = 0;
 	char patronymic[20];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
 		printf("Enter your patronymic: ");
 		scanf("%s",&patronymic);
 		if (strchr(patronymic, '0') || strchr(patronymic, '1') || strchr(patronymic, '2') || strchr(patronymic, '3') || strchr(patronymic, '4') ||
 			strchr(patronymic, '5') || strchr(patronymic, '6') || strchr(patronymic, '7') || strchr(patronymic, '8') || strchr(patronymic, '9'))
 		{
 			printf("You input a number! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}
 		 else if ((strlen(patronymic) > 20)||(strlen(patronymic)<1))
 		{
			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}
 		else i = 1;
 	}
 	return patronymic;
 }

//Function for printing student's course number
 char* input_course_number()
 {
     int i = 0, j;
 	char course_number[2];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
		printf("Enter your course number: ");
 		scanf("%s", &course_number);

 		 for(j=0;j<strlen(course_number);j++)
            {
                if(!isdigit(course_number[j]))
			    system("cls");
            }

            	if (( atoi(course_number) <1 )|| (atoi(course_number)>6))
 		{
 			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");

 		}
          else i = 1;
 	}
 return course_number;
 }

 //Function for printing the name of the group
 char* input_group()
 {
     int i = 0;
 	char group[5];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
 		printf("Enter your group: ");
 		scanf("%s", &group);
 		if ((strlen(group) > 5)||(strlen(group)<1))
 		{
 			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");
 		}

 		else i = 1;
 	}

 	return group;
 }

//Function for printing student's course number
 char* input_group_number()
 {
     int i = 0, j;
 	char group_number[3];
 	system("cls");
 	while (i == 0)
 	{
 		fflush(stdin);
		printf("Enter your group number: ");
 		scanf("%s", &group_number);

 		 for(j=0;j<strlen(group_number);j++)
            {
                if(!isdigit(group_number[j]))
			    system("cls");
            }

            	if (( atoi(group_number) <10 )|| (atoi(group_number)>100))
 		{
 			printf("Invalid input! Try again!\n");
 			getchar();
 			getchar();
 			system("cls");

 		}
          else i = 1;
 	}
 return group_number;
 }

 void print_create_student(struct student * st){
     printf("Name: %s\n", st->student_name);
     printf("Surname: %s\n", st->student_surname);
     printf("Patronymic: %s\n", st->student_patronymic);
     printf("Course: %s\n", st->student_course);
     printf("Groupname: %s\n", st->student_groupname);
     printf("Groupnumber: %s\n", st->student_groupnumber);

  }


int main(int argc, char *argv[])
{
 //setlocale(0, "");
 //system("cls");
 printf("Click 'Enter' to type information about student");
 getch();

 struct student student1,
 *st = (struct student*)malloc(sizeof(struct student));
 strcpy(st->student_name, input_name());
 fflush(stdin);
 strcpy(st->student_surname, input_surname());
 fflush(stdin);
 strcpy(st->student_patronymic, input_patronymic());
 fflush(stdin);
 strcpy(st->student_course, input_course_number());
 fflush(stdin);
 strcpy(st->student_groupname, input_group());
 fflush(stdin);
 strcpy(st->student_groupnumber, input_group_number());
 fflush(stdin);

 system("cls");
 print_create_student(st);
 free(st);
 getchar();
 return 0;

}
