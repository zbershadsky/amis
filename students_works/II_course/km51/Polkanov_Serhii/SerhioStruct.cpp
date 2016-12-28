// SerhioStruct.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Consp {
	string subject, theme;
	vector <string> info;
	string place[2];
	string tools[2];
	string writing[3];

};

void set(Consp &t) {
	string materials[5]{
		"Studopedia",
		"Wikipedia",
		"Mathprofi",
		"Kvadromir",
		"Math24" };
	cout << "Enter your subject: ";
	cin >> t.subject;
	cout << "Enter your theme: ";
	cin >> t.theme;
	cout << "Choose the sourses (enter number):";
	for (int i = 0; i < 6; i++) {
		
			cout << i << "." << materials[i-1] << "; \n";
		}
	cout << "Enter 0 to finish choosing \n";

	
	}






	void print(Consp &t)
		{
		cout << "Chosen sourses: \n";
		for (int i = 0; i < t.info.size(); i++) {
			cout << t.info[i] << endl;
		}

	}
	







int main()
{
	Consp t;
	set(t);
	system("pause");
    return 0;
}

