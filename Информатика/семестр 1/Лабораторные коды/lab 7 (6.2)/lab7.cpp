#include <iostream>
#include <Windows.h>
#include <clocale>
#include <string>
#include <fstream>
using namespace std;


int main() {
	setlocale(LC_ALL,"Russian");///// не работает
	bool V = true; //переменная чтобы условие 1 не начинался дважды
bool  M= true; 
	bool  R= true; 
	ifstream file("text.txt");
	string str;
	string STR;
		string STR2;
			string STR3;
				string STR4;
	file >>str;
	file >> STR;
		file >> STR2;
			file >> STR3;
				file >> STR4;
	str.insert(str.length(), " "); // исходный пробел
	str.insert(str.length(), STR); // присоединение  строчки STR к str
	str.insert(str.length(), " "); // исходный пробел
	str.insert(str.length(), STR2); // присоединение  строчки STR к str
	str.insert(str.length(), " "); // исходный пробел
	str.insert(str.length(), STR3); // присоединение  строчки STR к str
	str.insert(str.length(), " "); // исходный пробел
	str.insert(str.length(), STR4); // присоединение  строчки STR к str


	for (int i = 0; i < str.length(); i += 1) {
		if (str[i] == 'c' && V) {
	     for(int j=i;j<i+3;j++)
			cout<<str[j];
			
	i += 4;
	V = false;
		}
	
			if (str[i] == 'c' && M) {
				cout<<' ';
	     for(int f=i;f<i+4;f++)
			cout<<str[f];
			
	i += 4;
	M = false;
		}
			if (str[i] == 'c' && R) {
					cout<<' ';
	     for(int g=i;g<i+8;g++)
			cout<<str[g];
			
	i += 4;
	R= false;
		}
		
	
	}
	
ofstream FILE("h.txt");// вывод измененной строки в новый файл
FILE<< str;
}

