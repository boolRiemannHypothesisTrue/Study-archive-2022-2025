#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
using namespace std;




int main(){
int x=3;
int A[x][x]={{1,2,3},{4,5,6},{7,8,9}};
for(int i=0;i<x;i++){
		
			cout<<A[i][x-1-i]<<' ';
		
	}
	cout<<endl;
}
