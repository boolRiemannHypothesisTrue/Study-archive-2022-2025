#include <iostream>
using namespace std;
int main()
{
    double arrayX[200];
    int i, n;
    double p;
    p = 1;
    cout << "hello" << endl;
    cin >> n;
    cout << "hello" << endl;
    for(i = 0; i < n; i++)
    {
        cin >> arrayX[i];
    }
    for(i = 0; i < n; i++) {
        if ((i % 3) == 0) {
            p = p * arrayX[i];
            cout << arrayX[i] << " " << "hello =" << " " << p << endl;
        } else {
            cout << arrayX[i] << endl;
        }
        cout<<"Hello World";
    }


    return 0;
}

