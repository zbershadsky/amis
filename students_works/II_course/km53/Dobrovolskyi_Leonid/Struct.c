#include <stdio.h>
#define max_length 20
#define max_length_diagn 200

typedef struct Autorization //autorization in hospital
 {
  char first_name[max_length];
  char last_name[max_length];
  int medical_card;       
 }autorization; 

typedef struct Diagnostic //symptoms and anaysis
 {
  char symptoms[max_length_diagn];
  char analysis[max_length_diagn];      
 }diagnostic;

typedef struct Treatment //therapy
 {
  char therapy[max_length_diagn];
  char hospital_status[max_length]; 
 }treatment;

int main ()
 {
  autorization *patient_autoriz=(autorization*)malloc(sizeof(autorization));  //pointer to autorization
  diagnostic *patient_diagnos=(diagnostic*)malloc(sizeof(diagnostic));  //pointer to diagnostic
  treatment *patient_therapy=(treatment*)malloc(sizeof(treatment));    //pointer to therapy     
  
  
  //patient making
  strcpy (patient_autoriz->first_name, "Leonid");
  strcpy (patient_autoriz->last_name, "Dobrovolsky");
  patient_autoriz->medical_card=58920398;
  strcpy (patient_diagnos->symptoms, "headache");
  strcpy (patient_diagnos->analysis, "X-ray");
  strcpy (patient_therapy->therapy, "analgin");
  strcpy (patient_therapy->hospital_status, "no");
  
  //output
  printf ("Name: %s\nLastname: %s\nMedical card: %d", patient_autoriz->first_name, patient_autoriz->last_name, patient_autoriz->medical_card);
  printf ("\nSymptoms: %s\nAnalysis: %s", patient_diagnos->symptoms, patient_diagnos->analysis);
  printf ("\nTherapy: %s\nNeed for hospitalization: %s", patient_therapy->therapy, patient_therapy->hospital_status);
  
  
  //clear memory
  free (patient_autoriz);
  free (patient_diagnos);
  free (patient_therapy);
  
  getchar ();
  return 0;
 }
  
  
