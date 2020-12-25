#include <Windows.h>
#include <iostream>

int main()
{
    for (int i = 0; i < 100; i++)
    {
        std::cout << "ProcessID: " << GetCurrentProcessId() << std::endl;
        std::cout << "ThreadID: " << GetCurrentThreadId() << std::endl << std::endl;
        Sleep(1000);
    }
}
