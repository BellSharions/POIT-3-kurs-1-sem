#include <Windows.h>
#include <iostream>

int main(int argc, char* argv[])
{
    setlocale(NULL, "rus");

    std::cout << "MAXSIMUM_PROCESSORS: " << MAXIMUM_PROCESSORS << std::endl;
    std::cout << "IDLE_PRIORITY_CLASS: " << IDLE_PRIORITY_CLASS << std::endl;
    std::cout << "BELOW_NORMAL_PRIORITY_CLASS: " << BELOW_NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "NORMAL_PRIORITY_CLASS: " << NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "ABOVE_NORMAL_PRIORITY_CLASS: " << ABOVE_NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "HIGH_PRIORITY_CLASS: " << HIGH_PRIORITY_CLASS << std::endl;
    std::cout << "REALTIME_PRIORITY_CLASS: " << REALTIME_PRIORITY_CLASS << std::endl << std::endl;

    int P1, P2, P3;
    std::cout << "P1 = "; std::cin >> P1;
    std::cout << "P2 = "; std::cin >> P2;
    std::cout << "P3 = "; std::cin >> P3;

    if (!SetProcessAffinityMask(GetCurrentProcess(), P1)) throw "SetProcessAffinityMask";

    LPCWSTR an = L"D:\\Labs\\ОСиСП\\Lab5\\OS05_02x\\Debug\\OS05_02x.exe";
    STARTUPINFO si, si2;
    PROCESS_INFORMATION pi, pi2;
    ZeroMemory(&si, sizeof(STARTUPINFO)); si.cb = sizeof(STARTUPINFO);
    ZeroMemory(&si2, sizeof(STARTUPINFO)); si2.cb = sizeof(STARTUPINFO);

    if (CreateProcess(an, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | P2, NULL, NULL, &si, &pi))
        std::cout << "Дочерний процесс №1 создан" << std::endl;
    else
        std::cout << "Дочерний процесс №1 НЕ создан" << std::endl;

    if (CreateProcess(an, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE | P3, NULL, NULL, &si2, &pi2))
        std::cout << "Дочерний процесс №2 создан" << std::endl;
    else
        std::cout << "Дочерний процесс №2 НЕ создан" << std::endl;

    WaitForSingleObject(pi.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi2.hProcess);
}