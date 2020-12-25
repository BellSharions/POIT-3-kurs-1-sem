#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <iostream>
#include <sys/wait.h>


int main(){
    
    system("./os03_05_1");

    for (int i = 0; i < 10; i++){
        printf("%ld \n", (long)getpid());
	sleep(1);
    }

    return 0;
}
