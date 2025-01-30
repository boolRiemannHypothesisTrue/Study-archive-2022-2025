#include <iostream> 
#include <fstream> 
#include <conio.h>
using namespace std;




int** MatrixRead(int x, int y, int s) {

    int** A = new int* [x];
    for (int i = 0; i < x; i++) {
        A[i] = new int[y];
    }
    if (s == 1) {

        ifstream file("text1.txt");
        for (int i = 0; i < x; i++) {
            for (int j = 0; j < y; j++) {
                file >> A[i][j];
            }
        }

        return A;
    }
    else {
        if (s == 2) {
            ifstream file("text2.txt");
            for (int i = 0; i < x; i++) {
                for (int j = 0; j < y; j++) {
                    file >> A[i][j];
                }
            }

            return A;
        }
        else {
            ifstream file("text3.txt");
            for (int i = 0; i < x; i++) {
                for (int j = 0; j < y; j++) {
                    file >> A[i][j];
                }
            }

            return A;
        }


    }
}
void MaxSearch(int x, int y, int *A[]){
int	max=A[0][1];
	for (int i = 0;i < x;i++) {
        for (int j = i+1;j < y;j++) {
        	if(A[i][j]>max){
        		max=A[i][j];
			}
        	
		}
	}
	cout<<"Max="<<max;
}
void MatrixOut(int x, int y, int* A[]){
    for (int i = 0;i < x;i++) {
        for (int j = 0;j < y;j++) {
            cout << A[i][j] << ' ';
        }
        cout << endl;
    }
}

int main() {
    int n, m;
    
    cin >> n >> m;
    int** A = MatrixRead(n, m, 1);
    int** B = MatrixRead(n, m, 2);
    int** C = MatrixRead(n, m, 3);
    MatrixOut(n, m, A);
    cout<<endl;
    MatrixOut(n, m, B);
    cout<<endl;
    MatrixOut(n, m, C);
    cout<<endl;
     getche(c);
    MaxSearch(n,m,B);
}
