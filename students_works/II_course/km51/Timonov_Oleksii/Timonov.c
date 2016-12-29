#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <windows.h>
#include "stack.h"
#include "validation.h"

enum groups_list {
	KM_51, KM_52, KM_53, KP_51, KP_52, KP_53, KV_51, KV_52, KV_53, IO_51, IO_52, IO_53, IS_51, IS_52, IS_53, IP_51, IP_52, IP_53
};

enum faculties_list {
	FAM, FICT
};

struct lesson {
    char Name[20];
	char Date[10];
	int number_of_lessons;	
};

struct teacher {
    char Name[20];
	char Surname[20];
	char qualification;
};

struct student{
	char Name[20];
	char Surname[20];
	enum groups_list group;
	enum faculties_list faculty;
};

struct attandance_book {
    struct student;
	struct lesson;
	char attandance;
};

int main(){
	struct lesson * lesson_1 = malloc(sizeof(struct lesson));
	struct teacher * teacher_1 = malloc(sizeof(struct teacher));
	
	printf("Enter lessons's name: ");
	get_string(&(lesson_1->Name[0]), 22, 0, 20);
	printf("\n\nEnter lesson's info");
	get_date(&(lesson_1->Date[0]), 4, 3);
	lesson_1->number_of_lessons = get_int(4, 4, 3);
	printf("\n\nEnter teacher's name: ");
	get_string(&(teacher_1->Name[0]), 22, 6, 20);
	printf("\nEnter teacher's surname: ");
	get_string(&(teacher_1->Name[0]), 25, 7, 20);
	
	return 0;
}
