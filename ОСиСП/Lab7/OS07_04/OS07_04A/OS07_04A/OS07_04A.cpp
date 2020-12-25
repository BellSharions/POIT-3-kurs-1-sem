#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
    DWORD pid = GetCurrentProcessId();

    HANDLE hs = OpenSemaphore(SEMAPHORE_ALL_ACCESS, FALSE, L"dmtrSem");
    if (hs == NULL) cout << "OS07_04A: Open Error Sem" << endl;
    else cout << "OS07_04A: Open Sem" << endl;
    LONG prevcount = 0;

    for (int i = 0; i < 90; i++)
    {
        if (i == 29) WaitForSingleObject(hs, INFINITE);
        if (i == 59) ReleaseSemaphore(hs, 1, &prevcount);
        Sleep(100);
        cout << pid << " OS07_04A " << i << endl;
    }
    CloseHandle(hs);
}