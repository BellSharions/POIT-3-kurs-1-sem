#pragma once

#include "ErrorFunctions.h"
struct Contact        
{
	enum TE { 
		EMPTY,          
		ACCEPT,      
		CONTACT          
	}    type;     
	enum ST {          
		WORK,             
		ABORT,           
		TIMEOUT,        
		FINISH        
	}      sthread; 

	SOCKET      s;      
	SOCKADDR_IN prms;     
	int         lprms;   
	HANDLE      hthread;   
	HANDLE      htimer;   

	char msg[50];        
	char srvname[15];       

	Contact(TE t = EMPTY, const char* namesrv = "") 
	{
		memset(&prms, 0, sizeof(SOCKADDR_IN));
		lprms = sizeof(SOCKADDR_IN);
		type = t;
		strcpy(srvname, namesrv);
		msg[0] = 0;
	};

	void SetST(ST sth, const char* m = "")
	{
		sthread = sth;
		strcpy(msg, m);
	}
};

DWORD WINAPI MessageServer(LPVOID pPrm)
{
	DWORD rc = 0;
	Contact *contact = (Contact*)(pPrm);

	cout << "dll v2.0 \ntransmission{\n";
	int lobuf, libuf;
	contact->sthread = contact->WORK;
	if ((libuf = send(contact->s, "start transmission", sizeof("start transmission"), NULL)) == SOCKET_ERROR)
		throw  SetErrorMsgText("recv:", WSAGetLastError());
	int	whenINeedToStop = 1;
	if ((lobuf = recv(contact->s, contact->msg, sizeof(contact->msg), NULL)) == SOCKET_ERROR)
		throw  SetErrorMsgText("recv:", WSAGetLastError());
	cout << "recv:" << contact->msg << endl;
	strcpy(contact->msg, "Hello! It's another dll");
	if ((libuf = send(contact->s, contact->msg, sizeof(contact->msg), NULL)) == SOCKET_ERROR)
		throw  SetErrorMsgText("send:", WSAGetLastError());
	cout << "send:" << contact->msg << endl;
	cout << "end of transmission}\n";
	contact->sthread = contact->FINISH;
	contact->type = contact->EMPTY;
	rc = contact->sthread;
	ExitThread(rc);
}

DWORD WINAPI TimeServer(LPVOID pPrm)
{
	DWORD rc = 0;
	printf("entry to TimeServer function\n");

	ExitThread(rc);
}
