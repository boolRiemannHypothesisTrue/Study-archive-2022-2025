#include <iostream>

using namespace std;

int **MatrixInput(int x, int y) {
    int **A = new int* [x];
    for (int i = 0; i < x; i++) {
        A[i] = new int[y];
    }
    for (int i = 0; i < x; i++) {
        for (int j = 0; j < y; j++) {
            cin >> A[i][j];
        }
    }
    return A;
}

int Func(int x, int y, int *A[]) {
     int sum = 0;
     for (int i = 0; i < x; i++) {
         for (int j = 0; j < y; j++) {
             if ((i < j) && (A[i][j] > 0)) {
                 sum += A[i][j];
             }
         }
     }
     return sum;
 }

 int main() {
     int n, m;
     int k = 0;
     cin >> n;
     cin >> m;
     int **A = MatrixInput(n, m);
     int **B = MatrixInput(n, m);
     for (int i = 0; i < n; i += 1) {
         for (int j = 0; j < m; j += 1) {
             cout << A[i][j];
         }
         cout << endl;
     }
     cout << endl;
     for (int i = 0; i < n; i += 1) {
         for (int j = 0; j < m; j += 1) {
             cout << B[i][j];
         }
         cout << endl;
     }
     k = Func(n, m, A) - Func(n, m, B);
     cout << k;
 } 
 
 		
 		
	
 
