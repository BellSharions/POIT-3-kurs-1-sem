#include <Windows.h>
#include <iostream>
#include <ctime>
#define SECOND 10000000

using namespace std;

int i = 0;
long long it = -0 * SECOND;

DWORD WINAPI ChildThread()
{
    clock_t t1 = clock();
    while (true)
    {
        clock_t t2 = clock();
        if ((t2 - t1) % (CLOCKS_PER_SEC * 3) == 0) { t1 -= 1; cout << i << endl; }
        if ((t2 - t1) / CLOCKS_PER_SEC > 15) { cout << "end: " << i << endl; ExitProcess(0); }
    }
    return 0;
}

int main()
{
    DWORD ChildId = 0;
    HANDLE hChild = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ChildThread, NULL, NULL, &ChildId);
    HANDLE timer = CreateWaitableTimer(NULL, FALSE, NULL);
    if (!SetWaitableTimer(timer, (LARGE_INTEGER*)&it, 1000, NULL, NULL, FALSE)) throw "Error SetWaitableTimer";
    clock_t t1 = clock();
    while (true)
    {
        WaitForSingleObject(timer, INFINITE);
        i++;
    }
}