#include <iostream>
#include <cmath>
const double PI = 3.141592653589793;
using namespace std;

int main()
{
	float R,L,D,Si,sum;
	sum=0;
	cout<<"Vvdite radius:";
	cin>>R;
	
	for(D=2*PI/55;D<=20*PI/55;D=D+2*PI/55)
	{
	L=2*R*sin(D/2);
	Si=(L/2)*sqrt((R*R)-((L/2)*(L/2)));
	cout<<"Pri D="<<D<<" ploshad mnogougolnika="<<Si<<'\n';
	}
   sum+=Si;

}
