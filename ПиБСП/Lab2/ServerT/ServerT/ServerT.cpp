#define _WINSOCK_DEPRECATED_NO_WARNINGS
#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <string>

#include "Winsock2.h"
#include <ctime>
#pragma comment(lib, "WS2_32.lib")

using namespace std;

// -- Получить диагностирующий код ошибки 
// Назначение: функция позволяет определить причину
//             завершения функций Winsock2 с ошибкой
//int WSAGetLastError(void); -----------------        
// Код возврата: функция возвращает диагностический код  

// -- инициализировать библиотеку WS2_32.DLL
// Назначение: функция  позволяет инициализировать 
//             динамическую библиотеку, проверить номер
//             версии, получить сведения о конкретной    
//             реализации библиотеки. Функция должна быть 
//             выполнена до использования любой функции
//             Windows Sockets
//
//int WSAStartup( -----------------
//    WORD         ver,  //[in]  версия  Windows Sockets  
//    lpWSAData    wsd   //[out] указатель на WSADATA 
//);
// Код возврата: в случае успешного завершения функция 
//               возвращает нулевое значение, в случае ошибки 
//               возвращается не нулевое  значение       
// Примечания: - параметр ver представляет собой два байта,
//               содержащих номер версии Windows Sockets,
//               причем.  старший байт содержит
//               младший номер версии, а младший байт- 
//               старший номер версии;
//             - обычно параметр ver задается с помощью макро MAKEWORD; 
//             - шаблон структуры WSADATA содержится в 
//               Winsock2.h

// -- завершить  работу с библиотекой  WS2_32.DLL
// Назначение: функция завершает работу с динамической  
//             библиотекой WS2_32.DLL, делает недоступным
//             выполнение функций библиотеки, освобождает    
//             ресурсы.   
//int WSACleanup(void); -----------------
// Код возврата: в случае успешного завершения функция 
//               возвращает нулевое значение, в случае ошибки 
//               возвращается SOCKET_ERROR       

// -- создать сокет 
// Назначение: функция  позволяет создать сокет (точнее
//             дескриптор сокета) и задать его характеристики 
//
//SOCKET socket(
//    int    af,   //[in]  формат адреса  
//    int    type, //[in]  тип сокета   
//    int    prot  //[in]  протокол
//);
// Код возврата: в случае успешного завершения функция 
//               возвращает дескриптор сокета, в другом   
//               случае возвращается INVALID_SOCKET       
// Примечания: - параметр af для стека TCP/IP принимает
//               значение AF_INET;
//             - параметр type может принимать два значения: 
//               SOCK_DGRAM – сокет, ориентированный на
//               сообщения(UDP); SOCK_STREEM – сокет 
//               ориентированный на поток;    
//               старший номер версии;
//             - параметр prot определяет  протокол 
//               транспортного уровня: для TCP/IP можно 
//               указать NULL   

// -- закрыть существующий  сокет 
// Назначение: переводит сокет в неработоспособное состояние и
//             освобождает все ресурсы связанные с ним  
//
//SOCKET closesocket(
//    SOCKET s,    //[in] дескриптор сокета   
//    );
// Код возврата: в случае успешного завершения функция 
//               возвращает нуль, в другом случае  
//               возвращается SOCKET_ERROR  

// -- связать сокет с параметрами
// Назначение: функция связывает существующий сокет с   
//             с параметрами, находящимися в структуре  
//             SOCKADDR_IN    
//
//int bind(
//    SOCKET s,                    //[in] сокет
//    cost struct sockaddr_in* a, //[in] указатель на SOCKADDR_IN
//    int    la                    //[in] длина SOCKADDR_IN в байтах
//)
// Код возврата: в случае успешного завершения функция 
//               возвращает нуль, в случае ошибки 
//               возвращается SOCKET_ERROR       

