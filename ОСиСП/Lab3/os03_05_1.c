#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <iostream>


int main(){
    for (int i = 0; i < 5; i++)
    {
        printf("%ld %d\n", (long)getpid(), i);
        sleep(1);
    }
    return 0;
}
