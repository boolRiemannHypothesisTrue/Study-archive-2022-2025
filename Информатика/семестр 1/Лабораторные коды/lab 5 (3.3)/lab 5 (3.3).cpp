#include <iostream>//var16-lab5
#include <conio.h>

using namespace std;
int main() {
	int n,m,i,j;
	float sum=0;

	int k=0;
	float sr;
	

	
	
	
	
	
	
	
	cout<<"������� ����� �����=";
	cin>>n;
	
	cout<<"������� ����� ��������=";
	cin>>m;
	
	
	
	
int** X = new int*[n];
for (int i = 0; i < n; ++i){
X[i] = new int[m];
	}
    int sumST[n];
for(int i=0;i<n;i++) {
	for(int j=0;j<m;j++) {
	cout<<"������� X["<<i<<"]["<<j<<"]=";
	cin>>X[i][j];
	}
}
	for(int i=0;i<n;i++) {
		for(int j=0;j<m;j++) {
			cout<<X[i][j]<<'\t';
			
		}
		cout<<endl;
			
	}


    for(int i=0;i<n;i++){
	for(int j=0;j<m;j++) {
		if( (i!=j) && ((X[i][j]>X[i][i] ) && (X[i][j]<X[j][j] ) )){ // �� ������� ������ 
		k+=1;
		sum+=X[i][j];
		}
	}
	}
	 for(int j=0;j<m;j++){
	 	sumST[j]=0;
	for(int i=0;i<n;i++) {
			
		sumST[j]+=X[i][j];
	   
		
	
		}
	}
	
	cout<<"����� ��������� ��������������� �������� "<<k<<endl;

	cout<<"������� �������� ���� ��������� ��������������� �������� "<<sr<<endl;
		for (int j = 0; j < n; ++j) {
		
		cout<<"����� �������="<<j+1<<' ' <<"�����="<<sumST[j]<<endl;
	}
	for (int i = 0; i < n; ++i)
    delete [] X[i];
delete [] X;
	}



		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

