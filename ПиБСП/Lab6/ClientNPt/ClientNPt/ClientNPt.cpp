#include <iostream>
#include <Windows.h>
using namespace std;
#define PIPE TEXT("\\\\.\\pipe\\Tube")

int main()
{
	HANDLE hPipe;
	DWORD bytes;
	char message[50] = "end";
	char buffer[50] = "";
	try
	{
		if ((hPipe = CreateFile(PIPE, GENERIC_READ | GENERIC_WRITE,
			0, NULL, OPEN_EXISTING,
			FILE_ATTRIBUTE_NORMAL, NULL)) == INVALID_HANDLE_VALUE)
			throw "create: " + GetLastError();

		DWORD state = PIPE_READMODE_MESSAGE;
		SetNamedPipeHandleState(hPipe, &state, NULL, NULL);

		TransactNamedPipe(hPipe, message, sizeof(message), buffer, sizeof(buffer), &bytes, NULL);
		cout << "Get from server: " << buffer << endl;

		CloseHandle(hPipe);
	}
	catch (string ErrorPipeText)
	{
		cout << endl << ErrorPipeText;
	}
	return 0;
}