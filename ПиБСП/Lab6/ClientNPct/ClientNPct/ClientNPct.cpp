#include <iostream>
#include <Windows.h>
using namespace std;
#define PIPE TEXT("\\\\.\\pipe\\Tube")

int main()
{
	DWORD bytes;
	char message[] = "end";
	char buffer[50] = "";
	try
	{
		CallNamedPipe(PIPE, message, sizeof(message), buffer, sizeof(buffer), &bytes, NMPWAIT_WAIT_FOREVER);
		cout << "Get from server: " << buffer << endl;
	}
	catch (string ErrorPipeText)
	{
		cout << endl << ErrorPipeText;
	}
	return 0;
}