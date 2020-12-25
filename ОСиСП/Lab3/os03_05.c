#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <iostream>
#include <sys/wait.h>


int main(){
    int pid, status, ret;
    char *myargs [] = { NULL };
    char *myenv [] = { NULL };

    pid = fork();

    if (pid == 0){
        execve ("os03_05_1", myargs, myenv);
    }

    for (int i = 0; i < 10; i++){
        printf("%ld \n", (long)getpid());
	sleep(1);
    }

    if ((ret = waitpid (pid, &status, 0)) == -1)
        printf("parrent:error\n");

    if (ret == pid)
        printf ("Parent: Child process waited for\n");
}
