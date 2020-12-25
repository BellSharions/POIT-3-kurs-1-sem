#include <Windows.h>
#include <iostream>

DWORD WINAPI os04_02_T1()
{
    for (int i = 0; i < 50; i++)
    {
        if (i == 24) 
        {
            std::cout << "sleep T1" << std::endl << std::endl;
            Sleep(10000);
            std::cout << "awake T1" << std::endl << std::endl;
        }
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
        if (i == 79)
        {
            std::cout << "sleep T2" << std::endl << std::endl;
            Sleep(15000);
            std::cout << "awake T2" << std::endl << std::endl;
        }
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
        if (i == 29)
        {
            std::cout << "sleep main" << std::endl << std::endl;
            Sleep(10000);
            std::cout << "awake main" << std::endl << std::endl;
        }
        std::cout << "ProcessID: " << GetCurrentProcessId() << std::endl << std::endl;
        Sleep(1000);
    }

    WaitForSingleObject(hChild1, INFINITE);
    WaitForSingleObject(hChild2, INFINITE);
    CloseHandle(hChild1);
    CloseHandle(hChild2);
}