#include <stdio.h>
#include <stdlib.h>

struct employee {
    int number_in_list;
    char name[25];
    char surname[25];
    char post[15];
    int salary;
    };

struct music_list {
    int number_in_list;
    char song title[20];
    char style[15]
    float duration;
};

enum department {
     EDITORS,
     NARRATORS,
     CORRESPONDENTS,
     JOURNALIST,
     SOUNDMANS,
     TECHNICIANS
 };

struct manager  {
    char name[20];
    char surname[25];
    int salary;
    department dept;
};

int main()
{
    return 0;
}
