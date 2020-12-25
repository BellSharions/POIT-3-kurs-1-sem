#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
    LPCWSTR an1 = L"D:\\Labs\\ОСиСП\\Lab7\\OS07_03\\OS07_03A\\Debug\\OS07_03A.exe",
            an2 = L"D:\\Labs\\ОСиСП\\Lab7\\OS07_03\\OS07_03B\\Debug\\OS07_03B.exe";
    STARTUPINFO si1, si2;
    PROCESS_INFORMATION pi1, pi2;
    ZeroMemory(&si1, sizeof(STARTUPINFO));
    ZeroMemory(&si2, sizeof(STARTUPINFO));
    si1.cb = sizeof(STARTUPINFO);
    si2.cb = sizeof(STARTUPINFO);

    HANDLE hm = CreateMutex(NULL, FALSE, L"dmtrMutex");

    if (CreateProcess(an1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si1, &pi1))
        cout << "Process OS07_03A created" << endl;
    else cout << "Process OS07_03A not created" << endl;

    if (CreateProcess(an2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
        cout << "Process OS07_03B created" << endl;
    else cout << "Process OS07_03B not created" << endl;

    DWORD tid = GetCurrentThreadId();
    for (int i = 0; i < 90; i++)
    {
        if (i == 31 || i == 61) WaitForSingleObject(hm, INFINITE);
        if (i == 59) ReleaseMutex(hm);
        Sleep(100);
        cout << tid << " main " << i << endl;
    }

    WaitForSingleObject(pi1.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);

    CloseHandle(pi1.hProcess);
    CloseHandle(pi2.hProcess);

    CloseHandle(hm);
}