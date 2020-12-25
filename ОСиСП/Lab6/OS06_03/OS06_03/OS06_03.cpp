#include <iostream>
#include <Windows.h>

using namespace std;
#define PG (4096)
int pg = 256;

int main()
{
    setlocale(LC_ALL, "rus");

    SYSTEM_INFO system_info;
    GetSystemInfo(&system_info);

    int* m1 = (int*)VirtualAlloc(NULL, pg * PG, MEM_COMMIT, PAGE_READWRITE);
    for (int i = 0; i < pg * PG / 4; i++) // F1-241, F3-243, F0-240, F3F-3903
    {                                   //страница*4*1024*1024
        m1[i] = i;                      //241стр = 1010827264 байт
    }

    int bias = ('S' * system_info.dwPageSize + ('D' << 4) | (('A' & 0xf0) >> 4)) / sizeof(int);
    cout << m1[bias] << endl;

    cout << endl;
}
