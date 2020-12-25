﻿#include <iostream>
#include <Windows.h>
#include <string>
using namespace std;

string  GetErrorMail(int code)    // cформировать текст ошибки 
{
    string msgText;
    switch (code)                      // проверка кода возврата  
    {
    case   WSAEINTR:          msgText = "Работа функции прервана"; break;
    case    WSAEACCES:          msgText = "Разрешение отвергнуто"; break;
    case    WSAEFAULT:          msgText = "Ошибочный адрес"; break;
    case    WSAEINVAL:          msgText = "Ошибка в аргументе"; break;
    case    WSAEMFILE:          msgText = "Слишком много файлов открыто"; break;
    case    WSAEWOULDBLOCK:          msgText = "Ресурс временно недоступен"; break;
    case    WSAEINPROGRESS:          msgText = "Операция в процессе развития"; break;
    case  WSAEALREADY:          msgText = "Операция уже выполняется"; break;
    case   WSAENOTSOCK:          msgText = "Сокет задан неправильно"; break;
    case   WSAEDESTADDRREQ:          msgText = "Требуется адрес расположения"; break;
    case   WSAEMSGSIZE:          msgText = "Сообщение слишком длинное"; break;
    case  WSAEPROTOTYPE:          msgText = "Неправильный тип протокола для сокета"; break;
    case  WSAENOPROTOOPT:          msgText = "Ошибка в опции протокола"; break;
    case WSAEPROTONOSUPPORT:          msgText = "Протокол не поддерживается"; break;
    case WSAESOCKTNOSUPPORT:          msgText = "Тип сокета не поддерживается"; break;
    case  WSAEOPNOTSUPP:          msgText = "Операция не поддерживается"; break;
    case  WSAEPFNOSUPPORT:          msgText = "Тип протоколов не поддерживается"; break;
    case  WSAEAFNOSUPPORT:          msgText = "Тип адресов не поддерживается протоколом"; break;
    case   WSAEADDRINUSE:          msgText = "Адрес уже используется"; break;
    case   WSAEADDRNOTAVAIL:          msgText = "Запрошенный адрес не может быть использован"; break;
    case  WSAENETDOWN:          msgText = "Сеть отключена"; break;
    case  WSAENETUNREACH:          msgText = "Сеть не достижима"; break;
    case  WSAENETRESET:          msgText = "Сеть разорвала соединение"; break;
    case  WSAECONNABORTED:          msgText = "Программный отказ связи"; break;
    case  WSAECONNRESET:          msgText = "Связь восстановлена"; break;
    case  WSAENOBUFS:          msgText = "Не хватает памяти для буферов"; break;
    case   WSAEISCONN:          msgText = "Сокет уже подключен"; break;
    case  WSAENOTCONN:          msgText = "Сокет не подключен"; break;
    case    WSAESHUTDOWN:          msgText = "Нельзя выполнить send : сокет завершил работу"; break;
    case   WSAETIMEDOUT:          msgText = "Закончился отведенный интервал  времени"; break;
    case WSAECONNREFUSED:          msgText = "Соединение отклонено"; break;
    case  WSAEHOSTDOWN:          msgText = "Хост в неработоспособном состоянии"; break;
    case  WSAEHOSTUNREACH:          msgText = "Нет маршрута для хоста"; break;
    case WSAEPROCLIM:          msgText = "Слишком много процессов"; break;
    case WSASYSNOTREADY:          msgText = "Сеть не доступна"; break;
    case WSAVERNOTSUPPORTED:          msgText = "Данная версия недоступна"; break;
    case  WSANOTINITIALISED:          msgText = "Не выполнена инициализация WS2_32.DLL"; break;
    case WSAEDISCON:          msgText = "Выполняется отключение"; break;
    case  WSATYPE_NOT_FOUND:          msgText = "Класс не найден"; break;
    case  WSAHOST_NOT_FOUND:          msgText = "Хост не найден"; break;
    case  WSATRY_AGAIN:          msgText = "Неавторизированный хост не найден"; break;
    case  WSANO_RECOVERY:          msgText = "Неопределенная  ошибка"; break;
    case  WSANO_DATA:          msgText = "Нет записи запрошенного типа"; break;
    case WSASYSCALLFAILURE:          msgText = "Аварийное завершение системного вызова"; break;
    default:                msgText = "***ERROR***";      break;
    };
    return msgText;
};

string SetErrorMail(string msgText, int code)
{
    return msgText + ": " + GetErrorMail(code);
}

#define PIPE TEXT("\\\\.\\pipe\\Tube")

int main()
{
    HANDLE hPipe;
    DWORD dwRead;
    char buffer[50] = "";
    try
    {
        while (true)
        {
            if ((hPipe = CreateNamedPipe(PIPE,
                PIPE_ACCESS_DUPLEX,
                PIPE_TYPE_MESSAGE | PIPE_WAIT,
                1, 
                1024 * 16,	
                1024 * 16,
                INFINITE, NULL)) == INVALID_HANDLE_VALUE)
                throw SetErrorMail("create: ", GetLastError());

            if (!ConnectNamedPipe(hPipe, NULL))
                throw SetErrorMail("connect: ", GetLastError());

            while (true) {  
                
                if (ReadFile(hPipe, buffer, sizeof(buffer), &dwRead, NULL) != FALSE)
                {
                    if (strcmp(buffer, "end") == 0)
                    {
                        WriteFile(hPipe, buffer, sizeof(buffer), &dwRead, NULL);\
                        cout << "Get from Client: " << buffer << endl;
                        break;
                    }
                    cout << "Get from Client: " << buffer << endl;
                    WriteFile(hPipe, buffer, sizeof(buffer), &dwRead, NULL);
                }
            }
            DisconnectNamedPipe(hPipe);
            CloseHandle(hPipe);

            cout << endl;
        }
    }
    catch (string ErrorPipeText)
    {
        cout << endl << ErrorPipeText;
    }
    return 0;
}
