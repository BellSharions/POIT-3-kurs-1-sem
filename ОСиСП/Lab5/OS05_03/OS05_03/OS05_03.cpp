#include <Windows.h>
#include <iostream>

DWORD WINAPI TA()
{
    unsigned long long d = MAXULONGLONG / 1000000000000;
    int k = 0;

    for (unsigned long long i = 0; i < MAXULONGLONG; i++)
    {
        if (i % d == 0)
        {
            std::cout << "Номер итерации: " << ++k << " - " << i << std::endl;
            std::cout << "ID процесса: " << GetCurrentProcessId() << std::endl;
            std::cout << "ID потока: " << GetCurrentThreadId() << std::endl;
            std::cout << "Приоритет процесса: ";
            switch (GetPriorityClass(GetCurrentProcess()))
            {
            case IDLE_PRIORITY_CLASS: std::cout << "IDLE_PRIORITY_CLASS" << std::endl; break;
            case BELOW_NORMAL_PRIORITY_CLASS: std::cout << "BELOW_NORMAL_PRIORITY_CLASS" << std::endl; break;
            case NORMAL_PRIORITY_CLASS: std::cout << "NORMAL_PRIORITY_CLASS" << std::endl; break;
            case ABOVE_NORMAL_PRIORITY_CLASS: std::cout << "ABOVE_NORMAL_PRIORITY_CLASS" << std::endl; break;
            case HIGH_PRIORITY_CLASS: std::cout << "HIGH_PRIORITY_CLASS" << std::endl; break;
            case REALTIME_PRIORITY_CLASS: std::cout << "REALTIME_PRIORITY_CLASS" << std::endl; break;
            }
            std::cout << "Приоритет потока: ";
            switch (GetThreadPriority(GetCurrentThread()))
            {
            case THREAD_PRIORITY_LOWEST: std::cout << "THREAD_PRIORITY_LOWEST" << std::endl; break;
            case THREAD_PRIORITY_BELOW_NORMAL: std::cout << "THREAD_PRIORITY_BELOW_NORMAL" << std::endl; break;
            case THREAD_PRIORITY_NORMAL: std::cout << "THREAD_PRIORITY_NORMAL" << std::endl; break;
            case THREAD_PRIORITY_ABOVE_NORMAL: std::cout << "THREAD_PRIORITY_ABOVE_NORMAL" << std::endl; break;
            case THREAD_PRIORITY_HIGHEST: std::cout << "THREAD_PRIORITY_HIGHEST" << std::endl; break;
            case THREAD_PRIORITY_IDLE: std::cout << "THREAD_PRIORITY_IDLE" << std::endl; break;
            case THREAD_PRIORITY_TIME_CRITICAL: std::cout << "THREAD_PRIORITY_TIME_CRITICAL" << std::endl; break;
            }
            std::cout << "Номер процессора: " << SetThreadIdealProcessor(GetCurrentThread(), MAXIMUM_PROCESSORS) << std::endl << std::endl;
        }
    }
    return 0;
}

int main()
{
	setlocale(NULL, "rus");

    std::cout << "MAXSIMUM_PROCESSORS: " << MAXIMUM_PROCESSORS << std::endl;
    std::cout << "IDLE_PRIORITY_CLASS: " << IDLE_PRIORITY_CLASS << std::endl;
    std::cout << "BELOW_NORMAL_PRIORITY_CLASS: " << BELOW_NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "NORMAL_PRIORITY_CLASS: " << NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "ABOVE_NORMAL_PRIORITY_CLASS: " << ABOVE_NORMAL_PRIORITY_CLASS << std::endl;
    std::cout << "HIGH_PRIORITY_CLASS: " << HIGH_PRIORITY_CLASS << std::endl;
    std::cout << "REALTIME_PRIORITY_CLASS: " << REALTIME_PRIORITY_CLASS << std::endl << std::endl;

    std::cout << "THREAD_PRIORITY_LOWEST: " << THREAD_PRIORITY_LOWEST << std::endl;
    std::cout << "THREAD_PRIORITY_BELOW_NORMAL: " << THREAD_PRIORITY_BELOW_NORMAL << std::endl;
    std::cout << "THREAD_PRIORITY_NORMAL: "  << THREAD_PRIORITY_NORMAL << std::endl;
    std::cout << "THREAD_PRIORITY_ABOVE_NORMAL: "  << THREAD_PRIORITY_ABOVE_NORMAL << std::endl;
    std::cout << "THREAD_PRIORITY_HIGHEST: " << THREAD_PRIORITY_HIGHEST << std::endl;
    std::cout << "THREAD_PRIORITY_IDLE: " << THREAD_PRIORITY_IDLE << std::endl;
    std::cout << "THREAD_PRIORITY_TIME_CRITICAL: "  << THREAD_PRIORITY_TIME_CRITICAL << std::endl;

    int P1, P2, P3, P4;
    std::cout << "P1 = "; std::cin >> P1;
    std::cout << "P2 = "; std::cin >> P2;
    std::cout << "P3 = "; std::cin >> P3;
    std::cout << "P4 = "; std::cin >> P4;

    if (!SetProcessAffinityMask(GetCurrentProcess(), P1)) throw "SetProcessAffinityMask";
    SetPriorityClass(GetCurrentProcess(), P2);

    DWORD ChildId1 = NULL, ChildId2 = NULL;
    HANDLE hChild1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &ChildId1);
    HANDLE hChild2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)TA, NULL, CREATE_SUSPENDED, &ChildId2);

    SetThreadPriority(hChild1, P3);
    SetThreadPriority(hChild2, P4);

    ResumeThread(hChild1);
    ResumeThread(hChild2);

    WaitForSingleObject(hChild1, INFINITE);
    WaitForSingleObject(hChild2, INFINITE);
    CloseHandle(hChild1);
    CloseHandle(hChild2);
}