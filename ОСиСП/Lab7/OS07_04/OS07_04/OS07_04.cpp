#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
    LPCWSTR an1 = L"D:\\Labs\\ОСиСП\\Lab7\\OS07_04\\OS07_04A\\Debug\\OS07_04A.exe",
        an2 = L"D:\\Labs\\ОСиСП\\Lab7\\OS07_04\\OS07_04B\\Debug\\OS07_04B.exe";
    STARTUPINFO si1, si2;
    PROCESS_INFORMATION pi1, pi2;
    ZeroMemory(&si1, sizeof(STARTUPINFO));
    ZeroMemory(&si2, sizeof(STARTUPINFO));
    si1.cb = sizeof(STARTUPINFO);
    si2.cb = sizeof(STARTUPINFO);

    HANDLE hs = CreateSemaphore(NULL, 2, 2, L"dmtrSem");

    if (CreateProcess(an1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si1, &pi1))
        cout << "Process OS07_04A created" << endl;
    else cout << "Process OS07_04A not created" << endl;

    if (CreateProcess(an2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
        cout << "Process OS07_04B created" << endl;
    else cout << "Process OS07_04B not created" << endl;

    DWORD pid = GetCurrentProcessId();
    LONG prevcount = 0;

    for (int i = 0; i < 90; i++)
    {
        if (i == 30) WaitForSingleObject(hs, INFINITE);
        if (i == 59) ReleaseSemaphore(hs, 1, &prevcount);
        Sleep(100);
        cout << pid << " main " << i << endl;
    }

    WaitForSingleObject(pi1.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);

    CloseHandle(pi1.hProcess);
    CloseHandle(pi2.hProcess);

    CloseHandle(hs);
}