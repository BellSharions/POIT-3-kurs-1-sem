#include <Windows.h>
#include <iostream>

DWORD WINAPI os04_02_T1()
{
    for (int i = 0; i < 50; i++)
    {
        std::cout << "ProcessID: " << GetCurrentProcessId() << std::endl;
        std::cout << "T1: " << GetCurrentThreadId() << std::endl << std::endl;
        Sleep(1000);
    }
    return 0;
}

DWORD WINAPI os04_02_T2()
{
    for (int i = 0; i < 125; i++)
    {
        std::cout << "ProcessID: " << GetCurrentProcessId() << std::endl;
        std::cout << "T2: " << GetCurrentThreadId() << std::endl << std::endl;
        Sleep(1000);
    }
    return 0;
}

int main()
{
    DWORD Child1Id = NULL;
    HANDLE hChild1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)os04_02_T1, NULL, 0, &Child1Id);
    DWORD Child2Id = NULL;
    HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)os04_02_T2, NULL, 0, &Child2Id);

    for (int i = 0; i < 100; i++)
    {
        if (i == 19) { SuspendThread(hChild1); std::cout << "Suspend hChild1" << std::endl << std::endl; }
        if (i == 59) { ResumeThread(hChild1); std::cout << "Resume hChild1" << std::endl << std::endl; }
        if (i == 39) { SuspendThread(hChild2); std::cout << "Suspend hChild2" << std::endl << std::endl; }
        std::cout << "ProcessID: " << GetCurrentProcessId() << std::endl << std::endl;
        Sleep(1000);
    }
    ResumeThread(hChild2);
    std::cout << "Resume hChild2" << std::endl << std::endl;

    WaitForSingleObject(hChild1, INFINITE);
    WaitForSingleObject(hChild2, INFINITE);
    CloseHandle(hChild1);
    CloseHandle(hChild2);
}