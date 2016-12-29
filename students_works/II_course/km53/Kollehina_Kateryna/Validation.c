#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <windows.h>
#include <ctype.h>

typedef struct student{
 	char first_name[10];
 	char last_name[10];
 	char course_number[2];
 	char group[5];
 };
typedef struct work_book{
	enum subject{
 		 math,
 		 physics,
 		 english,
 		 ukrainian
 		 };
 	
 	enum language{
 	     Ukrainian,
 	     Russian,
 	     English
 		 };
 	
};

char* input_first_name()
{
    int i = 0;
	char first_name[10];
	system("cls");
	while (i == 0)
	{
		fflush(stdin);
		printf("Enter your first name: ");
		scanf("%s", &first_name);
		if (strchr(first_name, '0') || strchr(first_name, '1') || strchr(first_name, '2') || strchr(first_name, '3') || strchr(first_name, '4') ||
			strchr(first_name, '5') || strchr(first_name, '6') || strchr(first_name, '7') || strchr(first_name, '8') || strchr(first_name, '9'))
		{
			printf("You input a number! Try again!\n");
			getchar();
			getchar();
			system("cls");
		}
		else if ((strlen(first_name) > 10)||(strlen(first_name)<1))
		{
			printf("Invalid input! Try again!\n");
			getchar();
			getchar();
			system("cls");
		}
		else i = 1;
	}

	return first_name;
}


char* input_last_name()
{
    int i = 0;
	char last_name[10];
	system("cls");
	while (i == 0)
	{
		fflush(stdin);
		printf("Enter your surname: ");
		scanf("%s",&last_name);
		if (strchr(last_name, '0') || strchr(last_name, '1') || strchr(last_name, '2') || strchr(last_name, '3') || strchr(last_name, '4') ||
			strchr(last_name, '5') || strchr(last_name, '6') || strchr(last_name, '7') || strchr(last_name, '8') || strchr(last_name, '9'))
		{
			printf("Invalid input! Try again!\n");
			getchar();
			getchar();
			system("cls");
		}
		 else if ((strlen(last_name) > 10)||(strlen(last_name)<1))
		{
			printf("You input a number! Try again!\n");
			getchar();
			getchar();
			system("cls");
		}
		else i = 1;
	}
	return last_name;
}

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


void print_create_student(struct student * st){
    printf("first_name: %s\n", st->first_name);
    printf("last_name: %s\n", st->last_name);
    printf("course_number: %s\n", st->course_number);
    printf("group: %s\n", st->group);

 }

int main(int argc, char *argv[])
{
	struct student student1,
	*st = (struct student*)malloc(sizeof(struct student));


	strcpy(st->first_name, input_first_name());
	fflush(stdin);
	strcpy(st->last_name, input_last_name());
	fflush(stdin);
	strcpy(st->course_number, input_course_number());
	fflush(stdin);
    strcpy(st->group, input_group());

	fflush(stdin);
	system("cls");
	print_create_student(st);

	printf("\n Everything is OK!");
	free(st);
	getchar();
	return 0;
}
