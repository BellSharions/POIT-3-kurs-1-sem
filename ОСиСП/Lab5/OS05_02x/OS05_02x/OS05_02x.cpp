#include <Windows.h>
#include <iostream>

int main()
{
    setlocale(NULL, "rus");
    
    unsigned long long d = MAXULONGLONG / 1000000000000000;
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
}