// -- преобразовать  u_short в формат TCP/IP
// Назначение: функция преобразовывает два байта данных 
//             формата u_short (unsigned  short) в два 
//             два байта, сетевого формата   
//
//u_short htons(
//    u_short hp   //[in] 16 битов данных  
//);
//                
// Код возврата: 16  битов в формате TCP/IP
//                    

// -- преобразовать символьное представление  IPv4-адреса  в формат TCP/IP 
// Назначение: функция преобразует общепринятое символьное   
//             представление IPv4-адреса (n.n.n.n) в 
//             четырехбайтовый IP-адрес в формате TCP/IP    
//
//unsigned long inet_addr(
//    const char* stra //[in] строка символов, закачивающаяся 0x00               
//);
//
// Код возврата: в случае успешного завершения функция 
//               IP-адрес в формате TCP/IP, иначе  
//               возвращается INADDR_NONE       

// -- переключить сокет в режим прослушивания
// Назначение: функция делает сокет доступным для подключений
//             и устанавливает максимальную длину очереди 
//             подключений 
//int listen(
//    SOCKET s,    //[in] дескриптор связанного сокета
//    int    mcq,  //[in] максимальная длина очереди                 
//    );
// Код возврата: при успешном завершении функция возвращает 
//               нуль, иначе возвращается значение 
//               SOCKET_ERROR 
// Примечания:   для установки значения параметра mcq можно 
//               использовать константу SOMAXCONN,позволяющую
//               установить максимально возможное значение  

// -- разрешить подключение к сокету
// Назначение: функция используется для создания канала на 
//             стороне сервера и создает сокет для обмена  
//             данными по  этому каналу  
//SOKET accept(
//    SOCKET s,             // [in]  дескриптор связанного сокета
//    struct sockaddr_in* a,//[out] указатель на SOCKADDR_IN 
//    int* la               //[out] указатель на длину SOCKADDR_IN                 
//);
// Код возврата: при успешном завершении функция возвращает 
//               дескриптор нового сокета, предназначенного
//               для обмена данными по этому каналу, иначе 
//               возвращается значение INVALID_SOCKET 
// Примечания:   в случае успешного выполнения функции, 
//               указатель a содержит адрес структуры 
//               SOCKADDR_IN  с параметрами сокета, 
//               осуществившего подключение (connect)сокета,
//               a указатель la содержит адрес 4-х байт с 
//               длинной (в байтах) структуры SOCKADDR_IN        

// -- отправить данные по установленному каналу
// Назначение: функция пересылает заданное  количество
//             байт данных по каналу определенного сокета  
//int send(
//    SOCKET s,        // [in] дескриптор сокета (канал для передачи) 
//    const char* buf, // [in] указатель буфер данных
//    int  lbuf,       // [in] количество байт данных в буфере
//    int  flags       // [in] индикатор особого режима маршрутизации      
//);
// Код возврата: при успешном завершении функция возвращает 
//               количество переданных байт данных, иначе 
//               возвращается SOCKET_ERROR 
// Примечания:   для параметра flags следует установить    
//               значение NULL    

// -- принять данные по установленному каналу
// Назначение: функция принимает заданное  количество
//             байт данных по каналу определенного сокета  
//int recv(
//    SOCKET s,        // [in] дескриптор сокета (канал для приема) 
//    const char* buf, // [in] указатель буфер данных
//    int  lbuf,       // [in] количество байт данных в буфере
//    int  flags       // [in] индикатор  
//);
// Код возврата: при успешном завершении функция возвращает 
//               количество принятых  байт данных, иначе 
//               возвращается SOCKET_ERROR 
// Примечания:   параметр flags  определяет режим обработки       
//               буфера: NULL -  входной буфер очищается 
//               после считывания данных (рекомендуется),
//               MSG_PEEK – входной буфер не очищается 


