#include <iostream>//lab6 var 16
 
#include <math.h>
#include <cmath>

using namespace std;
int n, m;
char a = 'A', b = 'B';
int* IN(int s, char z) {
    int* arr = new int [s];
    for (int i = 0; i < s; i++)
    {
        cout << "������� "<<z<<"[" << i << "] =";
        cin >> arr[i];
       
    }
    return arr;

}
void OUT(int arr[], int n,char z)
{
    for (int i = 0; i < n; i++) {
        cout <<z<<"[" << i << "]="<<arr[i]<< ' ';
    }
}

int Func(int arr[],int n) {
    int k = 0;
    for (int i = 0; i < n; i++) {
        if (arr[i] < 0) {
            arr[i] = abs(arr[i]);
            k += 1;
        }
    }
    return k;
}

int main(){

    cout << "������� ������ ������� �: ";
    n = 0;
    cin >> n;
    cout << "������� ������ ������� B: ";
    m = 0;
    cin >> m;
    int* A = IN(n,a);
    cout << "������ � ������" << endl;

    int* B = IN(m,b);
    cout<<"����� ����� � ������� �="<<Func(A,n)<<endl;
   
    if (Func(A, n) < 5) {
        OUT(A, n,a);
    }
    else {
        OUT(B, m,b);
    }
    
    
    delete []A;
    delete []B;
}

