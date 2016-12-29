#include <stdio.h>
#include <windows.h>
#include <conio.h>
#include <malloc.h>
#include<string.h>
#define max_length 20
#define max_length_diagn 200
#define numeric_number 8

typedef struct Patient //struct patient
 {
  char first_name[max_length];
  char last_name[max_length];
  int medical_card;
  char symptoms[max_length_diagn];
  char analysis[max_length_diagn];
  char therapy[max_length_diagn];
 } patient;
 



 int_input () {
  int numeric[numeric_number]; 
  int number, power;    
  int i=0;
  
  while (i<numeric_number+1) {
    numeric[i] = getch ();
    
    if (numeric[i] == 8 && i>0) {printf ("\b \b"); i--; continue;}
    
    if (i == numeric_number && numeric[i]!=13) continue;
    
    if (i == numeric_number && numeric[i]==13) break;
    
    if (numeric[i] < 48 || numeric[i]> 57) continue;
    
    printf ("%d", numeric[i]-48);
    i++;       
  }
  
  number = 0;
  power = 10000000; //10^7
  
  for (i=0; i<numeric_number; i++) {
   number = number + power*(numeric[i]-48);
   power = power/10;       
  } 
  
  return number;      
 }
 
 
 input_struct () {
   patient *element=(patient*)malloc(sizeof(patient));
        
   //input first name
   system ("cls");
   printf ("Input first name of patient\n->");      
      
   do {
    gets (element->first_name);    
    if (strlen (element->first_name)==0 || strlen (element->first_name) > max_length) {
      system ("cls");
      printf ("\aInput first name of patient\n->");   
    }     
   } while (strlen (element->first_name)==0 || strlen (element->first_name) > max_length);   
   
   //input last name
   system ("cls");
   printf ("Input last name of patient\n->");     
      
   do {
    gets (element->last_name);    
    if (strlen (element->last_name)==0 || strlen (element->last_name) > max_length) {
      system ("cls");
      printf ("\aInput last name of patient\n->");   
    }     
   } while (strlen (element->last_name)==0 || strlen (element->last_name) > max_length);    
   
   
   //input medical card
   system ("cls");
   printf ("Input medical card of patient, input 8 number\n-> ");
   element->medical_card = int_input ();
    
   //input symptoms
   system ("cls");
   printf ("Input symptoms of patient\n->");    
      
   do {
    gets (element->symptoms);    
    if (strlen (element->symptoms)==0 || strlen (element->symptoms) > max_length_diagn) {
      system ("cls");
      printf ("\aInput symptoms of patient\n->");   
    }     
   } while (strlen (element->symptoms)==0 || strlen (element->symptoms) > max_length_diagn);       
   
   //input analisus
   system ("cls");
   printf ("Input analysis of patient\n->");    
      
   do {
    gets (element->analysis);    
    if (strlen (element->analysis)==0 || strlen (element->analysis) > max_length_diagn) {
      system ("cls");
      printf ("\aInput analysis of patient\n->");   
    }     
   } while (strlen (element->analysis)==0 || strlen (element->analysis) > max_length_diagn);   
   
   //input therapy
   system ("cls");
   printf ("Input therapy of patient\n->");    
      
   do {
    gets (element->therapy);    
    if (strlen (element->therapy)==0 || strlen (element->therapy) > max_length_diagn) {
      system ("cls");
      printf ("\aInput therapy of patient\n->");   
    }     
   } while (strlen (element->therapy)==0 || strlen (element->therapy) > max_length_diagn);   
     
   
   printf ("First name of patient: %s\n", element->first_name);
   printf ("Last name of patient: %s\n", element->last_name);
   printf ("Medical card of patient: %d\n", element->medical_card);
   printf ("Symptoms of patient: %s\n", element->symptoms);
   printf ("Analysis of patient: %s\n", element->analysis);
   printf ("Therapy of patient: %s\n", element->therapy); 
   printf ("Press any key");
   getch ();
   system ("cls");
   
   free (element);    
 }
 
 
 
 menu () {
  int parameter;
  
  while (1) {
  system ("cls");
  printf ("Enter ENTER, to input struct\nEnter ESC, to exit");      
  
  do {
   parameter = getch ();
   if (parameter!=13 && parameter!=27) printf ("\a");   
  } while (parameter!=13 && parameter!=27);
 
  if (parameter == 27) exit (0);
  
  if (parameter == 13) input_struct ();
    
  }
 }
 
 
int main () {
  menu ();   
    
  return 0; 
 }
