#include <iostream>
#include <Windows.h>

int main()
{
    LPCWSTR an1 = L"D:\\Labs\\ОСиСП\\Lab3\\OS03_02\\OS03_02_01\\Debug\\OS03_02_01.exe",
            an2 = L"D:\\Labs\\ОСиСП\\Lab3\\OS03_02\\OS03_02_02\\Debug\\OS03_02_02.exe";
    STARTUPINFO si1, si2;
    PROCESS_INFORMATION pi1, pi2;
    ZeroMemory(&si1, sizeof(STARTUPINFO)); si1.cb = sizeof(STARTUPINFO);
    ZeroMemory(&si2, sizeof(STARTUPINFO)); si2.cb = sizeof(STARTUPINFO);

    if (CreateProcess(an1, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si1, &pi1))
        std::cout << "-- Process OS03_02_01 created\n";
    else 
        std::cout << "-- Process OS03_02_01 not created\n";

    if (CreateProcess(an2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
        std::cout << "-- Process OS03_02_02 created\n";
    else
        std::cout << "-- Process OS03_02_02 not created\n";

    for (int i = 0; i < 100; i++)
    {
        Sleep(1000);
        std::cout << GetCurrentProcessId() << std::endl;
    }

    WaitForSingleObject(pi1.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);
    CloseHandle(pi1.hProcess);
    CloseHandle(pi2.hProcess);

}
