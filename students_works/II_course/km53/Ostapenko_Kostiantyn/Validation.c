#include <stdio.h>
#include <windows.h>
#include <conio.h>
#include <malloc.h>
#include<string.h>
#define max_size 20


typedef struct Lab_protection {
	char student_name[max_size];
	char student_surname[max_size];
	char teacher_name[max_size];
	char teacher_surname[max_size];
	char lab_theme[max_size];
	char date[max_size];
	int evaluation;
} lab_protection;



 void create_struct () {
   lab_protection *tmp=(lab_protection*)malloc(sizeof(lab_protection));

   //input student name
   system ("cls");
   printf ("Input student name: ");

   do {
    gets (tmp->student_name);
    if (strlen (tmp->student_name)==0 || strlen (tmp->student_name) > max_size) {
      printf ("Invalid value\nInput student name: ");
    }
   } while (strlen (tmp->student_name)==0 || strlen (tmp->student_name) > max_size);

   //input student surname
   printf ("Input student surname: ");

   do {
    gets (tmp->student_surname);
    if (strlen (tmp->student_surname)==0 || strlen (tmp->student_surname) > max_size) {
      printf ("Invalid value\nInput student surname: ");
    }
   } while (strlen (tmp->student_surname)==0 || strlen (tmp->student_surname) > max_size);


   //input teacher name
   printf ("Input teacher name: ");

   do {
    gets (tmp->teacher_name);
    if (strlen (tmp->teacher_name)==0 || strlen (tmp->teacher_name) > max_size) {
      printf ("Invalid value\nInput teacher name: ");
    }
   } while (strlen (tmp->teacher_name)==0 || strlen (tmp->teacher_name) > max_size);

    //input teacher name
   printf ("Input teacher surname: ");

   do {
    gets (tmp->teacher_surname);
    if (strlen (tmp->teacher_surname)==0 || strlen (tmp->teacher_surname) > max_size) {
      printf ("Invalid value\nInput teacher surname: ");
    }
   } while (strlen (tmp->teacher_surname)==0 || strlen (tmp->teacher_surname) > max_size);


    //input lab theme
   printf ("Input lab theme: ");

   do {
    gets (tmp->lab_theme);
    if (strlen (tmp->lab_theme)==0 || strlen (tmp->lab_theme) > max_size) {
      printf ("Invalid value\nInput lab theme: ");
    }
   } while (strlen (tmp->lab_theme)==0 || strlen (tmp->lab_theme) > max_size);


   printf ("First name of patient: %s\n", tmp->student_name);
   printf ("Last name of patient: %s\n", tmp->student_surname);
   printf ("Medical card of patient: %s\n", tmp->teacher_name);
   printf ("Symptoms of patient: %s\n", tmp->teacher_surname);
   printf ("Analysis of patient: %s\n", tmp->lab_theme);
   printf ("Press any key");
   getch ();
   system ("cls");

   free (tmp);


 }



void menu () {
  int parameter;

  while (1) {
  system ("cls");
  printf ("Enter ENTER, to input struct\nEnter ESC, to exit");

  do {
   parameter = getch ();
  } while (parameter!=13 && parameter!=27);

  if (parameter == 27) exit (0);

  if (parameter == 13) create_struct ();

  }
 }


int main () {
  menu ();

  return 0;
 }