string  GetErrorMsgText(int code)    // cформировать текст ошибки 
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
    case  WSA_INVALID_HANDLE:          msgText = "Указанный дескриптор события  с ошибкой"; break;
    case   WSA_INVALID_PARAMETER:          msgText = "Один или более параметров с ошибкой"; break;
    case  WSA_IO_INCOMPLETE:          msgText = "Объект ввода - вывода не в сигнальном состоянии"; break;
    case  WSA_IO_PENDING:          msgText = "Операция завершится позже"; break;
    case  WSA_NOT_ENOUGH_MEMORY:          msgText = "Не достаточно памяти"; break;
    case  WSA_OPERATION_ABORTED:          msgText = "Операция отвергнута"; break;
        /*case  WSAINVALIDPROCTABLE:          msgText = "Ошибочный сервис"; break;
        case   WSAINVALIDPROVIDER:          msgText = "Ошибка в версии сервиса"; break;
        case  WSAPROVIDERFAILEDINIT:          msgText = "Невозможно инициализировать сервис"; break;*/
    case WSASYSCALLFAILURE:          msgText = "Аварийное завершение системного вызова"; break;
    default:                msgText = "***ERROR***";      break;
    };
    return msgText;
};

string  SetErrorMsgText(string msgText, int code)
{
    return  msgText + GetErrorMsgText(code);
};

int main()
{
    setlocale(LC_ALL, "Russian");
    SOCKET  sS;           // дескриптор сокета 
    WSADATA wsaData;
    try
    {
        if (WSAStartup(MAKEWORD(2, 0), &wsaData) != 0)
            throw  SetErrorMsgText("Startup:", WSAGetLastError());
        if ((sS = socket(AF_INET, SOCK_STREAM, NULL)) == INVALID_SOCKET)
            throw  SetErrorMsgText("socket:", WSAGetLastError());

        SOCKADDR_IN serv;                     // параметры  сокета sS
        serv.sin_family = AF_INET;           // используется IP-адресация  
        serv.sin_port = htons(2000);          // порт 2000
        serv.sin_addr.s_addr = INADDR_ANY;   // любой собственный IP-адрес 

        if (bind(sS, (LPSOCKADDR)&serv, sizeof(serv)) == SOCKET_ERROR)
            throw  SetErrorMsgText("bind:", WSAGetLastError());

        if (listen(sS, SOMAXCONN) == SOCKET_ERROR)
            throw  SetErrorMsgText("listen:", WSAGetLastError());

        while (1)
        {
            SOCKET cS;	                 // сокет для обмена данными с клиентом 
            SOCKADDR_IN clnt;             // параметры  сокета клиента
            memset(&clnt, 0, sizeof(clnt)); // обнулить память
            int lclnt = sizeof(clnt);    // размер SOCKADDR_IN

            if ((cS = accept(sS, (sockaddr*)&clnt, &lclnt)) == INVALID_SOCKET)
                throw  SetErrorMsgText("accept:", WSAGetLastError());

            std::cout << std::endl << "IP-client: " << inet_ntoa(clnt.sin_addr);
            std::cout << std::endl << "Port-client: " << clnt.sin_port << endl;

            clock_t start = clock();
            while (1)
            {
                char message[50] = "";
                if ((recv(cS, message, sizeof(message), NULL)) == SOCKET_ERROR)
                    throw  SetErrorMsgText("recv:", WSAGetLastError());

                std::cout << std::endl << "от клиента: " << message;
                if (strcmp(message, "end") == 0)
                    break;

                if ((send(cS, message, strlen(message) + 1, NULL)) == SOCKET_ERROR)
                    throw  SetErrorMsgText("send:", WSAGetLastError());
            }
            clock_t finish = clock();
            std::cout << std::endl << "Затраченное время: " << finish - start << endl << endl;
        }

        if (closesocket(sS) == SOCKET_ERROR)
            throw  SetErrorMsgText("closesocket:", WSAGetLastError());
        if (WSACleanup() == SOCKET_ERROR)
            throw  SetErrorMsgText("Cleanup:", WSAGetLastError());
    }
    catch (string errorMsgText)
    {
        cout << endl << errorMsgText;
    }
    cout << endl << endl;
    system("pause");
}
