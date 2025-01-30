#include <iostream>
using namespace std;

int main ()
{
    int n,m;
    cout << "vvedite kol-vo strok massiva n=";
    cin >> n;
    cout << "vvedite kol-vo stolbcov massiva m=";
    cin >> m;
    
    int **a, i, j;
    a = new int* [n];
    
    for (i = 0; i < n ; i++){
        a[i] = new int[m];
    }
    for (i = 0; i < n; i++){
        for (j = 0; j < m; j++){
            cout << "a[" << i << "]" << "[" << j << "]=" << " ";
            cin >> a[i][j];
        }
    }
    cout << "Matrica" << endl;
    for (i = 0; i < n; i++){
        for (j = 0; j < m; j++){
            cout << a[i][j] << "  ";
        }
        cout << endl;
    }
    int sum = 0;
    for (i = 0; i < n; i++){
        for (j = 0; j < m; j++){
            sum = a[i][j] + sum;
        }
    }
    cout << "summa elementov massiva =" << sum << endl;
    cout << endl;
    int pr = 0;
    cout << "massiv po usloviu:" << endl;
    for (i = 0; i < n; i++){
        for (j = 0; j < m; j++){
            pr = a[j][i] * a[i][j];
        }
        if (pr > 0){
            cout << "1" << " ";
        }else{
            cout << "0" << " ";
        }
    }
    for (i = 0; i < n; i++)
        delete [] a[i];
        delete [] a;
        return 0;   
}
