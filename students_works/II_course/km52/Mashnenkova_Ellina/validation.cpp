#include <stdio.h> 
#include <stdlib.h> 
#include <malloc.h> 

int incorrectInputError();

int inputNumber() {		//if entered data is incorrect returns 0;
	fflush(stdin);
	
		
	int scan;
	return  scanf("%i",&scan)!=1 || scan < 0  ? incorrectInputError() : scan;
}

int incorrectInputError()	{
	printf("\nYou entered incorrect value.\nPlease enter a number bigger than zero\n");
	inputNumber();
}
struct Teacher { 
	char name[20]; 
	char surname[20]; 
}; 

struct Student { 
	char name[20]; 
	char surname[20]; 
	char group[6]; 
}; 

struct LaboratoryWork { 
	char theme[100]; 
	char variant[5]; 
	char aim[100]; 
	char tasks[100]; 
	int count_of_tasks; 
	char test_questions[200]; 
	int count_of_questions; 
	int grade; 
}; 

void inputStudent(struct Student *student)	{
	printf("Enter student's name : ");
	fgets(student[0].name,20,stdin);
	printf("Enter student's surname : ");
	fgets(student[0].surname,20,stdin);
	printf("Enter student's group : ");
	fgets(student[0].group,6,stdin);

}

void inputTeacher(struct Teacher *teacher)	{
	printf("Enter teacher's name : ");
	fgets(teacher[0].name,20,stdin);
	printf("Enter teacher's surname : ");
	fgets(teacher[0].surname,20,stdin);
	
}

void inputLab(struct LaboratoryWork *lab)	{
	printf("Enter lab's theme : ");
	fflush(stdin);
	fgets(lab[0].theme,100,stdin);
	printf("Enter lab's variant : ");
	fgets(lab[0].variant,5,stdin);
	printf("Enter lab's aim : ");
	fgets(lab[0].aim,100,stdin);
	printf("Enter lab's tasks : ");
	fgets(lab[0].tasks,100,stdin);
	printf("Enter number of tasks : ");
	lab[0].count_of_tasks = inputNumber();
	fflush(stdin);
	printf("Enter test questions : ");
	
	fgets(lab[0].test_questions,100,stdin);
	printf("Enter count of questions : ");
	fflush(stdin);
	lab[0].count_of_questions = inputNumber();
	printf("Enter grade : ");
	lab[0].grade = inputNumber();
}

 main() { 
	struct Student *student = (struct Student*)malloc(sizeof(struct Student));  
	struct Teacher *teacher = (struct Teacher*)malloc(sizeof(struct Teacher)); 
	struct LaboratoryWork *lab = (struct LaboratoryWork*)malloc(sizeof(struct LaboratoryWork)); 
	
	inputStudent(student);
	inputTeacher(teacher);
	inputLab(lab);
	
	free(student); 
	free(teacher); 
	free(lab); 
}
