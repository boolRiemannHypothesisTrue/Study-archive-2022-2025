#include <iostream>
#include <cmath>
const double PI = 3.141592653589793;
using namespace std;

int main()

{
	float x, y;
	cout << "¬ведите X:";
	cin >> x;
	cout << "x is equal to" <<endl<< x <<endl;
	y = ((sqrt(abs(sin(x))))/3)*exp(12*x/3000);
	cout <<"y=" <<y;
	return 0;
}


