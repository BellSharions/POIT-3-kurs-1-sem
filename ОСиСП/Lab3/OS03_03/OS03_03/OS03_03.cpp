#include <Windows.h>
#include <iostream>
#include <TlHelp32.h>
#include <iomanip>

int main()
{
	DWORD pid = GetCurrentProcessId();
	HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
	PROCESSENTRY32 peProcessEntry;
	peProcessEntry.dwSize = sizeof(PROCESSENTRY32);

	std::wcout << L"Current PID = " << pid << std::endl << L"-----------------------" << std::endl;
	try
	{
		if (!Process32First(snap, &peProcessEntry)) throw L"Process32First";
		do
		{
			std::wcout << L"Name = " << peProcessEntry.szExeFile << std::endl
					   << L"PID = " << peProcessEntry.th32ProcessID
					   << L", ParentPID = " << peProcessEntry.th32ParentProcessID;
			if (peProcessEntry.th32ProcessID == pid) std::cout << "--> current process";
			std::wcout << std::endl << L"-----------------------" << std::endl;
		} while (Process32Next(snap, &peProcessEntry));
	}
	catch (char* msg) { std::wcout << L"ERROR: " << msg << std::endl; }

	system("pause");
}