#include <stdio.h>
#include <stdlib.h>
#include <exception>
#include <iostream>
#include <windows.h>
#include <conio.h>
#define N 10
using namespace std;

 typedef struct  {
    int number_in_list;
    char name[25];
    char surname[25];
    char post[15];
    int salary;
    }employee;

typedef struct {
    int number_in_list;
    char songTitle[20];
    char style[15];
    float duration;
}music_list ;

typedef enum {
     EDITORS,
     NARRATORS,
     CORRESPONDENTS,
     JOURNALIST,
     SOUNDMANS,
     TECHNICIANS
 }department ;

typedef struct   {
    char name[20];
    char surname[25];
    int salary;
    department dept;
}manager;

void AddEmployee(employee EmpArr[N],int *employeeCount){
    int flag=1;
    while(flag){
        try{
            printf("Input number:\n");
            scanf("%d",EmpArr[*employeeCount].number_in_list);
            printf("Input name:\n");
            scanf("%s",EmpArr[*employeeCount].name);
            printf("Input surname:\n");
            scanf("%s",EmpArr[*employeeCount].surname);
            printf("Input post:\n");
            scanf("%s",EmpArr[*employeeCount].post);
            printf("Input salary:\n");
            scanf("%d",EmpArr[*employeeCount].name);
            flag=0;
        }
        catch(exception &e){
            cout<<e.what()<<"\n";
        }
    }
}

void AddManager(manager ManArr[N],int *managerCount){

}

void AddMusic(music_list MusList[N],int *musicCount){

}

void addMember(manager ManArr[N],int *managerCount,employee EmpArr[N],int *employeeCount,music_list MusList[N],int *musicCount){
while (true){
    printf("menu\n1. Add new employee\n2. Add new manager\n3.Add new music\nECS to back\n");
        switch(getch()){
        case 1:
            AddEmployee(EmpArr,employeeCount);
            return;
        case 2:
            AddManager(ManArr,managerCount);
            return;
        case 3:
            AddMusic(MusList,musicCount);
            return;
        case 27:
            return;
        default:
            printf("Choose proper key to continue...\n");
        };
}
}

void printList(){}

void menu(manager ManArr[N],int *managerCount,employee EmpArr[N],int *employeeCount,music_list MusList[N],int *musicCount){
    while(true){
        printf("menu\n1. Add new member\n2. Print list\nECS to quit\n");
        switch(getch()){
        case 1:
            addMember(ManArr,managerCount,EmpArr,employeeCount,MusList,musicCount);
            break;
        case 2:
            printList();
            break;
        case 27:
            return;
        default:
            printf("Choose proper key to continue...\n");
        };
    }
}

int main()
{
    manager Mnrs[N];
    int managerCount=0;
    employee Emps[N];
    int employeeCount=0;
    music_list lst[N];
    int musicCount=0;
    menu(Mnrs,&managerCount,Emps,&employeeCount,lst,&musicCount);
    return 0;
}
