#include <Windows.h>
#include <iostream>

using namespace std;

CRITICAL_SECTION cs;

DWORD WINAPI A()
{
    DWORD tid = GetCurrentThreadId();
    for (int i = 0; i < 90; i++)
    {
        if (i == 29 || i == 60) EnterCriticalSection(&cs);
        if (i == 59 || i == 61) LeaveCriticalSection(&cs);
        Sleep(100);
        cout << tid << " A " << i << endl;
    }
    return 0;
}

DWORD WINAPI B()
{
    DWORD tid = GetCurrentThreadId();
    for (int i = 0; i < 90; i++)
    {
        if (i == 30 || i == 60) EnterCriticalSection(&cs);
        if (i == 59 || i == 61) LeaveCriticalSection(&cs);
        Sleep(100);
        cout << tid << " B " << i << endl;
    }
    return 0;
}

int main()
{
    InitializeCriticalSection(&cs);

    DWORD ChildId1 = NULL;
    HANDLE hChild1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)A, NULL, 0, &ChildId1);
    DWORD ChildId2 = NULL;
    HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)B, NULL, 0, &ChildId2);

    DWORD tid = GetCurrentThreadId();
    for (int i = 0; i < 90; i++)
    {
        if (i == 31 || i == 61) EnterCriticalSection(&cs);
        if (i == 59) LeaveCriticalSection(&cs);
        Sleep(100);
        cout << tid << " main " << i << endl;
    }

    WaitForSingleObject(hChild1, INFINITE);
    WaitForSingleObject(hChild2, INFINITE);

    DeleteCriticalSection(&cs);
}