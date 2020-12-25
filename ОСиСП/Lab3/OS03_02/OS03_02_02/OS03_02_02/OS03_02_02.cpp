#include <iostream>
#include <Windows.h>

int main()
{
    for (int i = 0; i < 125; i++)
    {
        Sleep(1000);
        std::cout << GetCurrentProcessId() << std::endl;
    }
}