#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
	printf("%d\n", getpid());
	int *block;
    	int n = 100000;
     
    	block = malloc(256*1024*1024);
     
    	printf("%p\n", block);
    	
    	for(int i=0;i<n; i++)
    	{
        	block[i] = i;
    	}
     
    	sleep(1000);
}
