#include <stdio.h>
#include <string.h>
#include <malloc.h>
#define max_leng 20

typedef struct Lab_protection {
	char student_name[max_leng];
	char student_surname[max_leng];
	char teacher_name[max_leng];
	char teacher_surname[max_leng];
	char lab_theme[max_leng];
	char date[max_leng];
	int evaluation;
} lab_protection;


int main()
{
	lab_protection *Lab = NULL;
	
	Lab = (lab_protection*)malloc(sizeof(lab_protection));

	strcpy (Lab->student_name,"Kostya");
   	strcpy (Lab->student_surname,"Ostapenko");
   	strcpy (Lab->teacher_name,"Igor");
   	strcpy (Lab->teacher_surname,"Tereshenko");
   	strcpy (Lab->lab_theme,"PHP");
   	strcpy (Lab->date,"20-12-2016");
   	Lab->evaluation = 3;

   	printf("Student name: %s\n",Lab->student_name);
   	printf("Student surname: %s\n",Lab->student_surname);
   	printf("Teacher name: %s\n",Lab->teacher_name);
   	printf("Teacher surname: %s\n",Lab->teacher_surname);
   	printf("Lab theme: %s\n",Lab->lab_theme);
   	printf("Date: %s\n",Lab->date);
   	printf("Evaluation: %d\n",Lab->evaluation);

    free(Lab);
    
    getchar ();
	return 0;
}
