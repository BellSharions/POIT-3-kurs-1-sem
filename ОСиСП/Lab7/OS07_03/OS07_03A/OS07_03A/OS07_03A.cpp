#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
    DWORD pid = GetCurrentProcessId();

    HANDLE hm = OpenMutex(SYNCHRONIZE, FALSE, L"dmtrMutex");
    if (hm == NULL) cout << "OS07_03A: Open Error Mutex" << endl;
    else cout << "OS07_03A: Open Mutex" << endl;

    for (int i = 0; i < 90; i++)
    {
        if (i == 29 || i == 60) WaitForSingleObject(hm, INFINITE);
        if (i == 59 || i == 61) ReleaseMutex(hm);
        Sleep(100);
        cout << pid << " OS07_03A " << i << endl;
    }
    CloseHandle(hm);
}