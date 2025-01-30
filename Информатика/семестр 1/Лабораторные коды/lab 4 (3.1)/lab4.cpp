#include <iostream>
using namespace std;

int main()	
{
    int H = 0;
    int W = 0;
    cout << "Введите количество строк ";
    cin >> H;
    cout << "Введите количество столбцов ";
    cin >> W;
    int * C = new int[H];
    int ** vector = new int* [H];

    for(int i = 0; i < H; i++){
        cout << "С[" << i << "] = ";
        cin >> C[i];
    }

    for(int i = 0; i < H; i++){
        vector[i] = new int [W];
    }

    cout << "Введите массив" << endl;

    for(int j = 0; j < H; j++){
        for(int i = 0; i < W; i++){
            cout << "vector [" << j + 1 << "][" <<  i + 1 << "] = ";
            cin >> vector[j][i];
        }
    }

    for(int j = 0; j < H; j++){
        for(int i = 0; i < W; i++){
            cout << vector[j][i] << " ";
        }
        cout << endl;
    }

	cout << "Изначальная матрица" << endl;

    for(int i = 0; i < H; i++){
        if(vector[i][i] == 0){
            for(int j = 0; j < H; j++){
                vector[j][i] += C[j];
            }
        }
    }

	cout << "Измененная матрица" << endl;

    for(int j = 0; j < H; j++){
        for(int i = 0; i < W; i++){
            cout << vector[j][i] << " ";
        }
        cout << endl;
    }

    for(int i = 0; i < H; i++){
        delete [] vector[i];
    }

    delete [] vector;
    return 0;
}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
