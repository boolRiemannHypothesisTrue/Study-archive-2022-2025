#include <iostream>
#include <Windows.h>
#include <clocale>
#include <string>
#include <fstream>
using namespace std;


int main() {
bool V = true; 
bool  M= true; 
	bool  R= true;
	bool B=true;
	bool F=true; 

	ifstream file("text.txt");
	string str;
	string STR;
		string STR2;
			string STR3;
				string STR4;
				string STR5;
				string STR6;
				string STR7;
	file >>str;
	file >> STR;
		file >> STR2;
			file >> STR3;
				file >> STR4;
	str.insert(str.length(), " "); 
	str.insert(str.length(), STR); 
	str.insert(str.length(), " "); 
	str.insert(str.length(), STR2); 
	str.insert(str.length(), " ");
	str.insert(str.length(), STR3); 
	str.insert(str.length(), " "); 
	str.insert(str.length(), STR4);
	str.insert(str.length(), " " ); 




	
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
	cout<<endl;
	
ofstream FILE("h.txt");
FILE<< str;





      file>>STR5;
        file>>STR6;
          file>>STR7;
          	STR5.insert(STR5.length(), " "); 
	STR5.insert(STR5.length(), STR6); 
	STR5.insert(STR5.length(), " "); 
	STR5.insert(STR5.length(), STR7); 
	STR5.insert(STR5.length(), " "); 
 

	for (int h = 0; h < STR5.length(); h += 1) {
		if (STR5[h] == 'c' && B) {
	     for(int m=h;m<h+4;m++)
			cout<<STR5[m];
			
	h += 5;
	B = false;
		}
	
			if (STR5[h] == 'c' && F) {
				cout<<' ';
	     for(int r=h;r<h+3;r++)
			cout<<STR5[r];
			
	h += 4;
	F = false;
}}
   
      FILE<< STR5;
}
